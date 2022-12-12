# module "alb_ingress_controller" {
#   source  = "iplabs/alb-ingress-controller/kubernetes"
# #   source="hashicorp/aws"
#   version = "~> 3.4.0"

#   providers = {
#     kubernetes = "kubernetes.eks"
#   }

#   k8s_cluster_type = "eks"
#   k8s_namespace    = "kube-system"

# #   aws_region_name  = data.aws_region.current.name
#   k8s_cluster_name = aws_eks_cluster.eks.name
# }


# provider "kubernetes" {
#   alias = "eks"
#   host = aws_eks_cluster.eks.endpoint
#   cluster_ca_certificate = base64decode(aws_eks_cluster.eks.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.aws_iam_authenticator.token
# #   load_config_file       = false

# }

# data "aws_eks_cluster_auth" "aws_iam_authenticator" {
#   name = aws_eks_cluster.eks.name
# }