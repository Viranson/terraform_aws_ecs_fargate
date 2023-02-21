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
