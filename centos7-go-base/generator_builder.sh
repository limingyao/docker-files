#!/bin/bash

if [ ! -f "./soft/go1.10.4.linux-amd64.tar.gz" ]; then
    echo "./soft/go1.10.4.linux-amd64.tar.gz not exist"
    echo "please see README.md to download go1.10.4.linux-amd64.tar.gz"
    exit 1
fi

port=15973
ip=$(ifconfig -a | grep inet | grep broadcast | awk '{print $2}')
nohup python -m SimpleHTTPServer $port &
pid=$(ps -ef | grep SimpleHTTPServer | grep -v grep | awk '{print $2}')
echo "ip: "$ip
echo "pid: "$pid


cat > Dockerfile <<EOF
FROM limingyao/centos7-base:latest
MAINTAINER mingyaoli@tencent.com

RUN yum -y -q install git && yum clean all

RUN mkdir -p /opt/go
ADD ./soft/go1.10.4.linux-amd64.tar.gz /opt/go/

RUN mkdir -p /opt/protobuf/ && cd /opt/protobuf/ \\
&& wget http://$ip:$port/soft/protobuf-3.6.1.tar.gz \\
&& tar zxvf protobuf-3.6.1.tar.gz \\
&& chown -R root.root ./protobuf-3.6.1 \\
&& rm protobuf-3.6.1.tar.gz

ADD ./soft/go.sh /etc/profile.d/
ADD ./soft/protoc.sh /etc/profile.d/

EOF


# docker build --no-cache -t limingyao/centos7-jdk8-base:latest .
docker build -t limingyao/centos7-go-base:latest .

kill -9 $pid
rm nohup.out
