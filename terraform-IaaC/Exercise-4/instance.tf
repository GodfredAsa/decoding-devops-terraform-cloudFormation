#  Instance Details
# creating key 

resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file("dovekey.pub")
}

# instance resource 
resource "aws_instance" "dove-instance" {
  ami               = var.AMIS[var.REGION]
  instance_type     = "t2.micro"
  availability_zone = var.ZONE1
  # key_name = "dovekey"
  # access key_name from other instance instead of typing it in syntax = resource.resourceName.attributeName
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = ["sg-02f067d836b30fa24"]

  tags = {
    Name    = "Dove-Instance"
    Project = "Dove"
  }

  # provisioning instance with shell scripy web.sh
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  # connection Details
  connection {
    user        = var.USER
    private_key = file("dovekey")
    host        = self.public_ip
  }
}


output "PublicIP" {
  value = aws_instance.dove-instance.public_ip
}

output "PrivateIP" {
  value = aws_instance.dove-instance.private_ip
}