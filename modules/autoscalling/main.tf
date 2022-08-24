# ---modules/autoscaling/main.tf

resource "aws_launch_configuration" "web_config" {
  name            = var.aws_launch_configuration_name
  image_id        = var.web_server_ami
  instance_type   = var.instance_type
  security_groups = [var.public_sg]
  user_data       = var.user_data

}

resource "aws_autoscaling_group" "webserver" {
  name                      = var.ASG_webserver_name
  max_size                  = var.webserver_max_size
  min_size                  = var.webserver_min_size
  health_check_grace_period = var.webserver_health_check_grace_period
  health_check_type         = var.webserver_health_check_type
  desired_capacity          = var.webserver_desired_capacity
  force_delete              = var.webserver_force_delete
  launch_configuration      = aws_launch_configuration.web_config.name
  vpc_zone_identifier       = var.private_sn
  target_group_arns         = [var.public_alb]
  tag {
    key                 = "Name"
    value               = "Webserver"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "bastion_config" {
  name            = var.bastion_launch_configuration_name
  image_id        = var.bastion_server_ami
  instance_type   = var.instance_type
  security_groups = [var.bastion_sg]
}

resource "aws_autoscaling_group" "bastion" {
  name                      = var.bastion_webserver_name
  max_size                  = var.bastion_max_size
  min_size                  = var.bastion_min_size
  health_check_grace_period = var.bastion_health_check_grace_period
  health_check_type         = var.bastion_health_check_type
  desired_capacity          = var.bastion_desired_capacity
  force_delete              = var.bastion_force_delete
  launch_configuration      = aws_launch_configuration.bastion_config.name
  vpc_zone_identifier       = var.public_sn
  tag {
    key                 = "Name"
    value               = "Bastion"
    propagate_at_launch = true
  }
}
