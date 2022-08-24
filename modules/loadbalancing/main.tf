# ----- modules/loadbalancing/main.tf

resource "aws_lb" "webserver_lb" {
  name                       = var.webserver_lb_name
  load_balancer_type         = var.load_balancer_type
  internal                   = var.internal_lb
  security_groups            = [var.security_groups]
  subnets                    = var.public_subnets
  enable_deletion_protection = var.enable_deletion_protection # if true it can cuase problems or it wont destroy


  tags = {
    Environment = "project"
  }
}

resource "aws_lb_listener" "webserver_lb_listener" {
  load_balancer_arn = aws_lb.webserver_lb.arn
  port              = var.listener_port
  protocol          = var.tg_protocol

  default_action {
    type             = var.lb_listener_action_type
    target_group_arn = aws_lb_target_group.webserver_lb_tg.arn
  }
}

resource "aws_lb_target_group" "webserver_lb_tg" {
  name     = var.lb_tg_name
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = var.lb_healthy_threshold
    unhealthy_threshold = var.lb_unhealthy_threshold
    timeout             = var.lb_timeout
    interval            = var.lb_interval
  }
}
