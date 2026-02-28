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

