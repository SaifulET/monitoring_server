resource "aws_db_subnet_group" "postgres_subnet_group" {

  name = "bmi-postgres-subnet-group"

  subnet_ids = [
    var.subnet_1,
    var.subnet_2
  ]

  tags = {
    Name = "BMI PostgreSQL Subnet Group"
  }

}


resource "aws_db_instance" "postgres" {

  identifier = "bmi-postgres-db"

  allocated_storage = 20

  storage_type = "gp3"

  engine = "postgres"

  engine_version = "16.3"

  instance_class = "db.t3.micro"

  db_name = "bmidb"

  username = var.db_username

  password = var.db_password

  publicly_accessible = false

  multi_az = false

  skip_final_snapshot = true

  backup_retention_period = 7

  deletion_protection = false

  db_subnet_group_name = aws_db_subnet_group.postgres_subnet_group.name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  tags = {
    Name = "BMI PostgreSQL"
  }

}


