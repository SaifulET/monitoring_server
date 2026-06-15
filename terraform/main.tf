module "vpc" {

  source = "./modules/vpc"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr

}


module "security_groups" {

  source = "./modules/security-groups"

  project_name = var.project_name

  vpc_id = module.vpc.vpc_id

}

module "bastion" {

  source = "./modules/bastion"

  project_name = var.project_name

  subnet_id = module.vpc.public_subnet_1_id

  security_group_id = module.security_groups.bastion_sg_id

  key_name = var.key_name

}

module "app_server" {

  source = "./modules/app-server"

  project_name = var.project_name

  subnet_id = module.vpc.private_subnet_1_id

  security_group_id = module.security_groups.app_sg_id

  key_name = var.key_name

}

module "monitoring_server" {

  source = "./modules/monitoring-server"

  project_name = var.project_name

  subnet_id = module.vpc.public_subnet_2_id

  security_group_id = module.security_groups.monitoring_sg_id

  key_name = var.key_name

}

module "rds" {

  source = "./modules/rds"

  db_username = var.db_username

  db_password = var.db_password

  subnet_1 = module.vpc.private_subnet_1_id

  subnet_2 = module.vpc.private_subnet_2_id

  security_group_id = module.security_groups.rds_sg_id

}