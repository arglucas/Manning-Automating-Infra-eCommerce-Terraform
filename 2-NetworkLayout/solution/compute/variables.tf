variable "key_pair_name" {
    type = string
    default = "myLabKeyPair"
}

variable "BastionSG" {
    type = string
}

variable "publicSubnetA" {
    type = string
}

variable "AppSG" {
    type = string
}

variable "appA" {
    type = string
}

variable "appB" {
    type = string
}

variable "appC" {
    type = string
}
