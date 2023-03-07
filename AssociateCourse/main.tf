#Starting the main file
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
    profile = default 
    region = "us-east-1"
}

# Create a VPC
resource "aws_instance" "example" {
    ami = "ami-830c948"
}
