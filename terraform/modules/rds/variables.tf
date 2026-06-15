variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "subnet_1" {
  type = string
}

variable "subnet_2" {
  type = string
}

variable "security_group_id" {
  type = string
}