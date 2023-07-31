resource "aws_lb" "ecs_load_balancer" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_list
}

resource "aws_lb_target_group" "ecs_target_group" {
  name     = "tg-3000-3"
  port     = 3000
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