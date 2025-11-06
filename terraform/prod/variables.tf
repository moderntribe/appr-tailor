variable "image_tag" {
  description = "docker image tag"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
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
    AUTH_JWT_SECRET           = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/AUTH_JWT_SECRET"
    DATABASE_PASSWORD         = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/DATABASE_PASSWORD"
    EMAIL_PASSWORD            = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/EMAIL_PASSWORD"
    EMAIL_USER                = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/EMAIL_USER"
    OIDC_CLIENT_ID            = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/OIDC_CLIENT_ID"
    OIDC_CLIENT_SECRET        = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/OIDC_CLIENT_SECRET"
    SESSION_SECRET            = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/SESSION_SECRET"
    STORAGE_KEY               = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/STORAGE_KEY"
    STORAGE_PROXY_PRIVATE_KEY = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/STORAGE_PROXY_PRIVATE_KEY"
    STORAGE_SECRET            = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/prod/STORAGE_SECRET"
  }
}
