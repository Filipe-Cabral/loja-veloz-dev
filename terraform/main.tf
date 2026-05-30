# main.tf – Esqueleto Terraform para EKS (Loja Veloz)
# Referência: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

terraform {
  required_version = ">= 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
  backend "s3" {
    bucket = "loja-veloz-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# ──────────────────────────────────────────
# VPC e Redes
# ──────────────────────────────────────────
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = var.common_tags
}

# ──────────────────────────────────────────
# Cluster EKS
# ──────────────────────────────────────────
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.project_name}-cluster"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    main = {
      desired_size = 2
      min_size     = 2
      max_size     = 6

      instance_types = ["t3.medium"]

      labels = {
        Environment = var.environment
      }
    }
  }

  tags = var.common_tags
}

# ──────────────────────────────────────────
# Outputs
# ──────────────────────────────────────────
output "cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = module.eks.cluster_name
}
