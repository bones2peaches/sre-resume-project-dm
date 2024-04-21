resource "aws_vpc_endpoint" "ecr_dkr" {
  count = length(var.region_names)
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region_names[count.index]}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.subnet_ids
  depends_on = [ var.sg_id ]
  
  security_group_ids = [
    var.sg_id
  ]

    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

  tags = {
    Name = "${var.project}-${var.env}-ecr-dkr-vpce"
  }
}


resource "aws_vpc_endpoint" "ecr_api" {
  count = length(var.region_names)
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region_names[count.index]}.ecr.api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.subnet_ids
  depends_on = [ var.sg_id ]
  
  security_group_ids = [
    var.sg_id
  ]

    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

  tags = {
    Name = "${var.project}-${var.env}-ecr-api-vpce"
  }
}

resource "aws_vpc_endpoint" "logs" {
  count = length(var.region_names)
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region_names[count.index]}.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.subnet_ids
  depends_on = [ var.sg_id ]
  
  security_group_ids = [
    var.sg_id
  ]

    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

  tags = {
    Name = "${var.project}-${var.env}-logs-vpce"
  }
}


resource "aws_vpc_endpoint" "kms" {
  count = length(var.region_names)
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region_names[count.index]}.kms"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.subnet_ids
  depends_on = [ var.sg_id ]
  
  security_group_ids = [
    var.sg_id
  ]

    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

  tags = {
    Name = "${var.project}-${var.env}-kms-vpce"
  }
}

resource "aws_vpc_endpoint" "secretsmanager" {
  count = length(var.region_names)
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region_names[count.index]}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = var.subnet_ids
  depends_on = [ var.sg_id ]
  
  security_group_ids = [
    var.sg_id
  ]

    policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

  tags = {
    Name = "${var.project}-${var.env}-secretsmanager-vpce"
  }
}

resource "aws_vpc_endpoint" "s3" {
  count = length(var.region_names)
  vpc_id              = var.vpc_id
  service_name    = "com.amazonaws.${var.region_names[count.index]}.s3"
  route_table_ids = var.route_table_ids

  vpc_endpoint_type = "Gateway"

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

  tags = {
    Name = "${var.project}-${var.env}-s3-vpce"
  }
}
