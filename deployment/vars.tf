variable "consul_address" {
    default = "consul.ops.happypathway.com:8500"
}

variable "consul_dc" {
    default = "dc1"
}

variable "service_name" {}
variable "env" {}
variable "service_version" {}