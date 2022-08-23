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
  type    = string
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
# variable "user_data" {
#   default = file("./userdata.tpl")
# }
