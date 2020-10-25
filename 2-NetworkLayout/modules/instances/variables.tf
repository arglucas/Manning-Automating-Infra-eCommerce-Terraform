variable "namespace" {
  type = string
}

variable "ssh_keypair" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "bastion_sg" {
  type = string
}

variable "app_sg" {
  type = string
}
