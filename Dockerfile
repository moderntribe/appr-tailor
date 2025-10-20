FROM node:14.21.3-bullseye-slim AS base
RUN apt-get update && apt-get install -y --no-install-recommends dumb-init && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["dumb-init", "--"]

FROM node:14.21.3 AS install
WORKDIR /usr/src/app
ENV NODE_ENV production
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
ENV NODE_ENV production
USER node
CMD npm run db migrate && node -r ./server/script/preflight ./server/index.js
