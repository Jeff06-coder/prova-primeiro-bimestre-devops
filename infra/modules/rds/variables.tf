variable "project" {
  description = "Prefixo de nome para os recursos"
  type        = string
  default     = "reservas"
}

variable "private_subnet_ids" {
  description = "IDs das subnets privadas para o DB Subnet Group"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "ID do Security Group do RDS"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados a ser criado"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuario administrador do banco de dados"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Senha do usuario administrador (use variaveis de ambiente ou secrets manager)"
  type        = string
  sensitive   = true
}
