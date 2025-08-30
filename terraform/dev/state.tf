provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "appr-terraform-state"
    key     = "appr/dev/app/appr-terraform-state-dev.tfstate"
    region  = "us-east-1"
  }
}
