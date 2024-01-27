locals {
  port = 3306
}

output "context" {
  description = "The input context, a map, which is used for orchestration."
  value       = var.context
}

output "connection" {
  description = "The connection, a string combined host and port, might be a comma separated string or a single string."
  value       = google_sql_database_instance.instance.connection_name
}

output "address" {
  description = "The address, a string only has host, might be a comma separated string or a single string."
  value       = google_sql_database_instance.instance.public_ip_address
}

output "dns_name" {
  description = "The DNS name of the instance."
  value       = google_sql_database_instance.instance.dns_name
}

output "port" {
  description = "The port of the service."
  value       = local.port
}

output "database" {
  description = "The name of MySQL database to access."
  value       = local.database
}

output "username" {
  description = "The username of the account to access the database."
  value       = local.username
}

output "password" {
  description = "The password of the account to access the database."
  value       = local.password
  sensitive   = true
}
