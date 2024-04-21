resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id



  tags = {
    Name = "${var.project}-${var.env}-private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id



  tags = {
    Name = "${var.project}-${var.env}-public"
  }
}

resource "aws_route" "this" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.this.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}