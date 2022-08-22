# ------------- root/outputs.tf

output "ALB_DNS" {
  description = "The ALBs DNS"
  value       = module.loadbalancing
}

