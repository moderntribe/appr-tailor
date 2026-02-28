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

