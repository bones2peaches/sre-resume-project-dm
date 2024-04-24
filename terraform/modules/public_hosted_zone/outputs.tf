output "zone_arn" {
  value = aws_route53_zone.this.arn
}

output "zone_id" {
  value = aws_route53_zone.this.zone_id
}