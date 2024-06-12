provider "aws" {
  region = "us-west-2" 
}

resource "aws_db_instance" "AbhiDB" {
  allocated_storage    = 20
  max_allocated_storage = 100 
  engine               = "postgres"
  engine_version       = "12.4"
  instance_class       = "db.t3.micro"
  name                 = "exampledb"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.example.name
  vpc_security_group_ids = [aws_security_group.example.id]
  parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true
  publicly_accessible  = false 
}

resource "aws_db_subnet_group" "AbhiDB" {
  name       = "example-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "AbhiDB" {
  name        = "example-sg"
  description = "Allow PostgreSQL traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID for the RDS instance"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "A list of CIDR blocks that are allowed to access the RDS instance"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Change to your preferred CIDR blocks
}

output "endpoint" {
  value = aws_db_instance.example.endpoint
}

output "username" {
  value = aws_db_instance.example.username
}

output "password" {
  value = aws_db_instance.example.password
}
