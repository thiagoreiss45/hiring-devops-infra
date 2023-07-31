variable "region" {
  type = string
  default = "us-east-2"  
}

variable "ecs_cluster_name" {
  type = string
  default = "meteor-ecs-cluster"  
}

variable "task_definition_name" {
  type = string
  default = "meteor0505"  
}

variable "container_name" {
  type = string
  default = "testr"  
}

variable "service_name" {
  type = string
  default = "meteor-service-2"  
}

variable "alb_name" {
  type = string
  default = "alb-meteor"
}

variable "subnet_list" {
  type = list
  default = ["subnet-07f3b50a1b3f000ce", "subnet-0c116bdd8ccfcd8e2", "subnet-0c037edc29769723e"]
}
