# provider "aws" {
#   access_key = "AKIA6OZCLERHTR5ZWRDJ"
#   secret_key = "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"
#   region     = "ap-southeast-1"
# }

# // create vpc
# resource "aws_vpc" "first-vpc" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "Production"
#   }
# }

# // create internet gateway
# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.first-vpc.id
# }


# // create route table
# resource "aws_route_table" "route-table-coba" {
#   vpc_id = aws_vpc.first-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   route {
#     ipv6_cidr_block = "::/0"
#     gateway_id      = aws_internet_gateway.gw.id
#   }

# }


# // create subnet
# resource "aws_subnet" "subnet-1" {
#   vpc_id            = aws_vpc.first-vpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "ap-southeast-1a"

#   tags = {
#     Name = "coba-subnet"
#   }
# }

# // create route table association
# resource "aws_route_table_association" "route-a" {
#   subnet_id      = aws_subnet.subnet-1.id
#   route_table_id = aws_route_table.route-table-coba.id
# }

# // create aws security group
# resource "aws_security_group" "allow_web" {
#   name        = "allow_web"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.first-vpc.id

#   ingress {
#     description = "HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_web"
#   }
# }

# // create network interface
# resource "aws_network_interface" "web-server" {
#   subnet_id       = aws_subnet.subnet-1.id
#   private_ips     = ["10.0.1.50"]
#   security_groups = [aws_security_group.allow_web.id]

# }

# // create eip
# resource "aws_eip" "one" {
#   vpc                       = true
#   network_interface         = aws_network_interface.web-server.id
#   associate_with_private_ip = "10.0.1.50"
#   depends_on                = [aws_internet_gateway.gw]
# }

# // create instance
# resource "aws_instance" "web-server-instance" {
#   ami               = "ami-055d15d9cfddf7bd3"
#   instance_type     = "t2.micro"
#   availability_zone = "ap-southeast-1a"
#   key_name          = "new-keypair"

#   network_interface {
#     device_index         = 0
#     network_interface_id = aws_network_interface.web-server.id
#   }

#   user_data = <<-EOF
#                  #!/bin/bash
#                  sudo apt update -y
#                  sudo apt install apache2 -y
#                  sudo systemctl start apache2
#                  sudo bash -c 'echo your very first web server > /var/www/html/index.html'
#                 EOF
#   tags = {
#     Name = "web-server"
#   }
# }