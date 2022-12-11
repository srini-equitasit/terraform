# First NAT Gateway
resource "aws_nat_gateway" "gw1" {
  
  # The allocation ID of the Elastic IP address for the gateway
  # Allocate public ip for nat gateway
  allocation_id = aws_eip.nat1

  # place the gatway in subnet
  subnet_id = aws_subnet.public_1-us-east-2a.id

  # A map of tags to assign to the resource
  tags = {
    Name = "NAT 1"
  }

}

# Second NAT Gateway
resource "aws_nat_gateway" "gw2" {
  
  # The allocation ID of the Elastic IP address for the gateway
  # Allocate public ip for nat gateway
  allocation_id = aws_eip.nat2

  # place the gatway in subnet
  subnet_id = aws_subnet.public_2-us-east-2b.id

  # A map of tags to assign to the resource
  tags = {
    Name = "NAT 2"
  }

}