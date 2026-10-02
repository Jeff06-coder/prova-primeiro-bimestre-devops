terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend S3 simplificado — compativel com AWS Academy (sem KMS, sem lock avancado).
  # Preencha bucket e dynamodb_table com os nomes criados pelo modulo backend/.
  # Execute "terraform init -reconfigure" apos criar o backend pela primeira vez.
  backend "s3" {
    bucket         = "bucket-lab333_aleaulas"
    key            = "reservas-api/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}
