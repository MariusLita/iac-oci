output "vcn_id" {
    value = oci_core_vcn.mrs-vcn.id
}

output "nsg_id" {
    value = oci_core_network_security_group.MyNSG.id
}

output "public_subnet" {
    value = oci_core_subnet.public-sub.id
}

output "private_subnet" {
    value = oci_core_subnet.private-sub.id
}