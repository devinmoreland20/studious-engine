#--------- module/security/outputs.tf
output "public_ALB" {
  value = aws_security_group.public_ALB.id
}

output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}
output "public_http_sg" {
  value = aws_security_group.public_http_sg.id
}



