# Subnet Group for RDS (use both public subnets, ya later private subnets)
resource "aws_db_subnet_group" "cloudnative" {
  name       = "cloudnative-db-subnet-group"
  subnet_ids = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]

  tags = {
    Name = "cloudnative-db-subnet-group"
  }
}

# Security Group for RDS (allow Postgres access from VPC / worker nodes)
resource "aws_security_group" "rds_sg" {
  name        = "cloudnative-rds-sg"
  description = "Allow Postgres access"
  vpc_id      = aws_vpc.cloudnative.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ⚠️ later restrict to EKS SG for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloudnative-rds-sg"
  }
}

# RDS Instance (Postgres)
resource "aws_db_instance" "cloudnative" {
  identifier             = "cloudnative-db"
  allocated_storage      = 20
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  db_name                = "mydb"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.cloudnative.name

  tags = {
    Name = "cloudnative-rds"
  }
}
