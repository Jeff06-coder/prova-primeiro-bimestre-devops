terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Bucket S3 para o Terraform state.
# force_destroy = true permite destruir mesmo com objetos dentro.
# Versionamento avancado, KMS e Object Lock OMITIDOS — SCP do Academy bloqueia.
resource "aws_s3_bucket" "tf_state" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name    = var.bucket_name
    Project = var.project
  }
}

# OBRIGATORIO no AWS Academy: desabilita ACLs no bucket.
# A SCP da conta bloqueia qualquer operacao com ACL (AccessDenied).
# BucketOwnerEnforced = ACLs desativadas, owner da conta controla tudo.
resource "aws_s3_bucket_ownership_controls" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Tabela DynamoDB para state locking (atributo LockID exigido pelo Terraform)
resource "aws_dynamodb_table" "tf_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = var.dynamodb_table_name
    Project = var.project
  }
}
