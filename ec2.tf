resource "aws_security_group" "public" {
  name   = "public ssh"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "public ssh"
  }
}

resource "aws_security_group" "private" {
  name   = "private ssh"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.11.0.0/16"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "private ssh"
  }
}

resource "aws_instance" "jumphost" {
  ami                         = "ami-0666798135ce10443"
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  key_name                    = "dio3"

  vpc_security_group_ids = [aws_security_group.public.id]

  root_block_device {
    delete_on_termination = true
    iops                  = 150
    volume_size           = 50
    volume_type           = "gp3"
  }
  disable_api_termination = true
  tags = {
    Name = "jumphost"
  }
}

resource "aws_instance" "app" {
  ami                         = "ami-0666798135ce10443"
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.staging.id
  associate_public_ip_address = false
  key_name                    = "dio3"

  vpc_security_group_ids = [aws_security_group.private.id]

  root_block_device {
    delete_on_termination = true
    iops                  = 150
    volume_size           = 50
    volume_type           = "gp3"
  }

  disable_api_termination = true
  tags = {
    Name = "app-webserver"
  }
}