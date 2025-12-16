module "alb_iam" {
  source              = "../module/alb_iam"
  cluster_name        = var.cluster_name
  oidc_provider_arn   = aws_iam_openid_connect_provider.eks_oidc.arn
  cluster_oidc_issuer = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

module "alb_controller" {
  source        = "../module/alb_controller"
  cluster_name  = var.cluster_name
  region        = var.region
  vpc_id        = module.network.vpc_id   # replace with your actual VPC module name
  alb_role_arn  = module.alb_iam.alb_ingress_role_arn
}

output "alb_role_arn" {
  value = module.alb_iam.alb_ingress_role_arn
}
