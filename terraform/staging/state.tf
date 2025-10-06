provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "appr-terraform-state"
    key     = "appr/staging/app/tailor-staging.tfstate"
    region  = "us-east-1"
  }
}
