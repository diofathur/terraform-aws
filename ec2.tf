resource "aws_instance" "pritunl" {
  ami                         = "ami-0dea4c77aa6baff5a"
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.role-profile.name
  vpc_security_group_ids      = [aws_security_group.pritunl.id]

  root_block_device {
    delete_on_termination = true
    iops                  = 3000
    volume_size           = 50
    volume_type           = "gp3"
    encrypted             = true
  }

  disable_api_termination = true
  tags = {
    Name = "pritunl-vpn"
  }
}

resource "aws_eip" "eip_pritunl" {
  instance = aws_instance.pritunl.id
}

resource "aws_instance" "financial" {
  ami                         = "ami-0f53ee06f31d4ae4e"
  instance_type               = "c5.xlarge"
  subnet_id                   = aws_subnet.private.id
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.role-profile.name
  vpc_security_group_ids      = [aws_security_group.financial.id]
  key_name = "nojorono"

  root_block_device {
    delete_on_termination = true
    iops                  = 3000
    volume_size           = 50
    volume_type           = "gp3"
    encrypted             = true
  }

  
  disable_api_termination = true
  tags = {
    Name = "financial report server"
  }
}
