
/*
resource "oci_core_instance" "Web-1" {
    availability_domain = var.availability_domain
    compartment_id = var.compartment_id
    shape = var.shape
    display_name = "Web-1"
    create_vnic_details {
        nsg_ids = [var.nsg_id]
        subnet_id = var.public_sub
        assign_public_ip = "true"
    }
    shape_config {
        memory_in_gbs = var.memory
        ocpus = var.ocpu
    }
    source_details {
        source_id = var.image
        source_type = "Image"
    }
    metadata = {
        ssh_authorized_keys = file("<Path to public key>")
        user_data = base64encode(file("/Users/lmarius/Documents/My-Files/OCI-Terraform/webserver.sh")) 
    }

# sends the private key to the web01 instance    
    provisioner "file" {
        source = "< Path to private key >"
        destination = "/home/opc/mykey"

        connection {
            type = "ssh"
            user = "opc"
            private_key = file("< Path to private key>")
            host = self.public_ip
        }
    }

# sends the configs to the web01 instance  for oci cli   
    provisioner "file" {
        source = "<Path to the oci cli config file>"
        destination = "/home/opc/.oci"

        connection {
            type = "ssh"
            user = "opc"
            private_key = file("< Path to private key > ")
            host = self.public_ip
        }
    }

# change the permission for mykey file
    provisioner "remote-exec" {
        inline = [
            "chmod 600 /home/opc/mykey",
            "sudo dnf -y install oraclelinux-developer-release-el9",
            "sudo dnf -y install python39-oci-cli",
            "oci setup repair-file-permissions --file /home/opc/.oci/config",
            "oci setup repair-file-permissions --file /home/opc/.oci/priv_key.pem"
        ]

        connection {
            type = "ssh"
            user = "opc"
            private_key = file("<Path to private key >y")
            host = self.public_ip
        }
    }
    depends_on = [oci_core_instance.Web-1]
}


resource "oci_core_instance" "Web-2" {
    availability_domain = var.availability_domain
    compartment_id = var.compartment_id
    shape = var.shape
    display_name = "Web-2"
    create_vnic_details {
        nsg_ids = [var.nsg_id]
        subnet_id = var.private_sub
        assign_public_ip = "false"
    }
    shape_config {
        memory_in_gbs = var.memory
        ocpus = var.ocpu
    }
    source_details {
        source_id = var.image
        source_type = "Image"
    }
    metadata = {
        ssh_authorized_keys = file("<Path to public key>")
        user_data = base64encode(file("/Users/lmarius/Documents/My-Files/OCI-Terraform/webserver.sh")) 
    }
} 
*/