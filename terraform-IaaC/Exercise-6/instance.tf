# #  Instance Details
# # creating key 

# resource "aws_key_pair" "dove-key" {
#   key_name   = "dovekey"
#   public_key = file(var.PUB_KEY)
# }

# # instance resource 
# resource "aws_instance" "dove-web" {
#   ami               = var.AMIS[var.REGION]
#   instance_type     = "t2.micro"
#   subnet_id = aws_subnet.dove-pub-1. id

#   availability_zone = var.ZONE1
#   # key_name = "dovekey"
#   # access key_name from other instance instead of typing it in syntax = resource.resourceName.attributeName
#   key_name               = aws_key_pair.dove-key.key_name
#   vpc_security_group_ids = [aws_security_group.dove_stack_sg.id]

#   tags = {
#     Name    = "my-dove-Dove"
#     Project = "Dove"
#   }

#   resource "aws_ebs_volume" "vol_4_dove"{
#     availability_zone = var.ZONE1
#     stage = 3
#     tags = {
#         Name = "extra-vol-4-dove"
#     }
#   }

#   resource "aws_volume_attanchment" "attach_vol_dove"{
#     device_name = "/dev/xvdh"
#     volume_id = aws_ebs_volume.vol_4_dove.id
#     availability_zone = var.ZONE1
#     instance_id = aws_instance.dove-web.id
#   }

# #   # provisioning instance with shell scripy web.sh
# #   provisioner "file" {
# #     source      = "web.sh"
# #     destination = "/tmp/web.sh"
# #   }

# #   provisioner "remote-exec" {
# #     inline = [
# #       "chmod +x /tmp/web.sh",
# #       "sudo /tmp/web.sh"
# #     ]
# #   }

# #   # connection Details
# #   connection {
# #     user        = var.USER
# #     private_key = file("dovekey")
# #     host        = self.public_ip
# #   }
# }


# output "PublicIP" {
#   value = aws_instance.dove-instance.public_ip
# }

# # output "PrivateIP" {
# #   value = aws_instance.dove-instance.private_ip
# # }



resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "dove-web" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.dove-pub-1.id
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = [aws_security_group.dove_stack_sg.id]
  tags = {
    Name = "my-dove"
  }
}

# resource "aws_ebs_volume" "vol_4_dove" {
#   availability_zone = var.ZONE1
#   size              = 3
#   tags = {
#     Name = "extr-vol-4-dove"
#   }
# }

# resource "aws_volume_attachment" "attach_vol_dove" {
#   device_name = "/dev/xvdh"
#   volume_id   = aws_ebs_volume.vol_4_dove.id
#   instance_id = aws_instance.dove-web.id
# }

output "PublicIP" {
  value = aws_instance.dove-web.public_ip
}
