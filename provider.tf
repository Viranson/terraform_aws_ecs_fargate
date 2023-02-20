terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # backend "s3" {
  #   bucket         = "ecs-terraform-remote-state-s3"
  #   key            = "ecs.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = "true"
  #   dynamodb_table = "ecs-terraform-remote-state-dynamodb"
  # }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  # Set access & secret vars values in terraform.tfvars file or export as sys env vars
  access_key = var.access_key
  secret_key = var.secret_key

  # $ export AWS_SECRET_ACCESS_KEY=...
  # $ export AWS_ACCESS_KEY_ID=..
}