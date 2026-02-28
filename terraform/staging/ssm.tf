data "aws_ssm_parameter" "auth0_client_id" {
  name = "/appr/tailor/staging/AUTH0_CLIENT_ID"
}

data "aws_ssm_parameter" "auth0_client_secret" {
  name = "/appr/tailor/staging/AUTH0_CLIENT_SECRET"
}

data "aws_ssm_parameter" "auth_jwt_secret" {
  name = "/appr/tailor/staging/AUTH_JWT_SECRET"
}

data "aws_ssm_parameter" "database_password" {
  name = "/appr/tailor/staging/DATABASE_PASSWORD"
}

data "aws_ssm_parameter" "email_password" {
  name = "/appr/tailor/staging/EMAIL_PASSWORD"
}

data "aws_ssm_parameter" "email_user" {
  name = "/appr/tailor/staging/EMAIL_USER"
}

data "aws_ssm_parameter" "session_secret" {
  name = "/appr/tailor/staging/SESSION_SECRET"
}

data "aws_ssm_parameter" "storage_key" {
  name = "/appr/tailor/staging/STORAGE_KEY"
}

data "aws_ssm_parameter" "storage_proxy_private_key" {
  name = "/appr/tailor/staging/STORAGE_PROXY_PRIVATE_KEY"
}

data "aws_ssm_parameter" "storage_secret" {
  name = "/appr/tailor/staging/STORAGE_SECRET"
}
