variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "staging"
}

variable "region" {
  default = "us-east-1"
}

variable "tailor_acm_certificate_arn" {
  default = "arn:aws:acm:us-east-1:902864695929:certificate/8b8110c8-5c49-497f-916a-8e38ecd3e368"
}

variable "tailor_server_secrets" {
  description = "List of server secret names for Tailor"
  type        = map(string)
  default = {
    AUTH_JWT_ISSUER                = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/AUTH_JWT_ISSUER"
    AUTH_JWT_SCHEME                = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/AUTH_JWT_SCHEME"
    AUTH_JWT_SECRET                = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/AUTH_JWT_SECRET"
    AUTH_SALT_ROUNDS               = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/AUTH_SALT_ROUNDS"
    CORS_ALLOWED_ORIGINS           = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/CORS_ALLOWED_ORIGINS"
    EMAIL_HOST                     = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/EMAIL_HOST"
    EMAIL_PASSWORD                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/EMAIL_PASSWORD"
    EMAIL_SENDER_ADDRESS           = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/EMAIL_SENDER_ADDRESS"
    EMAIL_SENDER_NAME              = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/EMAIL_SENDER_NAME"
    EMAIL_SSL                      = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/EMAIL_SSL"
    EMAIL_USER                     = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/EMAIL_USER"
    FLAT_REPO_STRUCTURE            = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/FLAT_REPO_STRUCTURE"
    FORCE_COLOR                    = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/FORCE_COLOR"
    LOG_LEVEL                      = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/LOG_LEVEL"
    OIDC_ALLOW_SIGNUP              = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_ALLOW_SIGNUP"
    OIDC_AUTHORIZATION_ENDPOINT    = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_AUTHORIZATION_ENDPOINT"
    OIDC_CLIENT_ID                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_CLIENT_ID"
    OIDC_CLIENT_SECRET             = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_CLIENT_SECRET"
    OIDC_DEFAULT_ROLE              = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_DEFAULT_ROLE"
    OIDC_ENABLED                   = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_ENABLED"
    OIDC_ISSUER                    = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_ISSUER"
    OIDC_JWKS_URL                  = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_JWKS_URL"
    OIDC_LOGOUT_ENABLED            = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_LOGOUT_ENABLED"
    OIDC_LOGOUT_ENDPOINT           = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_LOGOUT_ENDPOINT"
    OIDC_POST_LOGOUT_URI_KEY       = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_POST_LOGOUT_URI_KEY"
    OIDC_TOKEN_ENDPOINT            = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_TOKEN_ENDPOINT"
    OIDC_USERINFO_ENDPOINT         = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/OIDC_USERINFO_ENDPOINT"
    SESSION_SECRET                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/SESSION_SECRET"
    STORAGE_KEY                    = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/STORAGE_KEY"
    STORAGE_PROVIDER               = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/STORAGE_PROVIDER"
    STORAGE_REGION                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/STORAGE_REGION"
    STORAGE_SECRET                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/staging/STORAGE_SECRET"
  }
}
