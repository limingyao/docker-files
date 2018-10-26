FROM limingyao/centos7-base:latest
MAINTAINER mingyaoli@tencent.com

RUN yum -y -q install git && yum clean all

RUN mkdir -p /opt/go && cd /opt/go \
&& wget http://192.168.188.146:15973/soft/go1.10.4.linux-amd64.tar.gz \
&& tar zxvf go1.10.4.linux-amd64.tar.gz \
&& chown -R root.root ./go \
&& rm go1.10.4.linux-amd64.tar.gz \
&& mv go go1.10.4

RUN mkdir -p /opt/protobuf && cd /opt/protobuf \
&& wget http://192.168.188.146:15973/soft/protobuf-3.6.1.tar.gz \
&& tar zxvf protobuf-3.6.1.tar.gz \
&& chown -R root.root ./protobuf-3.6.1 \
&& rm protobuf-3.6.1.tar.gz

ADD ./soft/go.sh /etc/profile.d/
ADD ./soft/protoc.sh /etc/profile.d/

