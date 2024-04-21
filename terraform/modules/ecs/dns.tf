resource "aws_acm_certificate" "this" {
  domain_name       = "${var.env}.${var.domain_name}"
  validation_method = "DNS"
}

resource "aws_route53_record" "this" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}


resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}

# Step 6: Create an A Record
resource "aws_route53_record" "lb_record" {
  zone_id = var.zone_id
  name    = "${var.env}.${var.domain_name}"
  type    = "A"
  depends_on = [ aws_lb.this ]

  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}