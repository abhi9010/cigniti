provider "aws" {
  region = "us-west-2" # Change to your preferred region
}

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "12.4"
  instance_class       = "db.t3.micro"
  name                 = "exampledb"
  username             = "username"
  password             = "password"
  parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true
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
