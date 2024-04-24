resource "aws_route53domains_registered_domain" "this" {
  domain_name = var.domain_name

    dynamic "name_server" {
    for_each = toset(aws_route53_zone.this.name_servers)
    content{
       name = name_server.value
    }
  }

  tags = {
    Environment = "test"
  }
}