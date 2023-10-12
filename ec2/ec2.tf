resource "aws_instance" "pritunl" {
  ami                         = "ami-0913922d1289852b6"
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.role-profile.name
  vpc_security_group_ids      = [aws_security_group.pritunl.id]

  root_block_device {
    delete_on_termination = true
    iops                  = 150
    volume_size           = 50
    volume_type           = "gp3"
    encrypted             = true
    kms_key_id            = ""
  }
  user_data = data.template_file.startup.rendered

  disable_api_termination = true
  tags = {
    Name = "pritunl-vpn"
  }
}