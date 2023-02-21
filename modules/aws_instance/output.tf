output "prod_ec2_instance_id" {
  value = aws_instance.prod_ec2_instance.id
}

output "prod_ec2_instance_host" {
  description = "Retreive Instance public DNS Name"
  value       = aws_instance.prod_ec2_instance.public_dns
}