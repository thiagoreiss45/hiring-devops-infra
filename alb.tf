# Create an Application Load Balancer and a target group
resource "aws_lb" "ecs_load_balancer" {
  name               = "alb-meteor"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-07f3b50a1b3f000ce", "subnet-0c116bdd8ccfcd8e2", "subnet-0c037edc29769723e"]
  security_groups    = [aws_security_group.application-load-balancer.id]

}

resource "aws_lb_target_group" "ecs_target_group" {
  name     = "my-ecs-target-group-tf"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0a124f49f86aff97c" 
}

resource "aws_lb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.ecs_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }
}

# Listener rule to forward traffic to the ECS service
resource "aws_lb_listener_rule" "ecs_listener_rule" {
  listener_arn = aws_lb_listener.ecs_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}