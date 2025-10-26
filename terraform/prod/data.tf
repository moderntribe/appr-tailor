data "aws_caller_identity" "current" {}

data "terraform_remote_state" "appr_infra_prod" {
  backend = "s3"
  config = {
    bucket = "appr-terraform-state"
    key    = "appr/prod/infra/prod.tfstate"
    region = var.region
  }
}
