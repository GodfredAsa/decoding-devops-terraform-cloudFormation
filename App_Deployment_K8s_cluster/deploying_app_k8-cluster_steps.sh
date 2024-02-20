# containerize the project or apps
# create a cluster 
# wait for some minutes approximately 15mins
# validate the cluster
# create a volume, command in the cluster setup file process
# copy the volumeId to be used [ "VolumeId": "vol-06b55f9408c4b5cbd",]
# so you can store mysql data in the DBS volume
# label the non-master nodes 
# the containerize image will be using is vprofile-app and vprofile-db from docker 
# we will not use vprofile-web of the nginx image but rather ELB [ Elastic Load Balancer ] automatically instead of that.
# create a repository for writing service [POD] definition files and clone to the AMI
# you write your definition files in an IDE and push and clone into the AMI
# In the service definition files encode your password using the syntax below 
echo -n "password" | base64
# this deployment repo url: https://github.com/GodfredAsa/kube-app

# service files created
- app-secret.yaml
# cd into the kube-app dir
# create secret by running app-secret.yaml => secret definition fileName.yaml
kubectl create -f app-secret.yaml
kubectl get secrets
kubectl describe secret

# creating vprodbdep.yaml [vprodbdeployment.yaml], create a tag so K8s can connect to it 
# @ AWS console, select volume ID under the volumes beneath ElasticBlockStore click tag and add descriptive tag. Otherwise you will get permission denied error. 
# syntax [Key] KubernetesCluster [value] whole url with that of the domain in my case it was Eg value: KubeCluster, [value] = kubevpro.decodingdevops.co.uk, which the exact name when creating the cluster. 

kubectl create -f vprodbdep.yaml
kubectl get pod
# get information about the pod
kubectl describe pod podName
# log information about the pod 
kubectl logs podName


# db cluster ip definition yaml file for internal traffic 

# to execute all the definition files 
kubectl create -f .

# NOTE: above command displays error if the pod or deployment has already been done 
# to avoid you can use apply instead of the create BUT the already exists its not really an error.

# shows all the services running 
kubectl get svc

# NAME              TYPE           CLUSTER-IP       EXTERNAL-IP                                                             PORT(S)        AGE
# kubernetes        ClusterIP      100.64.0.1       <none>                                                                  443/TCP        17h
# vproapp-service   LoadBalancer   100.69.162.120   a2c9c29fc30804a79bc9d4aa6da4b57f-50006058.us-east-1.elb.amazonaws.com   80:32288/TCP   85m
# vprocached01      ClusterIP      100.69.110.249   <none>                                                                  11211/TCP      88m
# vprodb            ClusterIP      100.69.120.192   <none>                                                                  3306/TCP       88m
# vpromq01          ClusterIP      100.66.172.47    <none>

# running the external-IP in a browser


# Last Lesson 
# url for website and wrap up 
# you can add it to GoDaddy or Route53
# HOSTED ZONE
 - create a record 
 - simple routing 
 - subdomain Eg blog
 - Value/Traffic to =>  Alias and Application Classic LoadBalancer
 - region: choose the regions used Eg us-east-1
 - type: AWS Resources ipv4

#  NOTE NOTE NOTE FRED 
# REDO THIS EXERCISE USING HIS IMAGES AND DEFINITIONN FILES 


# CLEANUP PROCESSES 
# Unauthorised when running kubectl commands 
# error: You must be logged in to the server (Unauthorized)
# kops export kubeconfig --admin --state=s3://s3_bucketName

- DELETE THE APPLICATION
kubectl delete -f .

- delete cluster 

