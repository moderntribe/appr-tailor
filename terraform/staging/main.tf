resource "aws_ecs_service" "tailor_service" {
  depends_on                         = [aws_lb_listener.tailor_listener_https, aws_lb_listener.tailor_listener_http]
  name                               = local.tailor_name
  cluster                            = local.ecs_cluster_info.arn
  task_definition                    = aws_ecs_task_definition.tailor_task_definition.arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  wait_for_steady_state              = true
  deployment_minimum_healthy_percent = 0
  enable_execute_command             = true
  force_new_deployment               = true

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

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
        { name = "AUTH_SALT_ROUNDS", value = "10" },
        { name = "AUTH_JWT_SCHEME", value = "JWT" },
        { name = "AUTH_JWT_ISSUER", value = "tailor-staging.advancingpretrial.org" },
        { name = "AUTH_JWT_COOKIE_NAME", value = "tailor-cookie" },
        { name = "HOSTNAME", value = "tailor-${var.environment}.advancingpretrial.org" },
        { name = "OIDC_ENABLED", value = "1" },
        { name = "OIDC_AUTHORIZATION_ENDPOINT", value = "https://account.test.advancingpretrial.org/authorize" },
        { name = "OIDC_ISSUER", value = "https://account.test.advancingpretrial.org/" },
        { name = "OIDC_JWKS_URL", value = "https://account.test.advancingpretrial.org/.well-known/jwks.json" },
        { name = "OIDC_TOKEN_ENDPOINT", value = "https://account.test.advancingpretrial.org/oauth/token" },
        { name = "OIDC_LOGOUT_ENDPOINT", value = "https://account.test.advancingpretrial.org/logout" },
        { name = "OIDC_USERINFO_ENDPOINT", value = "https://account.test.advancingpretrial.org/userinfo" },
        { name = "OIDC_USERINFO_ENDPOINT", value = "https://account.test.advancingpretrial.org/userinfo" },
        { name = "OIDC_LOGOUT_ENABLED", value = "1" },
        { name = "OIDC_POST_LOGOUT_URI_KEY", value = "returnTo" },
        { name = "OIDC_ALLOW_SIGNUP", value = "0" },
        { name = "OIDC_DEFAULT_ROLE", value = "ADMIN" },
        { name = "OIDC_LOGIN_TEXT", value = "Login with APPR" },
        { name = "EMAIL_SENDER_NAME", value = "APPR Authoring" },
        { name = "EMAIL_SENDER_ADDRESS", value = "tailor@advancingpretrial.org" },
        { name = "EMAIL_HOST", value = "email-smtp.us-east-1.amazonaws.com" },
        { name = "EMAIL_SSL", value = "1" },
        { name = "STORAGE_PROVIDER", value = "amazon" },
        { name = "STORAGE_REGION", value = "us-east-2" },
        { name = "STORAGE_PUBLIC_BUCKET", value = "cepp-staging-public" },
        { name = "STORAGE_BUCKET", value = "cepp-staging" },
        { name = "PREVIEW_URL", value = "https://learn-${var.environment}.advancingpretrial.org/api/v1/preview/" },
        { name = "LOG_LEVEL", value = "debug" },
        { name = "FORCE_COLOR", value = "1" },
        { name = "FLAT_REPO_STRUCTURE", value = "1" },
        { name = "DATABASE_NAME", value = "tailor" },
        { name = "DATABASE_USER", value = "tailor_dba" },
        { name = "DATABASE_HOST", value = local.rds_tailor_info.address },
        { name = "DATABASE_PORT", value = tostring(local.rds_tailor_info.port) },
        { name = "PORT", value = "3000" },
        { name = "PROTOCOL", value = "https" },
        { name = "REVERSE_PROXY_PORT", value = "443" },
        { name = "CORS_ALLOWED_ORIGINS", value = "http://localhost:8080" },  # same as dev
      ]
      secrets = concat(
        [
          for secret_name, secret_arn in var.tailor_server_secrets : {
            name      = secret_name
            valueFrom = secret_arn
          }
        ]
      )
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
