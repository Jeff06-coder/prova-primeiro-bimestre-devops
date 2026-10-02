# DB Subnet Group utiliza as subnets privadas (minimo 2 AZs exigido pela AWS)
resource "aws_db_subnet_group" "main" {
  name        = "${var.project}-db-subnet-group"
  description = "Subnet group para o RDS PostgreSQL"
  subnet_ids  = var.private_subnet_ids

  tags = { Name = "${var.project}-db-subnet-group" }
}

resource "aws_db_instance" "postgres" {
  identifier        = "${var.project}-postgres"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]

  # Restricoes de seguranca: sem acesso publico, storage criptografado
  publicly_accessible = false
  storage_encrypted   = true

  # Facilita destruicao no ambiente de estudos (sem snapshot final)
  skip_final_snapshot = true
  deletion_protection = false

  tags = { Name = "${var.project}-postgres" }
}
