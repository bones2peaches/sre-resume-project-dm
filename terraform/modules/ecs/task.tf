resource "aws_ecs_task_definition" "this" {
  depends_on               = [aws_cloudwatch_log_group.this]
  family                   = "${var.project}-${var.env}task-family"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory

  task_role_arn      = aws_iam_roketask_role_arn
  execution_role_arn = var.exec_role_arn


  container_definitions = jsonencode([
    {
      name      = "api"
      image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.ecr_name}:${var.image_tag}"
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
      environment = [
        {
          "name" : "DB_NAME",
          "value" : "${var.db_name}"
        },
        {
          "name" : "DB_HOST",
          "value" : "${var.db_hostname}"
        },
        {
          "name" : "DB_PORT",
          "value" : "${var.db_port}"
        },
        { "name" : "STAGE",
        "value" : "${var.env}" }
      ]
      secrets = [
        {
          "name" : "DB_PASSWORD",
          "valueFrom" : "${var.rds_secret_arn}"
      }]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-create-group"  = "true"
          "awslogs-region"        = "${data.aws_region.current.name}"
          "awslogs-group"         = "${aws_cloudwatch_log_group.this.name}"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])


}
