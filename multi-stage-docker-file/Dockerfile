# BUILDING THE ARTIFACT
FROM openjdk:8 AS BUILD_IMAGE
RUN apt-get update && apt-get install maven -y
RUN git clone -b vp-docker git@github.com:GodfredAsa/vprofile-project.git
RUN cd vprofile-project && mvn install

# COPY ARTIFACT FROM IMAGE ABOVE TO THIS IMAGE. THIS IS THE BUILD IMAGE
FROM tomcat:8-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD [ "catalina.sh", "run" ]