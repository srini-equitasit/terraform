resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

# make your instance shared on host
  instance_tenancy = "default"

# required for EKS. Enable / disable DNS support in the VPC 
  enable_dns_support = true

# required for EKS. Enable / disable DNS hostnames in the VPC 
  enable_dns_hostnames = true

#  Enable/Disable classic link
  enable_classiclink = false

#  Enable/Disable classic link dns support
  enable_classiclink_dns_support = false

  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "main"
  }
}

output "vpc_id" {
  value=aws_vpc.main.id
  description = "vpc id"
  sensitive = false
}