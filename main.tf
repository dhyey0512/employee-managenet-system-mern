# Define the required provider for AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = "us-east-1"  # Specify the AWS region
}
resource "aws_instance" "Jenkins_Server" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  tags = {
    Name = "Jenkins Server"
  }
}

# Create an S3 bucket resource
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-dhyey051202"  # Set a unique bucket name
  acl    = "private"                # Set bucket to private (default)

  tags = {
    Name        = "Terraform S3 Bucket"
    Environment = "Dev"
  }
}




