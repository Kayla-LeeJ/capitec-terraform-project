terraform {
  required_version = "~> 1.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {}
  #terraform init -backend-config="./values/dev/dev.tfbackend"
  #<surname><initialias>-s3-backend - naming convention for the backend bucket
}

provider "aws" {
  region = "af-south-1"
}