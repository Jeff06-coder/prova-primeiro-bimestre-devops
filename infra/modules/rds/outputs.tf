output "db_endpoint" {
  description = "Endpoint de conexao com o RDS (host:porta)"
  value       = aws_db_instance.postgres.endpoint
}

output "db_host" {
  description = "Hostname do RDS (sem porta)"
  value       = aws_db_instance.postgres.address
}

output "db_port" {
  description = "Porta do RDS"
  value       = aws_db_instance.postgres.port
}

output "db_name" {
  description = "Nome do banco de dados"
  value       = aws_db_instance.postgres.db_name
}
