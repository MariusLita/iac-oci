resource "oci_core_vcn" "mrs-vcn" {
    compartment_id = var.compartment_id
    display_name = "Marius-VCN"
    cidr_blocks= ["172.20.0.0/16"]
}

# Creation of Internet Gateway

resource "oci_core_internet_gateway" "IGW" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mrs-vcn.id
    display_name = "IGW"
}

# Creation of NAT Gateway

resource "oci_core_nat_gateway" "NGW" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mrs-vcn.id
    display_name = "NAT-GW"
}

# Creation of Public-RT 

resource "oci_core_route_table" "Public-RT" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mrs-vcn.id
    display_name = "Public-RT"
    route_rules {
        network_entity_id = oci_core_internet_gateway.IGW.id
        destination = "0.0.0.0/0"
    }
}       

# Creation of Private-RT 

resource "oci_core_route_table" "Private-RT" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mrs-vcn.id
    display_name = "Private-RT"
    route_rules {
        network_entity_id = oci_core_nat_gateway.NGW.id
        destination = "0.0.0.0/0"
    }
}   

# Creation of Public-SL

resource "oci_core_security_list" "Public-SL"{
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mrs-vcn.id
    display_name = "Public-Security"
    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
    }
    ingress_security_rules{
        source = "0.0.0.0/0"
        protocol = "6"
        tcp_options {
            max = 22
            min = 22
        }
    }
    ingress_security_rules{
        source = "172.20.1.0/24"
        protocol = "all"
    }
}

# Creation of Private-SL

resource "oci_core_security_list" "Private-SL" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mrs-vcn.id
    display_name = "Private-Security"
    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "all"
    }
    ingress_security_rules{
        source = "172.20.1.0/24"
        protocol = "all"
    }
}

# Creation of NSG for traffic on port 80

resource "oci_core_network_security_group" "MyNSG" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mrs-vcn.id
    display_name = "NSG-Port80"
}

resource "oci_core_network_security_group_security_rule" "nsg-rule" {
    network_security_group_id = oci_core_network_security_group.MyNSG.id
    direction = "INGRESS"
    protocol = "6"
    description = " Allow port 80 to web serv"
    source = "0.0.0.0/0"
    tcp_options {
        destination_port_range {
            max = "80"
            min = "80"
        }
    }
}

# Creation of public subnet

resource "oci_core_subnet" "public-sub" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mrs-vcn.id
    cidr_block = "172.20.1.0/24"
    display_name = "Public-Subnet"
    route_table_id = oci_core_route_table.Public-RT.id
    security_list_ids = [oci_core_security_list.Public-SL.id]
}

# Creation of private subnet

resource "oci_core_subnet" "private-sub" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.mrs-vcn.id
    cidr_block = "172.20.2.0/24"
    display_name = "Private-Subnet"
    route_table_id = oci_core_route_table.Private-RT.id
    security_list_ids = [oci_core_security_list.Private-SL.id]
}