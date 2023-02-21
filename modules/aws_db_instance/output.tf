output "prod_db_instance_id" {
  value = aws_db_instance.prod_db_instance.id
}

output "prod_db_host" {
  description = "Retreive Daatabase instance Address"
  value       = aws_db_instance.prod_db_instance.address
}