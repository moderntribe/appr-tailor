variable "image_tag" {
  description = "docker image tag"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
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
    AUTH_JWT_SECRET           = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/AUTH_JWT_SECRET"
    EMAIL_PASSWORD            = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/EMAIL_PASSWORD"
    EMAIL_USER                = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/EMAIL_USER"
    OIDC_CLIENT_ID            = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/OIDC_CLIENT_ID"
    OIDC_CLIENT_SECRET        = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/OIDC_CLIENT_SECRET"
    SESSION_SECRET            = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/SESSION_SECRET"
    STORAGE_KEY               = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/STORAGE_KEY"
    STORAGE_SECRET            = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/STORAGE_SECRET"
    STORAGE_PROXY_PRIVATE_KEY = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/STORAGE_PROXY_PRIVATE_KEY"
    DATABASE_PASSWORD         = "arn:aws:ssm:us-east-1:902864695929:parameter/appr/tailor/dev/DATABASE_PASSWORD"
  }
}
