resource "aws_iam_role" "nodes_general" {
#   name of the role
 name = "eks-node-group-general"
assume_role_policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]

}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
# The ARN policy you want to apply it
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

# The role the policy should applied to
role = aws_iam_role.nodes_general.name

}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
# policy to be applied
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

#The role name
  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registery_read_only" {
# policy to be applied
  policy_arn = "arn:aws:iam::aws:policy:/AmazonEC2ContainerRegistryReadOnly"

#The role name  
  role = aws_iam_role.nodes_general.name
}

resource "aws_eks_node_group" "nodes_general" {
# Name of the EKS cluster
cluster_name = aws_eks_cluster.eks.name
# Name of the EKS node group
node_group_name = "nodes_general"
# Amazon Resource Name (ARN) of the IAM Role that provides permission for EKS
node_role_arn = aws_iam_role.nodes_general.arn

# Identifiers of EC2 subnets to associate with the EKS node group
# These subnets must have the following resource tag : kubernetes.io/cluster/CLUSTER_NAME
# (Where CLUSTER_NAME is replaced with the name of the EKS cluster)

# private subnets for workers to deploy
# public subnets for loadbalncers to deploy
subnet_ids = [ 
    aws_subnet.private_1-us-east-2a.id,
    aws_subnet.private_2-us-east-2b.id
]

scaling_config {
#   Desired number of worker nodes
  desired_size = 1

#Maximum number of worker nodes
  max_size = 3

#Minimum number of worker nodes
  min_size = 1

}

# Type of Amazon Machine Image (AMI) associated with the EKS node group
#Valid values AL2_X86_64, AL2_X86_64_GPU, AL2_ARM_64
ami_type = AL2_X86_64

# Type of capacity associated with EKS node group
# Valid Values : ON_DEMAND, SPOT
  capacity_type = "ON_DEMAND"

#Disk size in GiB for worker nodes (in production generally we use 100GB)
disk_size = 10

# force version update if existing pods are unable to be drained due to a pod disruption budget issue
force_update_version = false

# List of instance types associated with EKS Node Group
instance_types = [
    "t3.small"
]

labels = {
  role = "nodes-general"
}
# kubernetes version
# it is optional , if it is not specified here then it will inherit from eks
version = "1.22"

# Ensure that IAM Role Permissions are created before and deleted after EKS node group 
# Otherwise, EKS will not be able to properly delete EC2 instances and Elastic Network

depends_on = [
  aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
  aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
  aws_iam_role_policy_attachment.amazon_ec2_container_registery_read_only
]

}