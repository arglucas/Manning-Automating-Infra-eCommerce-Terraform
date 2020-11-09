provider "aws" {
    region = var.region
    profile = var.profile
}

module "network" {
    source = "./network"
}

module "security" {
    source = "./security"
    vpc_id = module.network.vpc_id
}

module "compute" {
    source          = "./compute"
    publicSubnetA   = module.network.publicSubnetA
    appA            = module.network.appA
    appB            = module.network.appB
    appC            = module.network.appC
    BastionSG       = module.security.BastionSG
    AppSG           = module.security.AppSG
}
