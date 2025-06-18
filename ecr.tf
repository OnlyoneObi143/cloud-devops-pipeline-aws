provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "devops_app" {
  name                 = "node-app-devops"
  image_tag_mutability = "MUTABLE" #so you can push new images if need be

  image_scanning_configuration {
    scan_on_push = true #enables security scans when you upload Docker images
  }
}
