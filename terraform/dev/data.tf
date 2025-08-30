data "aws_caller_identity" "current" {}

data "terraform_remote_state" "appr_infra_dev" {
  backend = "s3"
  config = {
    bucket = "appr-terraform-state"
    key    = "appr/dev/infra/dev.tfstate"
    region = var.region
  }
}
