# ----- modules/loadbalancing/outputs.tf
output "lb_target_group_arn" {
  value = aws_lb_target_group.webserver_lb_tg.arn
}

output "lb_endpoint" {
  value = aws_lb.webserver_lb.dns_name
}
