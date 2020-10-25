module "networking" {
  source = "./modules/networking"
  namespace = var.namespace
}

module "instances" {
  source = "./modules/instances"
  namespace = var.namespace
  ssh_keypair = var.ssh_keypair
  public_subnets = module.networking.vpc.public_subnets
  private_subnets = module.networking.vpc.private_subnets

  bastion_sg = module.networking.bastion_sg.id
  app_sg = module.networking.app_sg.id
}
