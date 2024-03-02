resource "aws_eip" "boss-eip-for-nat-gateway-1" {
  vpc    = true

  tags   = {
    Name = "boss-EIP 1"
  }
}

resource "aws_nat_gateway" "boss-natgateway" {
  allocation_id = aws_eip.boss-eip-for-nat-gateway-1.id
  subnet_id     = aws_subnet.boss-publicsubnet1.id

  tags = {
    Name = "boss-gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.boss-internet-gw]
}

# Create Private Route Table 1 and Add Route Through Nat Gateway 1
# terraform aws create route table
resource "aws_route_table" "boss-private-route-table-1" {
  vpc_id            = aws_vpc.boss-vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.boss-natgateway.id
  }

  tags   = {
    Name = "boss-Private Route Table 1"
  }
}

# Associate Private Subnet 1 with "Private Route Table 1"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "boss-privatesubnet1-route-table-association" {
  subnet_id         = aws_subnet.boss-privatesubnet1.id
  route_table_id    = aws_route_table.boss-private-route-table-1.id
}


# Allocate Elastic IP Address (EIP 2)
# terraform aws allocate elastic ip
resource "aws_eip" "boss-eip-for-nat-gateway-2" {
  vpc    = true

  tags   = {
    Name = "boss-EIP 2"
  }
}
# Create Nat Gateway 2 in Public Subnet 2
# terraform create aws nat gateway
resource "aws_nat_gateway" "boss-nat-gateway-2" {
  allocation_id = aws_eip.boss-eip-for-nat-gateway-2.id
  subnet_id     = aws_subnet.boss-publicsubnet2.id

  tags   = {
    Name = "boss-Nat Gateway Public Subnet 2"
  }
}
# Create Private Route Table 2 and Add Route Through Nat Gateway 2
# terraform aws create route table
resource "aws_route_table" "boss-private-route-table-2" {
  vpc_id            = aws_vpc.boss-vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.boss-nat-gateway-2.id
  }

  tags   = {
    Name = "boss-Private Route Table 2"
  }
}

# Associate Private Subnet 2 with "Private Route Table 2"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "boss-privatesubnet2-route-table-association" {
  subnet_id         = aws_subnet.boss-privatesubnet2.id
  route_table_id    = aws_route_table.boss-private-route-table-1.id
}
