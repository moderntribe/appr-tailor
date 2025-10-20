resource "aws_ecs_service" "tailor_service" {
  depends_on                         = [aws_lb_listener.tailor_listener_https, aws_lb_listener.tailor_listener_http]
  name                               = local.tailor_name
  cluster                            = local.ecs_cluster_info.arn
  task_definition                    = aws_ecs_task_definition.tailor_task_definition.arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  deployment_minimum_healthy_percent = 0
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
        { name = "STORAGE_PUBLIC_BUCKET", value = "dev.cepp-public-20240223085605705200000001" },
        { name = "STORAGE_BUCKET", value = "dev.cepp-20240223085605937600000002" },
        { name = "DATABASE_NAME", value = "tailor" },
        { name = "DATABASE_USER", value = "tailor" },
        { name = "DATABASE_HOST", value = local.rds_tailor_info.address },
        { name = "DATABASE_PORT", value = tostring(local.rds_tailor_info.port) },
        { name = "DATABASE_PASSWORD", value = "tailor" },
        { name = "PORT", value = "3000" }
      ]
      secrets = concat(
        [
          for secret_name, secret_arn in var.tailor_server_secrets : {
            name      = secret_name
            valueFrom = secret_arn
          }
        ]
        # [
        #   {
        #     name      = "DATABASE_PASSWORD"
        #     valueFrom = "tailor"
        #   }
        # ]
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
