resource "consul_keys" "app" {
  datacenter = "${var.consul_dc}"
  # token      = "abcd"

  # Set the CNAME of our load balancer as a key
  key {
    path  = "services/${var.env}/${var.service_name}/version"
    value = "${var.version}"
  }
}