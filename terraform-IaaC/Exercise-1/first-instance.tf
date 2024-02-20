provider "aws" {
  region = "us-east-1"
  # secret_key= ""
  # access_key = ""
}

resource "aws_instance" "intro" {
  ami                    = "ami-0cf10cdf9fcd62d37"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = "terraform-key"
  vpc_security_group_ids = ["sg-02f067d836b30fa24"]
  tags = {
    Name    = "Terraform-Instance"
    Project = "Fighters"
  }
}