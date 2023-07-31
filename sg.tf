resource "aws_security_group" "ec2-container-service" {
  name_prefix = "EC2ContainerService"

  ingress {
    from_port   = 0
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
