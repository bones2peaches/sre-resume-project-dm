resource "aws_ecs_task_definition" "this" {

  family                   = "${var.project}-${var.env}-${var.app}-task-family"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory

  task_role_arn      = aws_iam_role.task_role.arn
  execution_role_arn = aws_iam_role.exc_role.arn


  container_definitions = jsonencode([
    {
      name      = "api"
      image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region_name}.amazonaws.com/${var.ecr_name}:${var.app}-${var.github_sha}"
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
        { "name" : "NCHAN_USER",
        "value" : "${var.nchan_username}" },
        { "name" : "NCHAN_PASSWORD",
        "value" : "${var.nchan_password}" },
        { "name" : "NCHAN_PROTOCOL",
        "value" : "${var.nchan_protocol}" },
        { "name" : "NCHAN_HOST",
        "value" : "${var.nchan_host}" },

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
          "awslogs-region"        = "${var.region_name}"
          "awslogs-group"         = "${var.log_group_name}"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])


}
