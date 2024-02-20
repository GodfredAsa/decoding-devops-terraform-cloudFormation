# SETUP K8s CLUSTER FOR KOPS

1. Domain for K8s DNS records 
 - eg. groophy.in from GoDaddy
2. Create Linux VM and setup
 - Vagrant VM or EC2
 - VM will be used to setup | install the following 
 - kops, kubectl, ssh keys & awscli 
3. Login AWS Account and setup the following 
 - s3 bucket, IAM User for AWSCli, Route53 Hosted Zones (Subdomains)
 - Domain on GoDaddy subdomain on Amazon Route53
# CREATING S3 BUCKET
- s3 bucket will be used to maintain the kops state 
- this enables us to run our kops from anywhere as long us 
- its pointed to our s3 bucket
- name: vprofile-kops-state-100 ==> create

# CREATING IAM USER 
- Give it Administrative access

# CREATTING HOSTED ZONES AT AWS ROUTE53
- name: kubevpro.GODADDY_DOMAIN_NAME = kubevpro.decodingdevops.co.uk
- decodingdevops.co.uk is the GoDaddy domain name
- at AWS Route53 add the Value/Route traffic to, the records at GoDaddy 
# NB: There are 4 records and use the NS records not the SOA record which is a single one 
# format  type: NS, Host: route53: Name, kubepro, points to: Value/ Route Traffic to
# type: NS, name: kubepro, points to: ns-1320.awsdns-37.org.

# LOGIN TO EC2 INSTANCE AND SETUP 
ssh -i kops-key ubuntu@Public_IP

- generate ssh key, public key will be pushed to all instances 
ssh-keygen 

# update and install awscli, in not root user start with sudo 
- sudo apt-get update
- sudo apt install awscli
# configure awscli, adding access key and secret key 
- aws coinfigure
# add the access key and secret key, default region(pick it from the url where keys where generated at aws ): us-east-1
# output format -> json

# INSTALL KUBECTL AND KOBS 
# INSTALLING KUTBECTL
 - kubectl binary
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# after that </> ls to see the kubectl binary 
# Give Executable permission
chmod +x kubectl
# Move to user/local/bin to it can be executed anywhere.
sudo mv kubectl /usr/local/bin/

kubectl version --client

# INSTALLING KOPS 
# binary, ls to see after installation
curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
# executable permission
chmod +x kops
# move to bin with the name kops
sudo mv kops /usr/local/bin/kops
# version 
kops version

# verifying domain
# nslookup -type=ns ROUTE53_NAME.HOSTED_DOMAIN
nslookup -type=ns kubevpro.decodingdevops.co.uk
# SHOWS THE 4 NAMED SERVERS VALUE/ROUTE TRAFFIC TO VALUES EG. BELOW
# kubevpro.decodingdevops.co.uk	nameserver = ns-1320.awsdns-37.org.
# kubevpro.decodingdevops.co.uk	nameserver = ns-1883.awsdns-43.co.uk.
# kubevpro.decodingdevops.co.uk	nameserver = ns-374.awsdns-46.com.
# kubevpro.decodingdevops.co.uk	nameserver = ns-742.awsdns-28.net.

# RUN KOPS COMMAND TO CREATE THE KUBERNETES CLUSTER 



