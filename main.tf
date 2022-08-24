# ----- root/main.tf

module "loadbalancing" {
  source                     = "./modules/loadbalancing"
  public_subnets             = module.networking.aws_public_subnet
  tg_port                    = var.tg_port
  tg_protocol                = var.tg_protocol
  vpc_id                     = module.networking.vpc_id
  listener_port              = var.listener_port
  listener_protocol          = var.listener_port
  security_groups            = module.security.public_ALB
  lb_healthy_threshold       = var.lb_healthy_threshold
  lb_unhealthy_threshold     = var.lb_unhealthy_threshold
  lb_timeout                 = var.lb_timeout
  lb_interval                = var.lb_interval
  webserver_lb_name          = var.webserver_lb_name
  load_balancer_type         = var.load_balancer_type
  internal_lb                = var.internal_lb
  enable_deletion_protection = var.enable_deletion_protection
  lb_listener_action_type    = var.lb_listener_action_type
  lb_tg_name                 = var.lb_tg_name
}




module "networking" {
  source                      = "./modules/networking"
  vpc_cidr                    = var.vpc_cidr
  instance_tenancy            = var.instance_tenancy
  access_ip                   = var.access_ip
  private_sn_count            = 3
  public_sn_count             = 3
  public_cidrs                = var.public_cidrs
  private_cidrs               = var.private_cidrs
  vpc_instance_tenancy        = var.vpc_instance_tenancy
  default_rt_route_cidr_block = var.default_rt_route_cidr_block
  public_route_cidr_block     = var.public_route_cidr_block
  elastic_ip_vpc              = var.elastic_ip_vpc
}
module "autoscalling" {
  source                            = "./modules/autoscalling"
  aws_launch_configuration_name     = var.aws_launch_configuration_name
  web_server_ami                    = var.web_server_ami
  ASG_webserver_name                = var.ASG_webserver_name
  webserver_max_size                = var.webserver_max_size
  webserver_min_size                = webserver_min_size
  webserver_health_check_type       = var.webserver_health_check_type
  webserver_desired_capacity        = var.webserver_desired_capacity
  webserver_force_delete            = var.webserver_force_delete
  public_sn                         = module.networking.aws_public_subnet
  private_sn                        = module.networking.aws_private_subnet
  public_alb                        = module.loadbalancing.lb_target_group_arn
  public_sg                         = module.security.public_http_sg
  bastion_launch_configuration_name = var.bastion_launch_configuration_name
  bastion_server_ami                = var.bastion_server_ami
  bastion_webserver_name            = var.bastion_webserver_name
  bastion_max_size                  = var.bastion_max_size
  bastion_min_size                  = var.bastion_min_size
  bastion_health_check_grace_period = var.bastion_health_check_grace_period
  bastion_health_check_type         = var.bastion_health_check_type
  bastion_desired_capacity          = var.bastion_desired_capacity
  bastion_force_delete              = var.bastion_force_delete
  bastion_sg                        = module.security.bastion_sg
  instance_type                     = var.instance_type
  user_data                         = file("./userdata.tpl")
}
module "security" {
  source    = "./modules/security"
  vpc_id    = module.networking.vpc_id
  access_ip = var.access_ip
}
