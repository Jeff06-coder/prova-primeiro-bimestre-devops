variable "bucket_name" {
  description = "Nome do bucket S3 para armazenar o Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB para state locking"
  type        = string
  default     = "terraform-state-lock"
}

variable "project" {
  description = "Tag de projeto aplicada aos recursos"
  type        = string
  default     = "reservas-api"
}

variable "db_password" {
  description = "A senha para o banco de dados PostgreSQL"
  type        = string
  sensitive   = true
}