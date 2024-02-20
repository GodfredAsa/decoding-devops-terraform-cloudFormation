resource "aws_instance" "dove-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "terraform-key"
  vpc_security_group_ids = ["sg-02f067d836b30fa24"]
  tags = {
    Name    = "Terraform-Instance"
    Project = "Fighters"
  }
}