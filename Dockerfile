FROM centos:centos7
MAINTAINER Maheswara Reddy

RUN yum -y install wget && \
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.rpm && \
    echo "c55acf3c04e149c0b91f57758f6b63ce  jdk-8u31-linux-x64.rpm" >> MD5SUM && \
    md5sum -c MD5SUM && \
    rpm -Uvh jdk-8u31-linux-x64.rpm && \
    yum -y remove wget && \
    rm -f jdk-8u31-linux-x64.rpm MD5SUM
