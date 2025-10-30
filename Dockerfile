FROM node:20.3.1-bullseye AS base
RUN apt-get update && apt-get install -y --no-install-recommends dumb-init && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["dumb-init", "--"]

FROM base AS install
WORKDIR /usr/src/app
ENV NODE_ENV=production
COPY package-lock.json package.json ./
COPY sequelize.config.js ./
COPY tailor.config.js ./
COPY packages ./packages
COPY common ./common
COPY config ./config
COPY extensions ./extensions
COPY server ./server
COPY client ./client
COPY lerna.json ./
RUN npm install --legacy-peer-deps --include=dev

FROM base AS configure
WORKDIR /usr/src/app
COPY --from=install --chown=node:node /usr/src/app /usr/src/app
RUN chown -R node:node /usr/src/app
RUN ls -la /usr/src/app
# COPY --from=install --chown=node:node /usr/src/app/node_modules ./node_modules
# COPY --from=install --chown=node:node /usr/src/app/package.json ./
# COPY --from=install --chown=node:node /usr/src/app/common ./common
# COPY --from=install --chown=node:node /usr/src/app/config ./config
# COPY --from=install --chown=node:node /usr/src/app/extensions ./extensions
# COPY --from=install --chown=node:node /usr/src/app/server ./server
# COPY --from=install --chown=node:node /usr/src/app/client ./client
# COPY --chown=node:node sequelize.config.js ./
# COPY --chown=node:node tailor.config.js ./
# COPY dist ./dist
ENV PATH=/usr/src/app/node_modules/.bin:$PATH

FROM configure AS run
ENV NODE_ENV=production
USER node
CMD ["sh", "-c", "npx sequelize-cli db:migrate && node -r ./server/script/preflight ./server/index.js"]
