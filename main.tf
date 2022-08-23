# ----- root/main.tf

module "loadbalancing" {
  source                 = "./modules/loadbalancing"
  public_subnets         = module.networking.aws_public_subnet
  tg_port                = var.tg_port
  tg_protocol            = var.tg_protocol
  vpc_id                 = module.networking.vpc_id
  listener_port          = var.listener_port
  listener_protocol      = var.listener_port
  security_groups        = module.security.public_ALB
  lb_healthy_threshold   = var.lb_healthy_threshold
  lb_unhealthy_threshold = var.lb_unhealthy_threshold
  lb_timeout             = var.lb_timeout
  lb_interval            = var.lb_interval
}




module "networking" {
  source           = "./modules/networking"
  vpc_cidr         = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
  access_ip        = var.access_ip
  private_sn_count = var.private_cidrs
  public_sn_count  = var.public_sn_count
  public_cidrs     = var.public_cidrs
  private_cidrs    = var.private_cidrs

}
module "autoscalling" {
  source     = "./modules/autoscalling"
  public_sn  = module.networking.aws_public_subnet
  private_sn = module.networking.aws_private_subnet
  public_alb = module.loadbalancing.lb_target_group_arn
  public_sg  = module.security.public_http_sg

  bastion_sg    = module.security.bastion_sg
  instance_type = var.instance_type
  user_data     = var.user_data
}
module "security" {
  source    = "./modules/security"
  vpc_id    = module.networking.vpc_id
  access_ip = var.access_ip
}
