resource "aws_db_subnet_group" "this" {
  name = "${var.project}-${var.env}-rds-subnet-group"
  subnet_ids = var.subnet_ids
}
