FROM node:20.3.1-bullseye-slim AS base
RUN apt update && apt install -y --no-install-recommends dumb-init
ENTRYPOINT ["dumb-init", "--"]

FROM node:20.3.1-bullseye-slim AS install
WORKDIR /usr/src/app
ENV NODE_ENV=production
COPY package*.json .
RUN npm ci --only=production

FROM base AS configure
WORKDIR /usr/src/app
COPY --chown=node:node --from=install /usr/src/app/node_modules ./node_modules
COPY --chown=node:node package.json sequelize.config.js tailor.config.js ./
COPY --chown=node:node common ./common
COPY --chown=node:node config ./config
COPY --chown=node:node extensions ./extensions
COPY --chown=node:node server ./server
COPY --chown=node:node dist ./dist

FROM configure AS run
ENV NODE_ENV=production
USER node

CMD ["sh", "-c", "npm run db migrate && node -r ./server/script/preflight ./server/index.js"]

