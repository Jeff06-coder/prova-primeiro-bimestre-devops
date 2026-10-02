variable "project" {
  description = "Prefixo de nome para os recursos"
  type        = string
  default     = "reservas"
}

variable "public_subnet_id" {
  description = "ID da subnet publica onde a instancia sera provisionada"
  type        = string
}

variable "ec2_sg_id" {
  description = "ID do Security Group da EC2"
  type        = string
}
