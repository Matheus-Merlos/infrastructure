terraform {
  required_version = ">= 1.0.0, <2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.82"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~>2.67.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "digitalocean" {
  token = var.digitalocean_token
}
