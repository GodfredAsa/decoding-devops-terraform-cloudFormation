FROM tomcat:8-jre11
LABEL "Project"="Vprofile"
LABEL "Author"="Godfred"

# removes the default application webapps/
RUN rm -rf /usr/local/tomcat/webapps/*
# copy the build file into the webapp/ dir with the name ROOT.war
COPY target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
WORKDIR /usr/local/tomcat/
VOLUME /usr/local/tomcat/webapps