# THIS STEP FOLLOWS WHEN DONE WITH docker-setup.sh
# HENCE docker-setup.sh pre-requisites this 

# CREATE THE CUSTOMISE images repositories in your dockerhub and use them as the image name.
# db => vprofile-db

# STEPS
# 1 Fetch source code
# 2 write docker files to build 3 images 
# NGINX, TOMCAT & MYSQL 

# FETCHING THE SOURCE CODE FROM IT. INTO THE SAME DIR AS VAGRANT FILE FOR THIS SETUP.
# - create a dir in it named, < vprofile-project > ff

# NB: DOCKER FILES WRITTEN IN vprofile-project/vprofile-project/Docker-files

# SEARCH CRITERIA BUILDING A DOCKER IMAGE 


# AS WE NEED 3 IMAGES CREATE 3 REPOSITORIES IN DOCKER FOR THEM
# vprofile-app ==> tomcat image 
# pushing to the repository
# docker push degreatasaa/vprofile-app:tagname

# vprofile-web ==> nginx image 
# pushing to the repository
# docker push degreatasaa/vprofile-web:tagname

# vprofile-db ==> mysql image 
# pushing to the repository
# docker push degreatasaa/vprofile-db:tagname


# after building will push to dockerhub

# install jdk and maven when in the project folder with the pom.xml file, root directory 
sudo apt-get install openjdk-8-jdk -y && apt-get install maven -y 
# creates a target dir with the .war file in it 
# copy the target directory into the Dockerfile/app dir where Dockerfile for containerization present
# checking to the connect for the images when created in the application.properties.

# BUILDING THE IMAGES

# </> docker build -t accountName/imageName:tag Dockerfile_dir
# app image 
docker build -t degreatasaa/vprofile-app: .

# db image 
docker build -t degreatasaa/vprofile-db:V1 .

# web image with nginx
docker build -t degreatasaa/vprofile-web:V1 .


# We need to pull nginx, memcached and rabbitmq as we dont need to customise it we just pull and use it 
docker pull nginx

docker pull memcached
docker pull rabbitmq


# images built 
# REPOSITORY                 TAG       IMAGE ID       CREATED          SIZE
# degreatasaa/vprofile-web   V1        2cd3577761b0   36 minutes ago   187MB
# degreatasaa/vprofile-db    V1        7e2dcf8813e9   44 minutes ago   565MB
# degreatasaa/vprofile-app   latest    61fea0c040b3   50 minutes ago   325MB
# rabbitmq                   latest    393f6753e973   6 days ago       217MB
# memcached                  latest    e89b92b1e7ff   3 weeks ago      106MB
# nginx                      latest    b690f5f0a2d5   3 months ago     187MB

## SUCCESSFULLY CONTAINERISE THE APP BUT YOU NEED TO TEST AND VERIFY IT USING DOCKER COMPOSE 
# Will to configure it with all our containers but first we need to install docker compose

# docker compose binary
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# apply executable permission on the compose binary
sudo chmod +x /usr/local/bin/docker-compose
# check the compose version 
docker-compose --version

# WRITING DOCKER COMPOSE FILE

jdbc.driverClassName=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://vprodb:3306/accounts?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
jdbc.username=root
jdbc.password=vprodbpass

# MYSQL IMAGE DESC: image_name=vprodb, port: 3306, database: accounts, username: root and password: vprodbpass
# NB: This information is configured in the Dockerfile in the db folder except the image name as would be done at runtime.

# PUSHING IMAGES TO DOCKER HUB

# login to docker hub through console 
docker login

# docker push imageName:tag_if_any