FROM tomcat:8.5
MAINTAINER Somesh
COPY /home/ubuntu/maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war
