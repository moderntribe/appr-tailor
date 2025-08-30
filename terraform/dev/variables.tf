variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  default = "us-east-1"
}

variable "tailor_acm_certificate_arn" {
  default = "arn:aws:acm:us-east-1:902864695929:certificate/2ba12a83-294d-4f8f-8b97-abc2f9c30d4c"
}

variable "tailor_server_secrets" {
  description = "List of server secret names for Tailor"
  type        = map(string)
  default = {
    AUTH_JWT_ISSUER                = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/AUTH_JWT_ISSUER"
    AUTH_JWT_SCHEME                = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/AUTH_JWT_SCHEME"
    AUTH_JWT_SECRET                = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/AUTH_JWT_SECRET"
    AUTH_SALT_ROUNDS               = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/AUTH_SALT_ROUNDS"
    CORS_ALLOWED_ORIGINS           = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/CORS_ALLOWED_ORIGINS"
    EMAIL_HOST                     = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/EMAIL_HOST"
    EMAIL_PASSWORD                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/EMAIL_PASSWORD"
    EMAIL_SENDER_ADDRESS           = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/EMAIL_SENDER_ADDRESS"
    EMAIL_SENDER_NAME              = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/EMAIL_SENDER_NAME"
    EMAIL_SSL                      = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/EMAIL_SSL"
    EMAIL_USER                     = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/EMAIL_USER"
    FLAT_REPO_STRUCTURE            = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/FLAT_REPO_STRUCTURE"
    FORCE_COLOR                    = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/FORCE_COLOR"
    HOSTNAME                       = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/HOSTNAME"
    LOG_LEVEL                      = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/LOG_LEVEL"
    OIDC_ALLOW_SIGNUP              = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_ALLOW_SIGNUP"
    OIDC_AUTHORIZATION_ENDPOINT    = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_AUTHORIZATION_ENDPOINT"
    OIDC_CLIENT_ID                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_CLIENT_ID"
    OIDC_CLIENT_SECRET             = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_CLIENT_SECRET"
    OIDC_DEFAULT_ROLE              = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_DEFAULT_ROLE"
    OIDC_ENABLED                   = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_ENABLED"
    OIDC_ISSUER                    = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_ISSUER"
    OIDC_JWKS_URL                  = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_JWKS_URL"
    OIDC_LOGOUT_ENABLED            = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_LOGOUT_ENABLED"
    OIDC_LOGOUT_ENDPOINT           = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_LOGOUT_ENDPOINT"
    OIDC_POST_LOGOUT_URI_KEY       = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_POST_LOGOUT_URI_KEY"
    OIDC_TOKEN_ENDPOINT            = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_TOKEN_ENDPOINT"
    OIDC_USERINFO_ENDPOINT         = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/OIDC_USERINFO_ENDPOINT"
    PREVIEW_URL                    = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/PREVIEW_URL"
    PROTOCOL                       = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/PROTOCOL"
    REVERSE_PROXY_PORT             = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/REVERSE_PROXY_PORT"
    SESSION_SECRET                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/SESSION_SECRET"
    STORAGE_KEY                    = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/STORAGE_KEY"
    STORAGE_PROVIDER               = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/STORAGE_PROVIDER"
    STORAGE_REGION                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/STORAGE_REGION"
    STORAGE_SECRET                 = "arn:aws:ssm:us-east-1:902864695929:parameter/cepp-tailor/dev/STORAGE_SECRET"
  }
}
