#resource "aws_s3_bucket" "bucket" {
#  bucket = "${lower(var.company_name)}-${lower(var.org_name)}-${lower(var.service_name)}-access-logs"
#  tags {
#    Name        = "${lower(var.company_name)}-${lower(var.org_name)}-${lower(var.service_name)}-access-logs"
#    Environment = "${var.company_name}-${var.org_name}"
#  }
#}
resource "aws_elb" "service" {
  name            = "${var.service_name}-${var.service_version}"
  subnets         = ["${data.consul_keys.aws_infra.var.subnet_id}"]
  security_groups = ["${data.consul_keys.aws_infra.var.security_group}"]
  internal        = "${var.internal_service}"
  instances       = ["${module.aws.instance_ids}"]

  listener {
    instance_port     = "${var.service_port}"
    instance_protocol = "http"
    lb_port           = "${var.service_port}"
    # lb_protocol = "${var.lb_protocol}"
    lb_protocol        = "http"
  }

  health_check {
    healthy_threshold   = "${var.service_healthcheck_healthy_threshold}"
    unhealthy_threshold = "${var.service_healthcheck_unhealthy_threshold}"
    timeout             = "${var.service_healthcheck_timeout}"
    target              = "HTTP:${var.service_port}/${var.service_healthcheck}"
    interval            = "${var.service_healthcheck_interval}"
  }
  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"
  tags {
    Name = "${var.service_name}-${var.service_version}"
  }
}

resource "aws_lb_cookie_stickiness_policy" "cookie_stickness" {
  name                     = "${var.service_name}-${var.service_version}-cookiestickness"
  load_balancer            = "${aws_elb.service.id}"
  lb_port                  = "${var.service_port}"
  cookie_expiration_period = 600
}
