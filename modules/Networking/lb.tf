# Load Balancer
resource "oci_load_balancer_load_balancer" "my-lb" {
    compartment_id = var.compartment_id
    display_name = "My-LB"
    shape = "flexible"
    subnet_ids = [var.subnet_id]

    network_security_group_ids = [var.nsg_id]
    shape_details{
        maximum_bandwidth_in_mbps = "200"
        minimum_bandwidth_in_mbps = "100"
    }
}

# Backend-Set
resource "oci_load_balancer_backend_set" "back_set" {
    load_balancer_id = oci_load_balancer_load_balancer.my-lb.id
    name = "Backend-Set"
    policy = "LEAST_CONNECTIONS"

    health_checker {
        protocol = "HTTP"
        port = "80"
        interval_ms = "8000"
        retries = "1"
        url_path = "/"
    }

}

# Listener
resource "oci_load_balancer_listener" "listener" {
    default_backend_set_name = oci_load_balancer_backend_set.back_set.name
    load_balancer_id = oci_load_balancer_load_balancer.my-lb.id
    name = "Listener-80"
    port = "80"
    protocol = "HTTP"
}
/*

# Backends
resource "oci_load_balancer_backend" "backend-1" {
    backendset_name = oci_load_balancer_backend_set.back_set.name
    ip_address = var.web1_ip
    load_balancer_id = oci_load_balancer_load_balancer.my-lb.id
    port = "80"
}

resource "oci_load_balancer_backend" "backend-2" {
    backendset_name = oci_load_balancer_backend_set.back_set.name
    ip_address = var.web2_ip
    load_balancer_id = oci_load_balancer_load_balancer.my-lb.id
    port = "80"
}
*/