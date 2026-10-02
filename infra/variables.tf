variable "project" {
  description = "Prefixo de nome aplicado a todos os recursos AWS"
  type        = string
  default     = "reservas"
}

variable "db_password" {
  description = "Senha do banco RDS. Passe via variavel de ambiente: export TF_VAR_db_password=..."
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nome do banco de dados PostgreSQL"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuario administrador do banco de dados"
  type        = string
  default     = "postgres"
}
