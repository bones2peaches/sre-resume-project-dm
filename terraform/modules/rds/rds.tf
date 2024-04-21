resource "aws_db_instance" "this" {
  allocated_storage             = var.allocated_storage # The minimum storage in GB for PostgreSQL on RDS
  storage_type                  = var.storage_type
  engine                        = var.engine
  engine_version                = var.engine_version    # Specify your desired PostgreSQL version
  instance_class                = var.instance_class # Low-tier instance class
  identifier                    = var.db_identifier
  username                      = var.db_user
  manage_master_user_password   = true
  skip_final_snapshot           = var.skip_snapshot 
  db_name                       = var.db_name

  port                          = var.db_port

  master_user_secret_kms_key_id = aws_kms_key.this.arn

  vpc_security_group_ids = [aws_security_group.this.id]


  db_subnet_group_name = aws_db_subnet_group.this.name


}