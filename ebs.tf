resource "aws_ebs_volume" "ebs1" {
  availability_zone = var.az[0]
  size = 300
  type = "gp3"
  tags = {
    Name = "extra storage financial"
  }
  encrypted = true
}

resource "aws_volume_attachment" "ebs1-attach" {
  device_name = "/dev/sdb"
  volume_id = aws_ebs_volume.ebs1.id
  instance_id = aws_instance.financial.id
}