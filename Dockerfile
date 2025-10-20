FROM node:14.21.3-bullseye-slim AS base
RUN apt-get update && apt-get install -y --no-install-recommends dumb-init && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["dumb-init", "--"]

FROM base AS install
WORKDIR /usr/src/app
ENV NODE_ENV=production
COPY package*.json ./
COPY packages ./packages
COPY common ./common
COPY config ./config
COPY extensions ./extensions
COPY server ./server
COPY client ./client
RUN npm ci --only=production --legacy-peer-deps

FROM base AS configure
WORKDIR /usr/src/app
COPY --from=install --chown=node:node /usr/src/app/node_modules ./node_modules
COPY --from=install --chown=node:node /usr/src/app/package.json ./
COPY --from=install --chown=node:node /usr/src/app/common ./common
COPY --from=install --chown=node:node /usr/src/app/config ./config
COPY --from=install --chown=node:node /usr/src/app/extensions ./extensions
COPY --from=install --chown=node:node /usr/src/app/server ./server
COPY --from=install --chown=node:node /usr/src/app/client ./client
COPY --from=install --chown=node:node /usr/src/app/dist ./dist
# COPY --chown=node:node --from=install /usr/src/app/node_modules ./node_modules
# COPY --chown=node:node package.json sequelize.config.js tailor.config.js ./
# COPY --chown=node:node common ./common
# COPY --chown=node:node config ./config
# COPY --chown=node:node extensions ./extensions
# COPY --chown=node:node server ./server
COPY --chown=node:node dist ./dist

FROM configure AS run
ENV NODE_ENV=production
USER node
CMD ["sh", "-c", "npm run db migrate && node -r ./server/script/preflight ./server/index.js"]
