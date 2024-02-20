# HAVE CI SETUP ALREADY IN PLACE 
# SOURCE CODE FOR THIS EXERCISE IS IN THE VPROFILE REPO, BRANCH: cicd-kube 
- KOP SERVER t2.micro
- JENKINS SERVER t2.small, t2.micro will be very slow
- SONARQUBE SERVER t2.medium
using setup-guide: "https://medium.com/@fawazcp/continuous-integration-ci-with-jenkins-844d1ef7d82a"
and userdata from this git url of your code.
git url: 'https://github.com/GodfredAsa/vprofile-project/blob/ci-jenkins/userdata/sonar-setup.sh'

# KOPS SET UP

# TOKEN GENERATION FORM SONARQUBE APP default: {username: admin, password: admin}
# My Account => Security. Enter preferred name and Generate 
# d8412c334c49b05298f8c668c0cab94992631b07
# CONFIGURING THE ACCOUNT TOKEN AT JENKINS 
# JENKINS APP: Manage Jenkins => Configure System

# SECURITY GROUP FOR JENKINS AND SONAR SERVER AMENDMENT 
- ADD SG of Jenkins-server to sonarqube-server and that of sonarqube also to Jenkins-server using All-Traffic

# STORING DOCKER HUB LOGIN CREDENTIALS IN JENKINS 
# MANAGE JENKINS => MANAGE CREDENTIALS => Stores scoped to Jenkins => Global credentials (unrestricted) => Add Credentials 
{
    username: dockerhubAccountName,
    password: lockerhubAccountPassword,
    # id => useSameAsInJenkinsFile | registryCredentials, which is a variable => dcokerhub
    id:  dockerhub,
    description: dockerhub
}

# Install Docker Engine in the Jenkins Server  url: https://docs.docker.com/engine/install/ubuntu/
# NB: we installed docker in jenkins-server bcos will run docker commands from jenkins 
# Login as jenkins user => </> su -jenkins if prompted for password set password using the ffing command 
sudo passwd jenkins
# add jenkins user to docker group 
sudo usermod -aG docker jenkins 
# after this login as jenkins user and you should be able to run docker commands 
# if after this have issues with the jenkins app accessing and running docker commands then restart or reboot the jenkins server.

reboot

# PLUGING, K8s CLUSTER AND HELM
# PLUGINS TO INSTALL @ jenkins-server
# MANAGE JENKINS => PLUGINS => AVAILABLE PLUGINS 
- DOCKER "[ Docker, Docker Pipeline ]"
- PIPELINE UTILITY STEPS : thats Jenkins Pipeline as a Code [PaaC]

# LOGING INTO KOPS EC2 INSTANCE 
- create s3 bucket: vprofile-cicd-state
- route53 hosted zones: follow name format as stated in earlier lessons 
- add NS to the records at GoDaddy
- create cluster 

# INSTALL HELM IN KOPS AMI
- WHEN LEARNING THIS LESSON THERE WERE NO PLUGGINS 
- HOWEVER THIS IS NOT NECESSARY AS WE COULD ADD THE KOPS EC2 INSTANCE AS A SLAVE TO JENKINS THEN RUN HELM COMMANDS 
- FROM THE KOPS AMI ITSELF. THEREFORE NOT REALLY IN NEED OF THE PLUGGIN BUT NEED TO INSTALL HELM IN THE KOPS EC2


# NB: HELM IS A PACKAGING SYSTEM FOR DEFINITION FILES AND ALSO DEPLOYMENT TO K8 CLUSTER
# AS WE CAN RUN THE DEFINITION FILES ALL ON THE K8s CLUSTER INSTEAD OF MANAGING THEM SEPARATELY 
# HELM CHARTS ARE THE COLLECTION OF K8 DEFINITION FILES 

- INSTALLING HELM
 1. Download the helm installable tar|binary file and copy its link address for installation 
 2. In the VM|AMI run the linux command for installing it.
 3. cd into tmp/
 4. </> Downloading command: wget https://get.helm.sh/helm-v3.14.1-linux-amd64.tar.gz
 5. Extracting command: tar xzvf helm-v3.14.1-linux-amd64.tar.gz 
    # linux-amd64/
    # linux-amd64/README.md
    # linux-amd64/helm
    # linux-amd64/LICENSE
 6. cd linux-amd64/
 7. move the helm into with same name helm: </> sudo mv helm usr/local/bin/helm
# It can be accessible at anywhere.

# HELM CHARTS AND GIT REPO SETUP 
- create a git repo name: cicd-kube-docker
- clone the empty git repo created above 
- clone the source code repository or project 
- cd source code repository
- switch to the branch vp-docker SOURCE_CODE_REPO | PROJECT_REPO
- copy all content recursively into the empty repo created cicd-kube-docker
# </source> cp -r * ../cicd-kube-docker  || https://github.com/GodfredAsa/cicd-kube-docker
- check it that copied content is there 
- cd cicd-kube-docker  ==> CONFIGURATION REPO
- DELETE THE FOLLOWING FILES AND DIR AS WE DONT NEED THEM
# Docker-db  Docker-web compose ansible
- move Dockerfile in the Docker-app/ to main or current dir 
# </> mv Docker-app/Dockerfile .
- remove Docker-app/ as you have removed the Dockerfile from it 
- remove the helm dir as we would create our own 
- cd cicd-kube-docker/ , create helm dir & cd helm
- </> run => " helm create vprofilecharts " => this name bcos its also used in our Jenkinsfile 
# results or output ==> Chart.yaml  charts  templates  values.yaml
- cd templates,
- ls in templates 
# results or output ==> NOTES.txt  _helpers.tpl  deployment.yaml  hpa.yaml  ingress.yaml  service.yaml  serviceaccount.yaml  tests
- remove all files in templates </> rm -rf *
- cd cicd-kube-docker/
- cp kubernetes/vpro-app/* helm/vprofilecharts/templates/
- cd helm/vprofilecharts/templates/
# NOTE: The Docker image we are going to build and deploy regularly is the vproappdep.yml
#  View content in vproappdep.yaml in this main directory
- cd cicd-kube-docker/

# CREATING HELM CHARTS 
# CREATING A NAMESPACE FOR TESTING 
-  </> kubectl create namespace test

# content of cicd-repo before creating namespace.
# Dockerfile  README.md  helm  kubernetes  pom.xml  src

- run the command below 
- Syntax : helm install --namespace CREATED_NAME_SPACE PREFERRED_APP_NAME PATH_TO_HELM_CHARTS/ --set --VARIABLE_SPECIFIED_IN_DEPLOYMENT_DEFINITION_FILE:DOCKER_IMG:TAG
# I USED HIS BCOS WAS PUBLIC AND ALSO FOR LEARNING PURPOSES 
√ helm install --namespace NAMESPACE_NAME vprofile-stack helm/vprofilecharts/ -f helm/vprofilecharts/values.yaml --set appimage=DOCKERHUB_USERNAME/DOCKERHUB_IMAGE_NAME

# EXAMPLE:  helm install --namespace test vprofile-stack helm/vprofilecharts/ -f helm/vprofilecharts/values.yaml --set appimage=degreatasaa/vprofile-app

# </> helm install --namespace test vprofile-stack helm/vprofilecharts/ --set  --appimage=imranvisuapath/vproappdock:9

# list all namespace in test 
- kubectl get all --namespace test
# ==============================================================
# NAME                            READY   STATUS    RESTARTS   AGE
# pod/vproapp-79985d86cf-2qh6h    1/1     Running   0          116m
# pod/vprodb-7d6fb8944d-nmn64     1/1     Running   0          116m
# pod/vpromc-66c7f7d974-r4wrj     1/1     Running   0          116m
# pod/vpromq01-74cf848b65-pgj5k   1/1     Running   0          116m

# NAME                      TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)        AGE
# service/vproapp-service   LoadBalancer   100.64.84.112    a9821d70cd1154f06a6350f187cf3704-1175755029.us-east-1.elb.amazonaws.com   80:30405/TCP   116m
# service/vprocache01       ClusterIP      100.69.216.231   <none>                                                                    11211/TCP      116m
# service/vprodb            ClusterIP      100.65.157.144   <none>                                                                    3306/TCP       116m
# service/vpromq01          ClusterIP      100.66.144.160   <none>                                                                    5672/TCP       116m

# NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
# deployment.apps/vproapp    1/1     1            1           116m
# deployment.apps/vprodb     1/1     1            1           116m
# deployment.apps/vpromc     1/1     1            1           116m
# deployment.apps/vpromq01   1/1     1            1           116m

# NAME                                  DESIRED   CURRENT   READY   AGE
# replicaset.apps/vproapp-79985d86cf    1         1         1       116m
# replicaset.apps/vprodb-7d6fb8944d     1         1         1       116m
# replicaset.apps/vpromc-66c7f7d974     1         1         1       116m
# replicaset.apps/vpromq01-74cf848b65   1         1         1       116m

# ===============================================================
- helm list --namespace test
- kubectl get all --namespace test 
- helm delete PREFERRED_APP_NAME --namespace NAME_SPACE_NAME

# CREATING A PROD NAMESPACE 
 </> kubectl create namespace prod
# Dockerfile  README.md  helm  kubernetes  pom.xml  src
- push all changes made in to git, "helm charts"


# <<<<<======== WRITING PIPELINES  =====>>>>>>>
- create Jenkinsfile and run from kops for jenkins
- Open INTELLIJ new project from SOURCE CONTROL, CLONE https://github.com/GodfredAsa/cicd-kube-docker

- in the vprofile-project, branch paac: copy the Jenkinsfile and make the necessary changes 
- Since we are not uploading artifacts to nexus deleted its stage and variables.
-  added 2 new variables 
registry = dockerHub_username/chosenAppName
registryCredential = dockerhub, which is the dockerhub credential created name which in my case was docker

# <<<<============== FOLLOW THE JENKINSFILE CREATE READ IMMENSELY FOR UNDERSTANDING ============>>>>>>>>
# // ADDING KOPS EC2 INSTANCE AS A SLAVE TO JENKINS
# LOGIN TO KOPS EC2 INSTANCE 
# CREATE DIR AT HOME where the cicd-kube-docker-repo is and the SOURCE_CODE as ==> jenkins-slave 
- mkdir jenkins-slave 
# INSTALL OPEN-JDK. We need JDK so we can add KOPs VM as a Slave to Jenkins Master
- sudo apt install openjdk-8-jdk -y
- ALSO CREATE THE DIR "jenkins-slave" JUST ABOVE ALSO IN THE "opt/" dir 
- GIVE OWNERSHIP TO UBUNTU USER FROM JENKINS TO ACCESS THIS SLAVE 
</> sudo chown ubuntu.ubuntu /opt/jenkins-slave -R
# Will ssh to login to this KOPs Instance from JENKINS using the Ubuntu user 
- java -version # check java installed 
# BEFORE ADDING THE KOPS AS SLAVE, UPDATE KOPS Security Group => KOPS SG BY ADDING JENKINS SG, SSH
- SSH Jenkins SG
# NOW ADDING KOPS AS A SLAVE TO JENKINS
# JENKINS APP BROWSER 
# MANAGE JENKINS => NODES => NEW NODE
- name: kops , type : Permanent Agent
- label KOPS 
- remote root directory(directory created with ubuntu ownership): /opt/jenkins-slave
- usage: Only Build jobs
- Launch method: Launch agents via SSH
- Host(private IP of the Slave, KOPS): 172.31.88.228
- credentials: CLICK ADD THEN CLICK JENKINS
 * KIND: SSH Username With Private Key 
 * username(username given /opt/jenkins-slave ownership): ubuntu
 * id and description: kops-login
 * private enter directly: copy the kops login key here (thats the kops dot pem key which is the slave )
 * Add
 * Credentials: ubuntu(kops-login)
- Host Key Verification Strateg: Non Verifying Verfication Strategy 
 * Save 

#  Error faced 
# " Error: A JNI error has occurred, please check your installation and try again
# Exception in thread "main" java.lang.UnsupportedClassVersionError: hudson/remoting/Launcher has been compiled by a more recent version of the Java Runtime (class file version 55.0), this version of the Java Runtime only recognizes class file versions up to 52.0
# 	at java.lang.ClassLoader.defineClass1(Native Method)
# 	at java.lang.ClassLoader.defineClass(ClassLoader.java:756)
# 	at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:142)
# 	at java.net.URLClassLoader.defineClass(URLClassLoader.java:473)
# 	at java.net.URLClassLoader.access$100(URLClassLoader.java:74)
# 	at java.net.URLClassLoader$1.run(URLClassLoader.java:369)
# 	at java.net.URLClassLoader$1.run(URLClassLoader.java:363)
# 	at java.security.AccessController.doPrivileged(Native Method)
# 	at java.net.URLClassLoader.findClass(URLClassLoader.java:362)
# 	at java.lang.ClassLoader.loadClass(ClassLoader.java:418)
# 	at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:352)
# 	at java.lang.ClassLoader.loadClass(ClassLoader.java:351)
# 	at sun.launcher.LauncherHelper.checkAndLoadMain(LauncherHelper.java:621)
# Agent JVM has terminated. Exit code=1

# which means that I was using java version 8 while the app was compiled using java 11 

# SOLUTION 
- sudo apt update
- sudo apt install openjdk-11-jdk
- java -version
- RELAUNCH NODE AT JENKINS UI 

# environment tool name for sonnar was "mysonarscanner4" adding it to GLOBAL TOOL CONFIGURATION 
# IN THE JENKINS UI. 
# ADDING THE TOOL WITH THE SAME NAME "mysonarscanner4"
- MANAGE JENKINS => GLOBAL TOOL CONFIGURATION 
- CLICK ==> SonarQube Scanner installations
 * name: mysonarscanner4
 * SAVE

#  EXECUTION, TROUBLESHOOTING AND SUMMARIZING
#  CREATING A NEW JOB IN JENKINS
 - DASHBOARD => NEW ITEM
  * name: kube-cicd 
  * select pipeline
  * OK 
  * Pipeline Definition: Pipeline script from SCM 
  * SCM: Git
  * Repository: https://github.com/GodfredAsa/cicd-kube-docker.git
  * branch: main 
  * Save and Build Now 

#   ATTACHING QUALITY GATES 

# ThERE WAS AN ISSUE RELATING TO SONARQUBE REPONSE AS JENKINS WAS AWAITING THE RESPONSE OF QUALITY GATE WITH THE MESSAGE 
# "CHECKING STATUS OF SONARQUBE TASK 'RANDOM_ALPHA_NUMERIC' ON SERVER SONAR_NAME"
# DUE TO THIS WE NEED TO SETUP A WEBHOOK 

# Project Setting => WebHook
- create
    - name: jenkins-webhook
    - url: http://PRIVATE_IP_JENKINS_EC2:8080/sonarqube-webhook/
    - seret: no entry made 

- click on the project => project settings => Quality Gate
- set appropriate quality gates for it 

#  WHEN ALL IS DONE AND WORKS 
# VALIDATING 
- login to KOPS EC2 instance
- list the name space => helm list --namespace prod
- kubectl get pods --namespace prod

- kubectl describe pod podName --namespace prod # check the result to see the image with the tag on it 
- kubectl get svc --namespace prod # Gives the loadBalancer External-IP for accessing the app on the browser

# NOTE CONFIGURING A BUILD TRIGGER
- at pipeline of the project => configure 
- Under Build Triggers 
    - tick POll SCM
    - Schedule: ***** # thats for a every minute 
    - Save




