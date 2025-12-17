data "aws_eks_cluster" "eks-cluster" {
  name = "${local.env}-${local.org}-${var.cluster-name}"

  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "eks-cluster-auth" {
  name = "${local.env}-${local.org}-${var.cluster-name}"
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "${local.env}-${local.org}-${var.vpc-name}"
  }
}
