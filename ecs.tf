resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                = var.task_definition_name
  cpu                   = "512" 
  memory                = "512" 
  network_mode          = "bridge"
  requires_compatibilities = ["EC2"]

  container_definitions = jsonencode([{
    name  = var.container_name
    image = "public.ecr.aws/t8y4c8l7/meteor-hiring-thiago-repo:latest" 
    portMappings = [{
      containerPort = 3000
      # hostPort      = 80
      protocol       = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 1 
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    container_name   = var.container_name
    container_port   = 3000
  }
}
