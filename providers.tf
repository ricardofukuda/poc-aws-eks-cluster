terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }
  }
  
  backend "s3" {
    bucket = "tf-poc-aws-eks-cluster"
    key    = "terraform.tf"
    region = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    command     = "aws"
    api_version = "client.authentication.k8s.io/v1beta1"
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      command     = "aws"
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}