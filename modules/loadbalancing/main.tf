# ----- modules/loadbalancing/main.tf

resource "aws_lb" "webserver_lb" {
  name                       = "webserver-lb"
  load_balancer_type         = "application"
  internal                   = false
  security_groups            = [var.security_groups]
  subnets                    = var.public_subnets
  enable_deletion_protection = false # if true it can cuase problems or it wont destroy


  tags = {
    Environment = "project"
  }
}

resource "aws_lb_listener" "webserver_lb_listener" {
  load_balancer_arn = aws_lb.webserver_lb.arn
  port              = var.listener_port
  protocol          = var.tg_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver_lb_tg.arn
  }
}

resource "aws_lb_target_group" "webserver_lb_tg" {
  name     = "webserver-lb-tg"
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
