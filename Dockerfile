FROM node:20.3.1-bullseye AS base
RUN apt-get update && apt-get install -y --no-install-recommends dumb-init && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["dumb-init", "--"]

FROM base AS configure
WORKDIR /usr/src/app

# Copy package files first for better Docker layer caching
COPY --chown=node:node package.json ./

# Install dependencies - use force flag to handle platform issues
RUN npm install --omit=dev --legacy-peer-deps --ignore-scripts --force

# Install runtime CLI tools globally and link to local node_modules  
RUN npm install -g sequelize-cli@6.6.2 && \
    mkdir -p node_modules && \
    ln -sf /usr/local/lib/node_modules/sequelize-cli node_modules/sequelize-cli

# Copy application files (config files copied directly from host for reliability)
COPY --chown=node:node sequelize.config.js ./
COPY --chown=node:node tailor.config.js ./
COPY --chown=node:node common ./common
COPY --chown=node:node config ./config
COPY --chown=node:node extensions ./extensions
COPY --chown=node:node server ./server
COPY --chown=node:node client ./client

# Copy built client assets (created by 'npm run build' in CI)
COPY --chown=node:node dist ./dist

FROM configure AS run
ENV NODE_ENV=production
USER node
CMD ["sh", "-c", "npm run db migrate && node -r ./server/script/preflight ./server/index.js"]
