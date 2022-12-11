resource "aws_route_table" "public_rt" {
  
  vpc_id = aws_vpc.main.id

    route  {
        #  the cidr block of route table
        cidr_block = "0.0.0.0/0"

        #identifier of a VPC internet gateway or a virtual private gateway
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
      Name = "public_rt"
    }
}

resource "aws_route_table" "private_1_rt" {
  
  vpc_id = aws_vpc.main.id

    route  {
        #  the cidr block of route table
        cidr_block = "0.0.0.0/0"

        #identifier of a VPC internet gateway or a virtual private gateway
        gateway_id = aws_nat_gateway.gw1.id
    }

    tags = {
      Name = "private_1_rt"
    }
}

resource "aws_route_table" "private_2_rt" {
  
  vpc_id = aws_vpc.main.id

    route  {
        #  the cidr block of route table
        cidr_block = "0.0.0.0/0"

        #identifier of a VPC internet gateway or a virtual private gateway
        gateway_id = aws_nat_gateway.gw2.id
    }

    tags = {
      Name = "private_2_rt"
    }
}