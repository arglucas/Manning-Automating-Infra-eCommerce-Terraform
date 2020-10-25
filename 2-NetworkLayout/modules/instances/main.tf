data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "bastion" {
  count = length(var.public_subnets)

  ami   = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = var.public_subnets[count.index]

  key_name = var.ssh_keypair

  vpc_security_group_ids = [var.bastion_sg]

  tags = {
    Name = "bastion-${count.index}"
  }
}

resource "aws_instance" "app" {
  count = length(var.private_subnets)

  ami   = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id = var.private_subnets[count.index]

  key_name = var.ssh_keypair

  vpc_security_group_ids = [var.app_sg]
  
  tags = {
    Name = "app-${count.index}"
  }
}
