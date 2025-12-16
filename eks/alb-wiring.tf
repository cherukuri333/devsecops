variable "cluster_name" {}
variable "region" {}
variable "vpc_id" {}
variable "oidc_provider_arn" {}

data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}

# IAM role for ALB controller
module "alb_iam" {
  source              = "../module"
  cluster_name        = var.cluster_name
  oidc_provider_arn   = var.oidc_provider_arn
  cluster_oidc_issuer = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

# Helm release for ALB controller
module "alb_controller" {
  source        = "../module"
  cluster_name  = var.cluster_name
  region        = var.region
  vpc_id        = var.vpc_id
  alb_role_arn  = module.alb_iam.alb_ingress_role_arn
}

output "alb_role_arn" {
  value = module.alb_iam.alb_ingress_role_arn
}
