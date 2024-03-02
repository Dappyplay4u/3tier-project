resource "aws_vpc" "boss-vpc" {
  cidr_block       = var.boss-vpc-cidr
  instance_tenancy = "default"

  tags = {
    Name = "boss-vpc"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "boss-available-zones" {}


resource "aws_subnet" "boss-publicsubnet1" {
  vpc_id     = aws_vpc.boss-vpc.id
  cidr_block = var.boss-publicsubnet1-cidr
  availability_zone = data.aws_availability_zones.boss-available-zones.names[0]
  tags = {
    Name = "boss-public-subnet1"
  }
}
resource "aws_subnet" "boss-publicsubnet2" {
  vpc_id     = aws_vpc.boss-vpc.id
  cidr_block = var.boss-publicsubnet2-cidr
  availability_zone = data.aws_availability_zones.boss-available-zones.names[1]
  tags = {
    Name = "boss-public-subnet2"
  }
}
resource "aws_subnet" "boss-privatesubnet1" {
  vpc_id     = aws_vpc.boss-vpc.id
  cidr_block = var.boss-privatesubnet1-cidr
  availability_zone = data.aws_availability_zones.boss-available-zones.names[0]
  tags = {
    Name = "boss-private-subnet1"
  }
}
resource "aws_subnet" "boss-privatesubnet2" {
  vpc_id     = aws_vpc.boss-vpc.id
  cidr_block = var.boss-privatesubnet2-cidr
  availability_zone = data.aws_availability_zones.boss-available-zones.names[1]
  tags = {
    Name = "boss-private-subnet2"
  }
}
resource "aws_subnet" "boss-privatesubnet3" {
  vpc_id     = aws_vpc.boss-vpc.id
  cidr_block = var.boss-privatesubnet3-cidr
  availability_zone = data.aws_availability_zones.boss-available-zones.names[0]
  tags = {
    Name = "boss-private-subnet3"
  }
}
resource "aws_subnet" "boss-privatesubnet4" {
  vpc_id     = aws_vpc.boss-vpc.id
  cidr_block = var.boss-privatesubnet4-cidr
  availability_zone = data.aws_availability_zones.boss-available-zones.names[1]
  tags = {
    Name = "boss-private-subnet4"
  }
}

resource "aws_internet_gateway" "boss-internet-gw" {
  vpc_id = aws_vpc.boss-vpc.id

  tags = {
    Name = "boss-igw"
  }
}

#INTERNET GATEWAY ROUTE TABLE
resource "aws_route_table" "boss-internet-gw" {
  vpc_id = aws_vpc.boss-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.boss-internet-gw.id
  }
  tags = {
    Name = "boss-Internetgtway-routetable"
  }
}
#ROUTE TABLE ATTACHMENT
resource "aws_route_table_association" "boss-publicsubnet1" {
  subnet_id      = aws_subnet.boss-publicsubnet1.id
  route_table_id = aws_route_table.boss-internet-gw.id
}
resource "aws_route_table_association" "boss-publicsubnet2" {
  subnet_id      = aws_subnet.boss-publicsubnet2.id
  route_table_id = aws_route_table.boss-internet-gw.id
}