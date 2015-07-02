############################################################
# Dockerfile to install JDK & TOMCAT on ORACLE LINUX
#
# 0_1           Maheswara Reddy M          06APRIL2015
#
#
############################################################

FROM oraclelinux
MAINTAINER Maheswara Reddy<mreddy2@directv.com>

# INSTALL ORACLELINUX
RUN yum -y upgrade
RUN yum -y install initscripts
RUN yum -y install openssl
RUN yum install -y wget
RUN yum install -y tar

ENV CATALINA_HOME /applications/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_VERSION 8.0
ENV TOMCAT_TGZ_URL http://mirror.apache-kr.org/tomcat/tomcat-$TOMCAT_MAJOR_VERSION/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

# INSTALL JAVA BEGIN

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.rpm && \
    echo "c55acf3c04e149c0b91f57758f6b63ce  jdk-8u31-linux-x64.rpm" >> MD5SUM && \
    md5sum -c MD5SUM && \
    rpm -Uvh jdk-8u31-linux-x64.rpm && \
    yum -y remove wget && \
    rm -f jdk-8u31-linux-x64.rpm MD5SUM

# INSTALL JAVA END

# INSTALL TOMCAT
RUN wget -q $TOMCAT_TGZ_URL
RUN tar xvf apache-tomcat-$TOMCAT_VERSION.tar.gz
RUN mv apache-tomcat-$TOMCAT_VERSION tomcat
RUN rm -rf apache-tomcat-$TOMCAT_VERSION.tar.gz
RUN mkdir /applications
WORKDIR /applications

EXPOSE 8080
ENTRYPOINT ["sh","/applications/startup.sh"]
