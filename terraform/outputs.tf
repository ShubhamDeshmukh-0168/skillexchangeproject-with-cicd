output "app_public_ip" {
  description = "Elastic IP of the app server — this is your EC2_HOST secret for the app deploy pipeline"
  value       = aws_eip.app.public_ip
}

output "app_instance_id" {
  value = aws_instance.app.id
}

output "rds_endpoint" {
  description = "RDS address (host only, no port)"
  value       = aws_db_instance.main.address
}

output "rds_connection_string" {
  value     = "jdbc:mysql://${aws_db_instance.main.address}:3306/${var.db_name}?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
  sensitive = false
}
