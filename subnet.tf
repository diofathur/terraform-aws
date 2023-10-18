resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet[0]
  availability_zone = var.az[0]
  tags = {
    Name = "public-subnet-nojorono"
  }
}


resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet[1]
  availability_zone = var.az[0]
  tags = {
    Name = "private-subnet-nojorono"
  }
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet[2]
  availability_zone = var.az[1]
  tags = {
    Name = "public-subnet-nojorono-2"
  }
}
