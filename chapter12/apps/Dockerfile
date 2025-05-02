
FROM --platform=linux/amd64 ubuntu:latest
RUN apt update -y
RUN apt -y install curl
RUN apt -y install default-jdk
RUN apt -y install lynx
WORKDIR /tmp
RUN curl -O https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.8/bin/apache-tomcat-10.1.8.tar.gz
RUN tar xzvf apache-tomcat-10*tar.gz
RUN mv apache-tomcat-10*/  tomcat/
RUN mkdir /opt/tomcat/
RUN mv tomcat/ /opt/
COPY index.html /opt/tomcat/webapps/ROOT
WORKDIR /opt/tomcat/
EXPOSE 8080
RUN chmod +x /opt/tomcat/bin/catalina.sh
CMD ["/opt/tomcat/bin/catalina.sh", "run"]