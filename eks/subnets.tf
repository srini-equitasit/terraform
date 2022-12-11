resource "aws_subnet" "public_1-us-east-2a" {
#   the vpc id
vpc_id = aws_vpc.main.id

# the cidr block for subnet
cidr_block = "10.0.0.0/24"

# The AZ for subnet
availability_zone = "us-east-2a"

# Required for EKS, it means every instance deployed in public subnet will auomatically get public ip address
map_public_ip_on_launch = true

tags = {
  Name = "public_1-us-east-2a"
#   below two are required
# clustering is shared, it means that cluster will allow eks cluster discover this particular subnet and use it.
  "Kubernetes.io/cluster/eks" = "shared"
  "Kubernates.io/role/elb" = 1
}

}


resource "aws_subnet" "public_2-us-east-2b" {
#   the vpc id
vpc_id = aws_vpc.main.id

# the cidr block for subnet
cidr_block = "10.0.1.0/24"

# The AZ for subnet
availability_zone = "us-east-2b"

# Required for EKS, it means every instance deployed in public subnet will auomatically get public ip address
map_public_ip_on_launch = true

tags = {
  Name = "public_2-us-east-2b"
#   below two are required
# clustering is shared, it means that cluster will allow eks cluster discover this particular subnet and use it.
  "Kubernetes.io/cluster/eks" = "shared"
  "Kubernates.io/role/elb" = 1
}

}

# create two private subnets

resource "aws_subnet" "private_1-us-east-2a" {
#   the vpc id
vpc_id = aws_vpc.main.id

# the cidr block for subnet
cidr_block = "10.0.2.0/24"

# The AZ for subnet
availability_zone = "us-east-2a"



tags = {
  Name = "private_1-us-east-2a"
#   below two are required
# clustering is shared, it means that cluster will allow eks cluster discover this particular subnet and use it.
  "Kubernetes.io/cluster/eks" = "shared"
  "Kubernates.io/role/internal-elb" = 1
}

}

resource "aws_subnet" "private_2-us-east-2b" {
#   the vpc id
vpc_id = aws_vpc.main.id

# the cidr block for subnet
cidr_block = "10.0.3.0/24"

# The AZ for subnet
availability_zone = "us-east-2b"



tags = {
  Name = "private_2-us-east-2b"
#   below two are required
# clustering is shared, it means that cluster will allow eks cluster discover this particular subnet and use it.
  "Kubernetes.io/cluster/eks" = "shared"
  "Kubernates.io/role/internal-elb" = 1
}

}