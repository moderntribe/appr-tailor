'use strict';

require('dotenv').config();
const path = require('path');

// For CLI compatibility, we need to export a proper config format
const config = {
  development: {
    database: process.env.DATABASE_NAME,
    username: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    host: process.env.DATABASE_HOST,
    port: process.env.DATABASE_PORT,
    dialect: process.env.DATABASE_ADAPTER || 'postgres'
  },
  production: {
    database: process.env.DATABASE_NAME,
    username: process.env.DATABASE_USER,
    password: process.env.DATABASE_PASSWORD,
    host: process.env.DATABASE_HOST,
    port: process.env.DATABASE_PORT,
    dialect: process.env.DATABASE_ADAPTER || 'postgres'
  }
};

module.exports = {
  ...config,
  'seeders-path': path.join(__dirname, './server/shared/database/seeds'),
  'migrations-path': path.join(__dirname, './server/shared/database/migrations'),
  // Also export for application use
  migrationsPath: path.join(__dirname, './server/shared/database/migrations'),
  seedersPath: path.join(__dirname, './server/shared/database/seeds')
};
