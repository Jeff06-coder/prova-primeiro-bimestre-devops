# Busca a AMI mais recente do Amazon Linux 2023 em us-east-1
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "api" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.ec2_sg_id]

  # Referencia o instance profile pre-existente do AWS Academy.
  # NAO criar roles ou policies — a SCP proibe.
  iam_instance_profile = "LabInstanceProfile"

  # User data: instala Docker e sobe o container da API ao inicializar
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl enable docker
    systemctl start docker
    usermod -aG docker ec2-user
  EOF

  tags = { Name = "${var.project}-ec2-api" }
}
