# ---------- root/variables.tf
variable "AWS_SECRET_ACCESS_KEY" {}


variable "CONFIRM_DESTROY" {
}
variable "AWS_ACCESS_KEY_ID" {
}

variable "AWS_DEFAULT_REGION" {
}

variable "tg_port" {
  type    = number
  default = 80
}
variable "tg_protocol" {
  type    = string
  default = "HTTP"
}

variable "listener_port" {
  type    = number
  default = 80
}
variable "listener_protocol" {
  type    = string
  default = "HTTP"
}

variable "lb_healthy_threshold" {
  type    = number
  default = 2
}
variable "lb_unhealthy_threshold" {
  type    = number
  default = 2
}
variable "lb_timeout" {
  type    = number
  default = 20

}
variable "lb_interval" {
  type    = number
  default = 30
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "instance_tenancy" {
  type    = string
  default = "default"
}
variable "access_ip" {
  type    = string
  default = "0.0.0.0/0"
}
variable "private_sn_count" {
  type    = number
  default = 3
}
variable "public_sn_count" {
  type    = number
  default = 3
}
variable "public_cidrs" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "private_cidrs" {
  type    = list(any)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "aws_launch_configuration_name" {
  type    = string
  default = "web_config"
}

variable "web_server_ami" {
  type    = string
  default = "ami-051dfed8f67f095f5"
}

variable "ASG_webserver_name" {
  type    = string
  default = "webserver-ASG"
}

variable "webserver_max_size" {
  type    = number
  default = 5
}

variable "webserver_min_size" {
  type    = number
  default = 2
}
variable "webserver_health_check_grace_period" {
  type    = number
  default = 300
}

variable "webserver_health_check_type" {
  type    = string
  default = "ELB"
}
variable "webserver_desired_capacity" {
  type    = number
  default = 2
}
variable "webserver_force_delete" {
  type    = bool
  default = true
}



variable "bastion_launch_configuration_name" {
  type    = string
  default = "bastion_config"
}

variable "bastion_server_ami" {
  type    = string
  default = "ami-051dfed8f67f095f5"
}

variable "bastion_webserver_name" {
  type    = string
  default = "webserver-ASG"
}

variable "bastion_max_size" {
  type    = number
  default = 3
}

variable "bastion_min_size" {
  type    = number
  default = 1
}
variable "bastion_health_check_grace_period" {
  type    = number
  default = 300
}

variable "bastion_health_check_type" {
  type    = string
  default = "ELB"
}
variable "bastion_desired_capacity" {
  type    = number
  default = 1
}
variable "bastion_force_delete" {
  type    = bool
  default = true
}


variable "webserver_lb_name" {
  type    = string
  default = "webserver-lb"
}

variable "load_balancer_type" {
  type    = string
  default = "application"
}
variable "internal_lb" {
  type    = bool
  default = false
}
variable "lb_listener_action_type" {
  type    = string
  default = "forward"
}
variable "lb_tg_name" {
  type    = string
  default = "webserver-lb-tg"
}
variable "enable_deletion_protection" {
  type    = bool
  default = false
}

variable "vpc_instance_tenancy" {
  type    = string
  default = "default"
}

variable "default_rt_route_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}
variable "public_route_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}
variable "elastic_ip_vpc" {
  type    = bool
  default = true
}
