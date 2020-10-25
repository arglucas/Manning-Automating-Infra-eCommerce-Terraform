output "vpc" {
  value = module.vpc
}

output "bastion_sg" {
  value = aws_security_group.bastion_sg
}

output "app_sg" {
  value = aws_security_group.app_sg
}
