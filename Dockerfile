FROM tomcat:8.5
MAINTAINER Somesh
COPY //var/lib/docker/tmp/docker-builder669318673/maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war
