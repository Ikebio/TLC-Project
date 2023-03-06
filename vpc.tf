resource "aws_vpc" "main" {
  cidr_block            = var.vpc_cidr_block
  instance_tenancy      = "default"
  enable_dns_support    = "true"
  enable_dns_hostnames  = "true"

  tags = {
    Name = var.vpc_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Test-igw"
  }
}

# Public Subnet
resource "aws_subnet" "pub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block =  var.pub_sub1_cidr_block
  map_public_ip_on_launch = "true"
  availability_zone = "eu-west-2a"

  tags = {
    Name = var.pub_sub1_name
  }
}

resource "aws_subnet" "pub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pub_sub2_cidr_block
  map_public_ip_on_launch = "true"
  availability_zone = "eu-west-2a"

  tags = {
    Name = var.pub_sub2_name
  }
}


# Public Rout Table
resource "aws_route_table" "feb-pub" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.pub_rout_name
  }
}

# Public Rout Association Subnet
resource "aws_route_table_association" "pub1" {
  subnet_id      = aws_subnet.pub1.id
  route_table_id = aws_route_table.feb-pub.id
}

resource "aws_route_table_association" "pub2" {
  subnet_id      = aws_subnet.pub2.id 
  route_table_id = aws_route_table.feb-pub.id
}

# Private subnet 
resource "aws_subnet" "priv1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.priv_sub1_cidr_block
  map_public_ip_on_launch = "false"
  availability_zone = "eu-west-2b"

  tags = {
    Name = var.priv_sub1_name
  }
}

resource "aws_subnet" "priv2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.priv_sub2_cidr_block
  map_public_ip_on_launch = "false"
  availability_zone = "eu-west-2b"

  tags = {
    Name = var.priv_sub2_name
  }
}