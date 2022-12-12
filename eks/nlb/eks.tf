# create role
resource "aws_iam_role" "eks_cluster" {
# The name of role
name = "eks-cluster"

# The ploicy that grants an entity permission to assume the role
# Used to access AWS resources that might not normally have access to.
# The Role that Amazon EKS will use to create AWS resources for kubernetes cluster.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# attach policy
resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {

# The ARN policy you want to apply
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

# The Role The policy should be applied to
    role = aws_iam_role.eks_cluster.name
  
}

resource "aws_eks_cluster" "eks" {

    # Name of cluster
    name = "eks"

    # The Amazon Resource Name (ARN) of the IAM Role that provides permissions for
    # the kubernetes control plane to make AWS API opertions on your behalf
    role_arn = aws_iam_role.eks_cluster.arn

    # desired kubernetes master version
    version = "1.22"

    vpc_config {
# indicate whether or not the Amazon EKS private API server endpoint is enabled 
# for VPN
      endpoint_private_access = false
# indicate whether or not Amazon EKS public API server endpoint is enabled
      endpoint_public_access = true

      subnet_ids = [
        aws_subnet.public_1-us-east-2a.id,
        aws_subnet.public_2-us-east-2b.id,
        aws_subnet.private_1-us-east-2a.id,
        aws_subnet.private_2-us-east-2b.id
      ]
}

# ensure That IAM Role permissions are created before and deleted after EKS cluster 
# Otherwise, EKS will not be able to properly delete EKS manged EC2 infra structure
depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
]
  
}