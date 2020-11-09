resource "aws_internet_gateway" "MyIGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MyIGW"
  }
}

resource "aws_route_table" "MyPublicRoute" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyIGW.id
  }

  tags = {
    Name = "MyPublicRoute"
  }
}

resource "aws_route_table_association" "publicSubnetA" {
  subnet_id      = aws_subnet.publicA.id
  route_table_id = aws_route_table.MyPublicRoute.id
}

resource "aws_route_table_association" "publicSubnetB" {
  subnet_id      = aws_subnet.publicB.id
  route_table_id = aws_route_table.MyPublicRoute.id
}

resource "aws_route_table_association" "publicSubnetC" {
  subnet_id      = aws_subnet.publicC.id
  route_table_id = aws_route_table.MyPublicRoute.id
}

resource "aws_eip" "natEipA" {
  vpc                       = true
}

resource "aws_eip" "natEipB" {
  vpc                       = true
}

resource "aws_eip" "natEipC" {
  vpc                       = true
}

resource "aws_nat_gateway" "natA" {
  subnet_id      = aws_subnet.publicA.id
  allocation_id = aws_eip.natEipA.id
  
  tags = {
    Name = "natA"
  }
}

resource "aws_nat_gateway" "natB" {
  subnet_id      = aws_subnet.publicB.id
  allocation_id = aws_eip.natEipB.id
  
  tags = {
    Name = "natB"
  }
}

resource "aws_nat_gateway" "natC" {
  subnet_id      = aws_subnet.publicC.id
  allocation_id = aws_eip.natEipC.id
  
  tags = {
    Name = "natC"
  }
}

resource "aws_route_table" "PrivateRouteA" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natA.id
  }

  tags = {
    Name = "PrivateRouteA"
  }
}

resource "aws_route_table" "PrivateRouteB" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natB.id
  }

  tags = {
    Name = "PrivateRouteB"
  }
}

resource "aws_route_table" "PrivateRouteC" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natC.id
  }

  tags = {
    Name = "PrivateRouteC"
  }
}

resource "aws_route_table_association" "privateAppA" {
  subnet_id      = aws_subnet.appA.id
  route_table_id = aws_route_table.PrivateRouteA.id
}

resource "aws_route_table_association" "privateDbA" {
  subnet_id      = aws_subnet.dbA.id
  route_table_id = aws_route_table.PrivateRouteA.id
}

resource "aws_route_table_association" "privateAppB" {
  subnet_id      = aws_subnet.appB.id
  route_table_id = aws_route_table.PrivateRouteB.id
}

resource "aws_route_table_association" "privateDbB" {
  subnet_id      = aws_subnet.dbB.id
  route_table_id = aws_route_table.PrivateRouteB.id
}

resource "aws_route_table_association" "privateAppC" {
  subnet_id      = aws_subnet.appC.id
  route_table_id = aws_route_table.PrivateRouteC.id
}

resource "aws_route_table_association" "privateDbC" {
  subnet_id      = aws_subnet.dbC.id
  route_table_id = aws_route_table.PrivateRouteC.id
}
