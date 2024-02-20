# PROVISIONER CONNECTION
# to do provisioning need to give connection details 
# Example of provisioning a file from source to a destination in the VM using ssh on linux and windows
# LINUX MACHINE 
SSH
provisioner "file" {
source = "files/test.conf"
destination = "/etc/test.conf"
connection {
type = "ssh"
user = "root"
password = "var.root_password"
    }
}


# Windows machinne
WinRM
provisioner "file" {
source = "conf/myapp.conf"
destination = "C:/App/myapp.conf"
connection {
type = "winrm"
user = "Administrator"
password = "var.admin_password"
    }
}

More Provisioner
- The file provisioner is used to copy files or directories
- remote-exec invokes a command/script on remote resource.
- local-exec provisioner invokes a local executable after a resource is created
- The puppet provisioner installs, configures and runs the Puppet agent on a remote resource.
    - Supports both ssh and winrm type connections.
- The chef provisioner installs, configures and runs the Chef Client on a remote resource.
    - Supports both ssh and winrm type connections.
- Ansible: run terraform, Output IP address, run playbook with local-exec

# We are going to generate keys locally and push public keys to our aws cloud account using variables 
variable "PRIV_KEY_PATH" {
default = "infi-inst_key"
｝

variable "PUB_KEY_PATH" {
default = "infi-inst_key.pub"
｝

variable "USER" {
default = "ubuntu"
｝

# Key Pair & instance Resources
# Accessing a resource from another resource 
    # creating the key pair 
resource "aws_key_pair" "dove-key" {
key_name = "dovekey"
# file fxn that reads a file 
public_key = file("dovekey.pub")
｝

resource "aws_instance" "intro"{
ami = var.AMIS[var.REGION]
instance_type = "t2.micro"
availability_zone = var.ZONE1
    # referring to the created key pair 
key_name = aws_key_pair.dove-key.key_name
vpc_security_group_ids = ["sg-833e24fd"]
｝


# One more resource definition of pushing a file 
# FILE PROVISIONER 
provisioner "file" {
source = "web.sh"
destination = "/tmp/web.sh"
｝

connection {
user = "var.USER"
private_key = file(var.PRIV_KEY_PATH)
host = self.public_ip
｝

# EXECUTING THE FILE REMOTELY USING 
# Remote-exec Provisioner
provisioner "remote-exec" {
Inline = [
"chmod u+x /tmp/web.sh",
"sudo /tmp/web.sh"
]

｝


# STEPS IN EXECUTING PROVISIONING EXERCISE
- Create key pair 
- Write script
- Write providers.tf file 
- Write vars.tf file for mentioning or declaring all variables
- Write instances.tf file 
    - key pair resource 
    - aws_instance resource 
        - provisioners
            - file 
            - remote_exec 
- apply changes 

# SOLUTION OR STRATEGY 
- in the file dir </> ssh-keygen
- Enter file in which to save the key (/Users/macintosh/.ssh/id_rsa): giveFileName
- this generates a public key and private key 

- Provisioned our instance with the shell script web.sh file.

# NOTE: This exercise is not ONLY about Launching an instance but also provisioning it with our shell script

