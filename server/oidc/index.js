import auth from '../shared/auth/index.js';
import { fileURLToPath, URL } from 'node:url';
import { BAD_REQUEST } from 'http-status-codes';
import express from 'express';
import get from 'lodash/get.js';
import { errors as OIDCError } from 'openid-client';
import path from 'node:path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const router = express.Router();

const ACCESS_DENIED_ROUTE = '/#/login?accessDenied=';

const OIDCErrors = [
  OIDCError.OPError,
  OIDCError.RPError
];
const scope = ['openid', 'profile', 'email'].join(' ');

const isSilentAuth = ({ query }) => query.silent === 'true';
const isResign = ({ query }) => query.resign === 'true';
const isLogoutRequest = ({ query }) => query.action === 'logout';
const isActiveStrategy = ({ authData = {} }) => authData.strategy === 'oidc';

const getPromptParams = req => {
  if (isResign(req)) return { prompt: 'login' };
  if (isSilentAuth(req)) return { prompt: 'none' };
  return {};
};

const getSilentAuthParams = req => {
  if (!isSilentAuth(req)) return {};
  const strategy = req.passport.strategy('oidc');
  const callbackUri = new URL(strategy.options.callbackURL);
  callbackUri.searchParams.set('silent', 'true');
  const idToken = get(req.authData, 'oidc.tokenSet.id_token');
  return { redirect_uri: callbackUri.href, id_token_hint: idToken };
};

const isOIDCError = err => OIDCErrors.some(Ctor => err instanceof Ctor);

router
  .get('/', authRequestHandler)
  .get('/callback', idpCallbackHandler, (_, res) => res.redirect('/'))
  .use(accessDeniedHandler, defaultErrorHandler);

export default {
  path: '/oidc',
  router
};

// Initiate login and logout actions
function authRequestHandler(req, res, next) {
  const strategy = req.passport.strategy('oidc');
  if (isLogoutRequest(req)) return strategy.logout()(req, res, next);
  const params = {
    session: true,
    scope,
    ...getPromptParams(req),
    ...getSilentAuthParams(req)
  };
  return auth.authenticate('oidc', params)(req, res, next);
}

// Triggered upon OIDC provider response
function idpCallbackHandler(req, res, next) {
  // Treat as logout if explicitly flagged OR if the callback has no code/error
  // (Auth0 may strip ?action=logout from the returnTo URL if not whitelisted)
  if (isLogoutRequest(req) || (!req.query.code && !req.query.error)) {
    return auth.logout({ middleware: true })(req, res, next);
  }
  return login(req, res, next);
}

function accessDeniedHandler(err, req, res, next) {
  if (!isOIDCError(err) && !isSilentAuth(req)) {
    return res.redirect(ACCESS_DENIED_ROUTE + (err?.email ?? ''));
  }
  if (isSilentAuth(req) && isActiveStrategy(req)) {
    return auth.logout({ middleware: true })(req, res, () => next(err));
  }
  return next(err);
}

function defaultErrorHandler(err, _req, res, _next) {
  const template = path.resolve(__dirname, './error.mustache');
  const status = err.status || BAD_REQUEST;
  return res.render(template, err, (_, html) => res.status(status).send(html));
}

function login(req, res, next) {
  const params = {
    session: true,
    setCookie: true,
    ...(isSilentAuth(req) && getSilentAuthParams(req))
  };
  auth.authenticate('oidc', params)(req, res, err => {
    if (err) return next(err);
    if (!isSilentAuth(req)) return res.redirect('/');
    const template = path.resolve(__dirname, './authenticated.mustache');
    return res.render(template);
  });
}
