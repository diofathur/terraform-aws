// Create Route Table Public
resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.main.id

  route {
    # add Destination
    cidr_block = "0.0.0.0/0"
    # for the target 
    gateway_id = aws_internet_gateway.gateway_main.id
  }
  tags = {
    Name = "summarecon-rt-public"
  }
}
// Create Route Table Private
resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.main.id

  route {
    # add Destination
    cidr_block = "0.0.0.0/0"
    # for the target
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Summarecon-rt-private"
  }
}
// Create or add Route for Route table
resource "aws_route_table_association" "public-rt" {
  // Add subnet association
  subnet_id = aws_subnet.public.id
  // Add Routes
  route_table_id = aws_route_table.rt-public.id
}
// Create or add Route for Route table
resource "aws_route_table_association" "staging-rt" {
  // Add subnet association
  subnet_id = aws_subnet.staging.id
  // Add Routes
  route_table_id = aws_route_table.rt-private.id
}
// Create or add Route for Route table
resource "aws_route_table_association" "private-rt" {
  // Add subnet association
  subnet_id = aws_subnet.private.id
  // Add Routes
  route_table_id = aws_route_table.rt-private.id
}