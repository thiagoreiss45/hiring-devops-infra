# Define the EC2 instances to register in the ECS cluster
resource "aws_instance" "ecs_instances" {
  count         = 1  
  ami           = "ami-0de5ed5b8d5233741"  
  instance_type = "t3.micro"  
  subnet_id     = "subnet-07f3b50a1b3f000ce"  
  user_data     = data.template_file.user_data.rendered
  iam_instance_profile   = aws_iam_instance_profile.ecs_agent.name
  security_groups = [aws_security_group.ec2-container-service.id]
}

data "template_file" "user_data" {
  template = file("user_data.tpl") #Defines a script that runs when the EC2 instance starts
}