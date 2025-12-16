provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks[0].endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set { name = "clusterName";           value = var.cluster-name }
  set { name = "serviceAccount.create"; value = "false" }
  set { name = "serviceAccount.name";   value = "aws-load-balancer-controller" }
  set { name = "region";                value = var.region }
  set { name = "vpcId";                 value = module.vpc.vpc_id }

  depends_on = [module.iam.alb_ingress_role]
}
