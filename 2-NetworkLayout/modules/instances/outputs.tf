output "bastions" {
  value = [
    for instance in aws_instance.bastion:
      instance
  ]
}

output "apps" {
  value = [
    for instance in aws_instance.app:
      instance
  ]
}
