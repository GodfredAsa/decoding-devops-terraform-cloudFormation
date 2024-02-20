# WITH THIS LESSON OF EXERCISE WE WILL LAUNCH AN EC2 INSTANCE USING TERRAFORM SCRIPT

# REQUIREMENTS

- AWS Account
- IAM User with Access Keys 
- Terraform file to launch instance 
- Run terraform apply
# terraform files ends with .tf

# EXERCISE
- write instance.tf file
- Launch instance 
- Make some changes to instance.tf file 
- apply changes 

# Need to set Authentication
- you can define aws access key and secret key 
- thats we are going to use aws access key and secret key of an IAM User to access aws services 
- but the problem is we have to define them in terraform file, unsafe   

# SAFE APPROACH 
* install awscli and set your access key and secret key 
* create an IAM User and generate access key and secret key with Administrative Access, ff the command 
* setting access and secret key  </> aws configure 

# EXERCISE 1 
- creating ec2 instance first-instance.tf
- Download AWS Pluginsm be in the file dir </> terraform init 
- ls -a # shows .terraform dir 
- validate terraform syntax </> terraform validate 
- reformat your terraform file </> terraform fmt 
- Showing what will happen|execute if applied </> terraform plan
- applying the configuration </> terraform apply
- destroy the instance </> terraform destroy