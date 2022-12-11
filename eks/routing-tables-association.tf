
resource "aws_route_table_association" "public_1_rta" {
  
#  The ID of subnet, which will apply the route
  subnet_id = aws_subnet.public_1-us-east-2a.id

# public route table id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "public_2_rta" {
  
#  The ID of subnet, which will apply the route
  subnet_id = aws_subnet.public_2-us-east-2b.id

# public route table id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_1_rta" {
  
#  The ID of subnet, which will apply the route
  subnet_id = aws_subnet.private_1-us-east-2a.id

# public route table id
  route_table_id = aws_route_table.private_1_rt.id
}

resource "aws_route_table_association" "private_2_rta" {
  
#  The ID of subnet, which will apply the route
  subnet_id = aws_subnet.private_2-us-east-2b.id
# public route table id
  route_table_id = aws_route_table.private_2_rt.id
}