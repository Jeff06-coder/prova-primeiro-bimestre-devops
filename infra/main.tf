# ── Modulo VPC ────────────────────────────────────────────────────────────────
module "vpc" {
  source  = "./modules/vpc"
  project = var.project
}

# ── Modulo Security Group ─────────────────────────────────────────────────────
module "security_group" {
  source  = "./modules/security-group"
  project = var.project
  vpc_id  = module.vpc.vpc_id
}

# ── Modulo EC2 ────────────────────────────────────────────────────────────────
module "ec2" {
  source           = "./modules/ec2"
  project          = var.project
  public_subnet_id = module.vpc.public_subnet_ids[0]
  ec2_sg_id        = module.security_group.ec2_sg_id
}

# ── Modulo RDS ────────────────────────────────────────────────────────────────
module "rds" {
  source             = "./modules/rds"
  project            = var.project
  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.security_group.rds_sg_id
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
}
