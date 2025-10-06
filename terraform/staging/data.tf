data "aws_caller_identity" "current" {}

data "terraform_remote_state" "appr_infra_staging" {
  backend = "s3"
  config = {
    bucket = "appr-terraform-state"
    key    = "appr/staging/infra/staging.tfstate"
    region = var.region
  }
}
