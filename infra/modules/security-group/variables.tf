variable "project" {
  description = "Prefixo de nome para os recursos"
  type        = string
  default     = "reservas"
}

variable "vpc_id" {
  description = "ID da VPC onde os SGs serao criados"
  type        = string
}
