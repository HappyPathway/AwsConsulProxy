resource "aws_route53_record" "proxy_service" {
  count   = "${length(module.aws.instance_ips)}"
  zone_id = "${data.consul_keys.dns.var.dns_zone}"
  name    = "${var.proxy_name}"
  type    = "A"
  ttl     = "300"
  records = ["${module.aws.instance_ips}"]
}
