variable "aws_region" {

  description = "AWS Region"
  type        = string
  default     = "ap-south-1"

}

variable "project_name" {

  type    = string
  default = "bmi-health-tracker"

}

variable "environment" {

  type    = string
  default = "dev"

}

variable "vpc_cidr" {

  type    = string
  default = "10.0.0.0/16"

}

variable "instance_type" {

  type    = string
  default = "t3.micro"

}

variable "monitoring_instance_type" {

  type    = string
  default = "t3.small"

}

variable "db_username" {

  type = string

}

variable "db_password" {

  type      = string
  sensitive = true

}



variable "key_name" {

  description = "AWS Key Pair"

  type = string

}