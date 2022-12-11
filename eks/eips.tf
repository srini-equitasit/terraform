# 1st 
resource "aws_eip" "nat1" {
    # EIP may require IGW to exist prior to association
    # use depends_on to set an explicitly dependecy on the IGW
  depends_on = [
    aws_internet_gateway.main
  ]
}

# 2nd 
resource "aws_eip" "nat2" {
    # EIP may require IGW to exist prior to association
    # use depends_on to set an explicitly dependecy on the IGW
  depends_on = [
    aws_internet_gateway.main
  ]
}