locals {
  tailor_name           = "tailor-${var.environment}"
  name                  = data.terraform_remote_state.appr_infra_staging.outputs.name
  security_group_id     = data.terraform_remote_state.appr_infra_staging.outputs.security_group_id
  security_group_name   = data.terraform_remote_state.appr_infra_staging.outputs.security_group_name
  network_info          = data.terraform_remote_state.appr_infra_staging.outputs.network_info
  rds_tailor_info       = data.terraform_remote_state.appr_infra_staging.outputs.rds_tailor_info
  ecs_cluster_info      = data.terraform_remote_state.appr_infra_staging.outputs.ecs_cluster_info
  ecr_tailor_repository = data.terraform_remote_state.appr_infra_staging.outputs.ecr_tailor_repository
  account_id            = data.aws_caller_identity.current.account_id
}
