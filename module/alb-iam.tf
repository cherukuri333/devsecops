variable "cluster_name" {}
variable "oidc_provider_arn" {}
variable "cluster_oidc_issuer" {}

resource "aws_iam_role" "alb_ingress_role" {
  name = "${var.cluster_name}-alb-ingress-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(var.cluster_oidc_issuer, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "alb_ingress_attach" {
  role       = aws_iam_role.alb_ingress_role.name
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
}

output "alb_ingress_role_arn" {
  value = aws_iam_role.alb_ingress_role.arn
}
