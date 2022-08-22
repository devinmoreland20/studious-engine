# ----- root/main.tf

module "loadbalancing" {
  source                 = "./modules/loadbalancing"
  public_subnets         = module.networking.aws_public_subnet
  tg_port                = 80
  tg_protocol            = "HTTP"
  vpc_id                 = module.networking.vpc_id
  listener_port          = 80
  listener_protocol      = "HTTP"
  security_groups        = module.security.public_ALB
  lb_healthy_threshold   = 2
  lb_unhealthy_threshold = 2
  lb_timeout             = 20
  lb_interval            = 30
}




module "networking" {
  source           = "./modules/networking"
  vpc_cidr         = "10.0.0.0/16"
  instance_tenancy = "default"
  access_ip        = "0.0.0.0/0"
  private_sn_count = 3
  public_sn_count  = 3
  public_cidrs     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_cidrs    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

}
module "autoscalling" {
  source     = "./modules/autoscalling"
  public_sn  = module.networking.aws_public_subnet
  private_sn = module.networking.aws_private_subnet
  public_alb = module.loadbalancing.lb_target_group_arn
  public_sg  = module.security.public_http_sg

  bastion_sg    = module.security.bastion_sg
  instance_type = "t2.micro"
  user_data     = file("./userdata.tpl")
}
module "security" {
  source    = "./modules/security"
  vpc_id    = module.networking.vpc_id
  access_ip = "0.0.0.0/0"
}
