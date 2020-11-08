FROM tomcat:8.5
MAINTAINER Somesh
COPY maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war
