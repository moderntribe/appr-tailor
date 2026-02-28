data "aws_ssm_parameter" "auth0_client_id" {
  name = "/appr/tailor/prod/AUTH0_CLIENT_ID"
}

data "aws_ssm_parameter" "auth0_client_secret" {
  name = "/appr/tailor/prod/AUTH0_CLIENT_SECRET"
}

data "aws_ssm_parameter" "auth_jwt_secret" {
  name = "/appr/tailor/prod/AUTH_JWT_SECRET"
}

data "aws_ssm_parameter" "database_password" {
  name = "/appr/tailor/prod/DATABASE_PASSWORD"
}

data "aws_ssm_parameter" "email_password" {
  name = "/appr/tailor/prod/EMAIL_PASSWORD"
}

data "aws_ssm_parameter" "email_user" {
  name = "/appr/tailor/prod/EMAIL_USER"
}

data "aws_ssm_parameter" "session_secret" {
  name = "/appr/tailor/prod/SESSION_SECRET"
}

data "aws_ssm_parameter" "storage_key" {
  name = "/appr/tailor/prod/STORAGE_KEY"
}

data "aws_ssm_parameter" "storage_proxy_private_key" {
  name = "/appr/tailor/prod/STORAGE_PROXY_PRIVATE_KEY"
}

data "aws_ssm_parameter" "storage_secret" {
  name = "/appr/tailor/prod/STORAGE_SECRET"
}
