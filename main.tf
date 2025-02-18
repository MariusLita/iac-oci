module "vcn" {
  source         = "./modules/VCN"
  compartment_id = var.compartment_ocid
}
/*
module "compute" {
  source              = "./modules/compute"
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape               = var.my-shape
  ocpu                = var.ocpu
  memory              = var.mem
  nsg_id              = module.vcn.nsg_id
  image               = var.image_ocid
  public_sub          = module.vcn.public_subnet
  private_sub         = module.vcn.private_subnet
}

module "lb" {
  source         = "./modules/Networking"
  compartment_id = var.compartment_ocid
  subnet_id      = module.vcn.public_subnet
  web1_ip        = module.compute.web01_private_ip
  web2_ip        = module.compute.web02_private_ip
  nsg_id = module.vcn.nsg_id
}

output "vcn_ocid" {
  value = module.vcn.vcn_id
}


data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy
}

output "availability_domain" {
  value = data.oci_identity_availability_domains.ads.availability_domains[0].name
}

output "Web01_public-ip" {
  value = module.compute.web01_public_ip
}

output "Web02_private-ip" {
  value = module.compute.web02_private_ip
}

output "LB-IP" {
  value = module.lb.lb_ip
}
*/