// create vpc
resource "aws_vpc" "main" {
  cidr_block = var.cidr # var.cidr it's mean to called variable from file vars.tf
  tags = {
    Name = "summarecon-vpc"
  }
}