
resource "aws_ecs_service" "this" {
  
  name                 = "${var.project}-${var.env}-${var.app}ecs-service"
  cluster              = var.cluster_arn
  task_definition      = aws_ecs_task_definition.this.arn
  desired_count        = 1
  launch_type          = "FARGATE"
  force_new_deployment = true


  network_configuration {
    subnets         = var.service_subnets
    security_groups = [aws_security_group.this.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.container_name
    container_port   = var.host_port
  }


}