resource "aws_route53_record" "service" {
  count = "${var.set_dns ? 1 : 0}"
  zone_id = "${data.consul_keys.dns.var.dns_zone}"
  name    = "${var.service_name}.${data.consul_keys.dns.var.dns_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elb.service.dns_name}"]
}