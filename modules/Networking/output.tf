output "lb_ip" {
    value = oci_load_balancer_load_balancer.my-lb.ip_address_details[0].ip_address
}