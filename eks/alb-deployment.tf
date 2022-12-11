module "alb_ingress_controller" {
  source  = "iplabs/alb-ingress-controller/kubernetes"
#   source="hashicorp/aws"
  version = "~> 3.4.0"

  providers = {
    kubernetes = "kubernetes.eks"
  }

  k8s_cluster_type = "eks"
  k8s_namespace    = "kube-system"

#   aws_region_name  = data.aws_region.current.name
  k8s_cluster_name = ws_eks_cluster.eks.name
}