module "vpc" {
  source                           = "terraform-aws-modules/vpc/aws"

  name                             = "${var.namespace}-vpc"
  cidr                             = "172.16.0.0/16"

  azs                              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets                   = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
  private_subnets                  = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
  database_subnets                 = ["172.16.8.0/24", "172.16.9.0/24", "172.16.10.0/24"]
  
  create_database_subnet_group     = true
  enable_nat_gateway               = true
}

resource "aws_security_group" "bastion_sg" {
  name = "bastion_sg"
  description = "Bastion Security Group"
  vpc_id = module.vpc.vpc_id

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  name = "app_sg"
  description = "App Security Group"
  vpc_id = module.vpc.vpc_id

  # SSH access from bastions
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    security_groups = [
      aws_security_group.bastion_sg.id
    ]
  }

  # Outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
