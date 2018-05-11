resource "aws_route53_record" "proxy_service" {
  depends_on = [
    "module.aws"
  ]
  count   = "${var.count)}"
  zone_id = "${data.consul_keys.dns.var.dns_zone}"
  name    = "${var.proxy_name}"
  type    = "A"
  ttl     = "300"
  records = ["${module.aws.instance_ips}"]
}
