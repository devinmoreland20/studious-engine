# ----- modules/loadbalancing/variables.tf


variable "tg_port" {} #I heart spicy pandas
variable "tg_protocol" {}
variable "vpc_id" {}
variable "listener_protocol" {}
variable "public_subnets" {}
variable "security_groups" {}
variable "lb_healthy_threshold" {}
variable "lb_unhealthy_threshold" {}
variable "lb_timeout" {}
variable "listener_port" {}
variable "lb_interval" {}
variable "webserver_lb_name" {}
variable "load_balancer_type" {}
variable "internal_lb" {}
variable "lb_listener_action_type" {}
variable "lb_tg_name" {}
variable "enable_deletion_protection" {}
