# VPC
resource "aws_vpc" "cloudnative" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "cloudnative-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cloudnative.id

  tags = {
    Name = "cloudnative-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.cloudnative.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "cloudnative-public-rt"
  }
}

# Public Subnet A (AZa)
resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.cloudnative.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloudnative-public-subnet-a"
  }
}

# Public Subnet B (AZb)
resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.cloudnative.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloudnative-public-subnet-b"
  }
}

# Associate Subnet A with Public Route Table
resource "aws_route_table_association" "public_assoc_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate Subnet B with Public Route Table
resource "aws_route_table_association" "public_assoc_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}
