resource "aws_route53_record" "service" {
  count   = "${length(module.aws.instance_ips)}"
  zone_id = "${data.consul_keys.dns.var.dns_zone}"
  name    = "${var.proxy_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${module.aws.instance_ips}"]
}
