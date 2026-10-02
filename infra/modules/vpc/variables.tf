variable "project" {
  description = "Prefixo de nome para todos os recursos"
  type        = string
  default     = "reservas"
}

variable "vpc_cidr" {
  description = "CIDR block da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDRs das duas subnets publicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDRs das duas subnets privadas"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "availability_zones" {
  description = "Lista de duas AZs em us-east-1"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
