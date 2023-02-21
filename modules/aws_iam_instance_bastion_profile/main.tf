resource "aws_iam_instance_profile" "bastion" {
  name = "prod-iam-bastion-instance-profile"
  role = aws_iam_role.bastion.name
}

resource "aws_iam_role" "bastion" {
  name               = "prod-ec2IAMRole-bastion"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
}
EOF

  tags = merge(
    local.common_tags,
    {
      Name = "prod-ec2-bastion_role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "bastion_attach_policy" {
  role       = aws_iam_role.bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}