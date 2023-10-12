# create public subnet 
resource "aws_subnet" "public" {
  # Attach or Declare vpc
  vpc_id = aws_vpc.main.id
  # add ip CIDR for subnet
  cidr_block = var.subnet[0]
  # Choose availability Zone
  availability_zone = var.az[0]
  tags = {
    Name = "public-subnet-nojorono"
  }
}

# Create Private Subnet
resource "aws_subnet" "private" {
  # Attach or declare vpc 
  vpc_id = aws_vpc.main.id
  # add ip CIDR for subnet
  cidr_block = var.subnet[1]
  # Choose availability Zone
  availability_zone = var.az[0]
  tags = {
    Name = "private-subnet-nojorono"
  }
}
