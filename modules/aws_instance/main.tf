resource "aws_instance" "prod_ec2_instance" {
  ami                  = var.ec2_ami
  instance_type        = var.instance_type
  user_data            = var.user_data
  iam_instance_profile = var.iam_instance_profile_name
  key_name             = var.key_name
  subnet_id            = var.subnet_id

  vpc_security_group_ids = var.security_group_ids

  tags = var.prod_ec2_instance_tags
}