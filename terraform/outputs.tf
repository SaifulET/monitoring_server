output "bastion_public_ip" {

  value = module.bastion.public_ip

}

output "app_private_ip" {

  value = module.app_server.private_ip

}

output "monitoring_public_ip" {

  value = module.monitoring_server.public_ip

}

output "rds_endpoint" {

  value = module.rds.endpoint

}