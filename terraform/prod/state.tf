provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "appr-terraform-state"
    key     = "appr/prod/app/tailor-prod.tfstate"
    region  = "us-east-1"
  }
}
