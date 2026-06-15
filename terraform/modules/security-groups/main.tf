resource "aws_security_group" "bastion_sg" {

  name        = "${var.project_name}-bastion-sg"
  description = "Bastion Security Group"

  vpc_id = var.vpc_id

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "${var.project_name}-bastion-sg"

  }

}


resource "aws_security_group" "app_sg" {

  name        = "${var.project_name}-app-sg"
  description = "Application Security Group"

  vpc_id = var.vpc_id

}



resource "aws_security_group_rule" "app_ssh" {

  type = "ingress"

  from_port = 22
  to_port   = 22

  protocol = "tcp"

  security_group_id = aws_security_group.app_sg.id

  source_security_group_id = aws_security_group.bastion_sg.id

}


resource "aws_security_group_rule" "app_http" {

  type = "ingress"

  from_port = 80
  to_port   = 80

  protocol = "tcp"

  security_group_id = aws_security_group.app_sg.id

  cidr_blocks = ["0.0.0.0/0"]

}



resource "aws_security_group_rule" "app_https" {

  type = "ingress"

  from_port = 443
  to_port   = 443

  protocol = "tcp"

  security_group_id = aws_security_group.app_sg.id

  cidr_blocks = ["0.0.0.0/0"]

}



resource "aws_security_group_rule" "backend_api" {

  type = "ingress"

  from_port = 3010
  to_port   = 3010

  protocol = "tcp"

  security_group_id = aws_security_group.app_sg.id

  source_security_group_id = aws_security_group.monitoring_sg.id

}



resource "aws_security_group_rule" "app_egress" {

  type = "egress"

  from_port = 0
  to_port   = 0

  protocol = "-1"

  security_group_id = aws_security_group.app_sg.id

  cidr_blocks = ["0.0.0.0/0"]

}



resource "aws_security_group" "monitoring_sg" {

  name        = "${var.project_name}-monitoring-sg"
  description = "Monitoring Security Group"

  vpc_id = var.vpc_id

}



resource "aws_security_group_rule" "grafana" {

  type = "ingress"

  from_port = 3001
  to_port   = 3001

  protocol = "tcp"

  security_group_id = aws_security_group.monitoring_sg.id

  cidr_blocks = ["0.0.0.0/0"]

}


resource "aws_security_group_rule" "prometheus" {

  type = "ingress"

  from_port = 9090
  to_port   = 9090

  protocol = "tcp"

  security_group_id = aws_security_group.monitoring_sg.id

  cidr_blocks = ["0.0.0.0/0"]

}


resource "aws_security_group_rule" "alertmanager" {

  type = "ingress"

  from_port = 9093
  to_port   = 9093

  protocol = "tcp"

  security_group_id = aws_security_group.monitoring_sg.id

  cidr_blocks = ["0.0.0.0/0"]

}



resource "aws_security_group_rule" "loki" {

  type = "ingress"

  from_port = 3100
  to_port   = 3100

  protocol = "tcp"

  security_group_id = aws_security_group.monitoring_sg.id

  cidr_blocks = ["0.0.0.0/0"]

}



resource "aws_security_group_rule" "monitoring_egress" {

  type = "egress"

  from_port = 0
  to_port   = 0

  protocol = "-1"

  security_group_id = aws_security_group.monitoring_sg.id

  cidr_blocks = ["0.0.0.0/0"]

}


resource "aws_security_group" "rds_sg" {

  name = "${var.project_name}-rds-sg"

  description = "PostgreSQL Security Group"

  vpc_id = var.vpc_id

}


resource "aws_security_group_rule" "postgres" {

  type = "ingress"

  from_port = 5432
  to_port   = 5432

  protocol = "tcp"

  security_group_id = aws_security_group.rds_sg.id

  source_security_group_id = aws_security_group.app_sg.id

}



resource "aws_security_group_rule" "rds_egress" {

  type = "egress"

  from_port = 0
  to_port   = 0

  protocol = "-1"

  security_group_id = aws_security_group.rds_sg.id

  cidr_blocks = ["0.0.0.0/0"]

}


