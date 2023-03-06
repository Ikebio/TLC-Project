# Elastic IP Address for Nat
resource "aws_eip" "feb-eip" {
  vpc = true
  depends_on    = [aws_internet_gateway.gw]
}

# Nat Gateway
resource "aws_nat_gateway" "feb-nat" {
  allocation_id = aws_eip.feb-eip.id
  subnet_id     = aws_subnet.pub1.id

  tags = {
    Name = "Test-Nat-GW"
  }
}

  # Private Rout Table
resource "aws_route_table" "priv" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.feb-nat.id
  }

  tags = {
    Name = var.priv_rout_name
  }
}


# Priv Rout Association Subnet
resource "aws_route_table_association" "priv1" {
  subnet_id      = aws_subnet.priv1.id
  route_table_id = aws_route_table.priv.id
}

resource "aws_route_table_association" "priv2" {
  subnet_id      = aws_subnet.priv2.id
  route_table_id = aws_route_table.priv.id
}
