# SETS UBUNTU VM AND INSTALLS DOCKER ON IT 
# THIS IS A VAGRANT SETUP 
# YOU CAN USE AWS AMI 
vagrant init ubuntu/bionic64

# add network address by uncommenting the network session and choose your IP

# run the Varagnt image
vagrant up
# login to VM
vagrant ssh

# INSTALLING DOCKER ON THE VM
sudo apt-get update 
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# ADD DOCKER STABLE REPOSITORY
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
# INSTALL LATEST VERSION OF DOCKER ENGINE 
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
# CHECK INSTALLED DOCKER VERSION 
docker --version

# MAKING THE VAGRANT USER RUN DOCKER COMMANDS 
sudo usermod -a -G docker vagrant
# exit and login again 
# verify user addition 
id  # gives the user details of of the current user 
# run docker commands and if not permission denied then it works 
