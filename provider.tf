# Configure the AWS Provider
provider "aws" {
  region = var.region
  # Set access & secret vars values in terraform.tfvars file or export as sys env vars
  access_key = var.access_key
  secret_key = var.secret_key

  # $ export AWS_SECRET_ACCESS_KEY=...
  # $ export AWS_ACCESS_KEY_ID=..
}
# data "aws_region" "current" {
# }