# Create an ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "meteor-ecs-cluster" 
}

# Create an ECS task definition with Fargate launch type
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                = "meteor-task"
  cpu                   = "256" 
  memory                = "512" 
  network_mode          = "bridge"
  requires_compatibilities = ["EC2"]

  container_definitions = jsonencode([{
    name  = "meteor-container"
    image = "public.ecr.aws/t8y4c8l7/meteor-hiring-thiago-repo:latest" 
    portMappings = [{
      containerPort = 80
      # hostPort      = 80
      protocol       = "tcp"
    }]
  }])
}

# Create an ECS service to run the task on the cluster
resource "aws_ecs_service" "ecs_service" {
  name            = "meteor-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 1 
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    container_name   = "meteor-container"
    container_port   = 80
  }
}
