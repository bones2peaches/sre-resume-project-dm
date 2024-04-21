resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_size
  iam_instance_profile        = aws_iam_instance_profile.this.name
  vpc_security_group_ids      = [aws_security_group.this.id]
  subnet_id                   = var.subnet_id
  key_name                    = var.key_pair_name
  associate_public_ip_address = true


  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    TOKEN=data.github_actions_registration_token.this.token
    SVN_URL = var.svn_url
  }))

  tags = {
    Name = var.instance_name
  }
}