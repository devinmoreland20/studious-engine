# ---modules/autoscaling/main.tf

resource "aws_launch_configuration" "web_config" {
  name            = "web_config"
  image_id        = "ami-051dfed8f67f095f5"
  instance_type   = var.instance_type
  security_groups = [var.public_sg]
  user_data       = var.user_data

}

resource "aws_autoscaling_group" "webserver" {
  name                      = "webserver-ASG"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.web_config.name
  vpc_zone_identifier       = var.private_sn
  target_group_arns         = [var.public_alb]
  tag {
    name = join("-", [[count.index], "redhat-box"])
  }
}

resource "aws_launch_configuration" "bastion_config" {
  name            = "bastion_config"
  image_id        = "ami-051dfed8f67f095f5"
  instance_type   = var.instance_type
  security_groups = [var.bastion_sg]
}

resource "aws_autoscaling_group" "bastion" {
  name                      = "bastion-ASG"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.bastion_config.name
  vpc_zone_identifier       = var.public_sn
  tag {
    name = "Bastion"
  }
}
