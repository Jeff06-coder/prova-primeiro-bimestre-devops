output "ec2_public_ip" {
  description = "IP publico da instancia EC2 — use para acessar a API e fazer SSH"
  value       = module.ec2.public_ip
}

output "ec2_public_dns" {
  description = "DNS publico da instancia EC2"
  value       = module.ec2.public_dns
}

output "api_url" {
  description = "URL de acesso a API de Reservas na AWS"
  value       = "http://${module.ec2.public_ip}:3000"
}

output "rds_endpoint" {
  description = "Endpoint completo do RDS (host:porta) — use como DB_HOST na EC2"
  value       = module.rds.db_endpoint
}

output "rds_host" {
  description = "Hostname do RDS sem porta"
  value       = module.rds.db_host
}

output "rds_port" {
  description = "Porta do RDS PostgreSQL"
  value       = module.rds.db_port
}

output "rds_db_name" {
  description = "Nome do banco de dados criado no RDS"
  value       = module.rds.db_name
}

output "vpc_id" {
  description = "ID da VPC provisionada"
  value       = module.vpc.vpc_id
}
