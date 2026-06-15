data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

}


resource "aws_instance" "monitoring" {

  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  key_name = var.key_name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  associate_public_ip_address = true

  tags = {

    Name = "${var.project_name}-monitoring"

  }

}



