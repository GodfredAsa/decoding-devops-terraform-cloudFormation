--name = route53Name.hostingDomain
kops create cluster --name=kubevpro.decodingdevops.co.uk --state=s3://s3_bucketName --zones=us-east-1a,us-east-1b --node-count=2 --node-size=t3.small --master-size=t3.medium --dns-zone=kubevpro.decodingdevops.co.uk --node-volume-size=8 --master-volume-size=8



# CREATING A CLUSTER COMMAND AFTER INSTALLING KUBECTL AND KOPS  
# NB: The </> does not create the cluster, creates the configuration and store in s3 bucket
# Each time you write the kops command, specify the bucket or wont work 
kops create cluster --name=kubevpro.decodingdevops.co.uk \
> --state=s3://viprofile-kops-state --zones=us-east-1a,us-east-1b \
> --node-count=2 --node-size=t3.small --master-size=t3.medium --dns-zone=kubevpro.decodingdevops.co.uk \
> --node-volume-size=8 --master-volume-size=8


kops update cluster --name=kubevpro.decodingdevops.co.uk --state=s3://s3_bucketName --yes --admin

# wait for about 15min below validating the cluster 
kops validate cluster kubevpro.decodingdevops.co.uk --state=s3://s3_bucketName

# creating volume and copy the volume id for re-use later ensure that you use the same availability zone as during the creating of the cluster.
aws ec2 create-volume --availability-zone=us-east-1a --size=3 --volume-type=gp2

 # shows the existing labels which we can use.
kubectl get nodes --show-labels

# creating our own labels 1. Get the node name 
# </> kubectl get nodes 
# </> kubectl describe node NODE_NAME | grep us-east-2 [REGION] , gives a description of the zone of the node and other infos
# Labelling a node ZONE_NAME can be gotten from the definition file.
# label all the non-master nodes, the master node is the control-plane
kubectl label nodes NODE_NAME zone=ZONE_NAME

# GITHUB REPO FOR THE DEFINITION FILES ==> https://github.com/GodfredAsa/kube-app

kops delete cluster --name=kubevpro.decodingdevops.co.uk --state=s3://s3_bucketName --yes 
# after deleting 
sudo poweroff

# When you want it back on 
sudo poweron 



# DEPLOYMENT TO KUBERNEWTES CLUSTER 
# THIS WILL BE DEALING WITH THE CONTAINERIZATION DONE AT DOCKER 
# WHICH WAS VPROFILE PROJECT 

# WILL USE THE FOLLOWING VPROFILE IMAGES 
# 1. vprofile-app
# 2. vprofile-db
# 3. vprofile web: we will spung ELB (Elastic Load Balancer) automatically instead of that.

# Unauthorised when running kubectl commands 
# error: You must be logged in to the server (Unauthorized)
# kops export kubeconfig --admin --state=s3://s3_bucketName
