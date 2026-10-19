terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "environment" {
  description = "Name of the environment, used in resource names and tags."
  type        = string
}

variable "region" {
  description = "AWS region the stack deploys to."
  type        = string
}

variable "instance_count" {
  description = "Number of instances of the network."
  type        = number
  default     = 1
}

variable "tags" {
  description = "Extra tags applied to every resource."
  type        = map(string)
  default     = {}
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "nimzo-network-${var.environment}"

  tags = merge(var.tags, {
    Environment = var.environment
    Component   = "network"
  })
}
