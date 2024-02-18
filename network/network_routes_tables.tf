resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  # No need to specify Local Target as that is done implicitly to enable traffic among the instances in VPC. 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    name = "public_route_table"
  }
}

resource "aws_route_table_association" "public_route_table_association_A" {
  subnet_id      = aws_subnet.publicA.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_B" {
  subnet_id      = aws_subnet.publicB.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_C" {
  subnet_id      = aws_subnet.publicC.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private route tables. 
# One for each private AZ.  
# Private subnets in each AZ share the route table. 
resource "aws_route_table" "private_route_tableA" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" # Route all the data to NAT gateway
    nat_gateway_id = aws_nat_gateway.nat_gatewayA.id
  }
  tags = {
    name = "private_route_tableA"
  }
}

resource "aws_route_table" "private_route_tableB" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" # Route all the data to NAT gateway
    nat_gateway_id = aws_nat_gateway.nat_gatewayB.id
  }
  tags = {
    name = "private_route_tableB"
  }
}

resource "aws_route_table" "private_route_tableC" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" # Route all the data to NAT gateway
    nat_gateway_id = aws_nat_gateway.nat_gatewayC.id
  }
  tags = {
    name = "private_route_tableC"
  }
}

# Private route table associations for first AZ
resource "aws_route_table_association" "private_route_table_appA_association" {
  subnet_id      = aws_subnet.appA.id
  route_table_id = aws_route_table.private_route_tableA.id
}

resource "aws_route_table_association" "private_route_table_dbA_association" {
  subnet_id      = aws_subnet.dbA.id
  route_table_id = aws_route_table.private_route_tableA.id
}

# Private route table associations for second AZ
resource "aws_route_table_association" "private_route_table_appB_association" {
  subnet_id      = aws_subnet.appB.id
  route_table_id = aws_route_table.private_route_tableB.id
}

resource "aws_route_table_association" "private_route_table_dbB_association" {
  subnet_id      = aws_subnet.dbB.id
  route_table_id = aws_route_table.private_route_tableB.id
}

# Private route table associations for third AZ
resource "aws_route_table_association" "private_route_table_appC_association" {
  subnet_id      = aws_subnet.appC.id
  route_table_id = aws_route_table.private_route_tableC.id
}

resource "aws_route_table_association" "private_route_table_dbC_association" {
  subnet_id      = aws_subnet.dbC.id
  route_table_id = aws_route_table.private_route_tableC.id
}