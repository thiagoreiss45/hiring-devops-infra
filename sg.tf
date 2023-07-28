resource "aws_security_group" "ec2-container-service" {
  name_prefix = "EC2ContainerService"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "application-load-balancer" {
  name_prefix = "ApplicationLoadBalancerSecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "container-load-balancer" {
  name_prefix = "ContainerFromALBSecurityGroup"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = [aws_security_group.application-load-balancer.id]
  }
}