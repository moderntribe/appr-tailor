resource "aws_ecs_service" "tailor_service" {
  depends_on                         = [aws_lb_listener.tailor_listener_https, aws_lb_listener.tailor_listener_http]
  name                               = local.tailor_name
  cluster                            = local.ecs_cluster_info.arn
  task_definition                    = aws_ecs_task_definition.tailor_task_definition.arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  wait_for_steady_state              = true
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  enable_execute_command             = true

  force_new_deployment = true

  network_configuration {
    subnets          = local.network_info.private_subnets
    security_groups  = [aws_security_group.tailor_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tailor_tg.arn
    container_name   = "tailor"
    container_port   = 3000
  }

  tags = {
    Name = local.tailor_name
  }
}

resource "aws_ecs_task_definition" "tailor_task_definition" {
  family                   = local.tailor_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.tailor_ecs_execution.arn
  task_role_arn            = aws_iam_role.tailor_ecs_task.arn

  container_definitions = jsonencode([
    {
      name  = "tailor"
      image = "${local.ecr_tailor_repository.url}:${var.image_tag}"
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "AUTH_JWT_COOKIE_NAME", value = "tailor-cookie" },
        { name = "AUTH_JWT_ISSUER", value = "tailor-cepp" },
        { name = "AUTH_JWT_SCHEME", value = "JWT" },
        { name = "AUTH_SALT_ROUNDS", value = "10" },
        { name = "CORS_ALLOWED_ORIGINS", value = "http://localhost:8080" }, # same as dev
        { name = "DATABASE_HOST", value = local.rds_tailor_info.address },
        { name = "DATABASE_NAME", value = "tailor" },
        { name = "DATABASE_PORT", value = tostring(local.rds_tailor_info.port) },
        { name = "DATABASE_USER", value = "tailor_dba" },
        { name = "EMAIL_HOST", value = "email-smtp.us-east-1.amazonaws.com" },
        { name = "EMAIL_SENDER_ADDRESS", value = "cepp-dev@extensionengine.com" },
        { name = "EMAIL_SENDER_NAME", value = "APPR Authoring" },
        { name = "EMAIL_SSL", value = "1" },
        { name = "FLAT_REPO_STRUCTURE", value = "1" },
        { name = "FORCE_COLOR", value = "1" },
        { name = "HOSTNAME", value = "tailor-${var.environment}.advancingpretrial.org" },
        { name = "LOG_LEVEL", value = "debug" },
        { name = "OIDC_ALLOW_SIGNUP", value = "0" },
        { name = "OIDC_AUTHORIZATION_ENDPOINT", value = "https://account.advancingpretrial.org/authorize" },
        { name = "OIDC_DEFAULT_ROLE", value = "ADMIN" },
        { name = "OIDC_ENABLED", value = "1" },
        { name = "OIDC_ISSUER", value = "https://account.advancingpretrial.org/" },
        { name = "OIDC_JWKS_URL", value = "https://account.advancingpretrial.org/.well-known/jwks.json" },
        { name = "OIDC_LOGIN_TEXT", value = "Login with APPR" },
        { name = "OIDC_LOGOUT_ENABLED", value = "1" },
        { name = "OIDC_LOGOUT_ENDPOINT", value = "https://account.advancingpretrial.org/logout" },
        { name = "OIDC_POST_LOGOUT_URI_KEY", value = "returnTo" },
        { name = "OIDC_TOKEN_ENDPOINT", value = "https://account.advancingpretrial.org/oauth/token" },
        { name = "OIDC_USERINFO_ENDPOINT", value = "https://account.advancingpretrial.org/userinfo" },
        { name = "PORT", value = "3000" },
        { name = "PREVIEW_URL", value = "https://learn-${var.environment}.advancingpretrial.org/api/v1/preview/" },
        { name = "PROTOCOL", value = "https" },
        { name = "REVERSE_PROXY_PORT", value = "443" },
        { name = "STORAGE_BUCKET", value = "appr-content-prod" },
        { name = "STORAGE_PROVIDER", value = "amazon" },
        { name = "STORAGE_PUBLIC_BUCKET", value = "appr-content-prod-public" },
        { name = "STORAGE_REGION", value = "us-east-1" },
      ]
      secrets = [
        { name = "AUTH_JWT_SECRET",           valueFrom = data.aws_ssm_parameter.auth_jwt_secret.arn },
        { name = "DATABASE_PASSWORD",         valueFrom = data.aws_ssm_parameter.database_password.arn },
        { name = "EMAIL_PASSWORD",            valueFrom = data.aws_ssm_parameter.email_password.arn },
        { name = "EMAIL_USER",                valueFrom = data.aws_ssm_parameter.email_user.arn },
        { name = "OIDC_CLIENT_ID",            valueFrom = data.aws_ssm_parameter.auth0_client_id.arn },
        { name = "OIDC_CLIENT_SECRET",        valueFrom = data.aws_ssm_parameter.auth0_client_secret.arn },
        { name = "SESSION_SECRET",            valueFrom = data.aws_ssm_parameter.session_secret.arn },
        { name = "STORAGE_KEY",               valueFrom = data.aws_ssm_parameter.storage_key.arn },
        { name = "STORAGE_PROXY_PRIVATE_KEY", valueFrom = data.aws_ssm_parameter.storage_proxy_private_key.arn },
        { name = "STORAGE_SECRET",            valueFrom = data.aws_ssm_parameter.storage_secret.arn },
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.tailor_log_group.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = local.tailor_name
  }
}

resource "aws_cloudwatch_log_group" "tailor_log_group" {
  name              = "/ecs/${local.tailor_name}"
  retention_in_days = 1

  tags = {
    Name = local.tailor_name
  }
}
