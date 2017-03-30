FROM tomcat:8.5-alpine

COPY swmsg.war /usr/local/tomcat/webapps/swmsg.war
COPY swmsg.xml /usr/local/tomcat/conf/Catalina/localhost/swmsg.xml
