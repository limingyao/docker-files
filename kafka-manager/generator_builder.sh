#!/bin/bash

if [ ! -f "./soft/kafka-manager-1.3.3.14.zip" ]; then
    echo "./soft/kafka-manager-1.3.3.14.zip not exist"
    echo "please see README.md"
    exit 1
fi

port=15973
ip=$(ifconfig -a | grep inet | grep broadcast | awk '{print $2}')
nohup python -m SimpleHTTPServer $port &
pid=$(ps -ef | grep SimpleHTTPServer | grep -v grep | awk '{print $2}')
echo "ip: "$ip
echo "pid: "$pid


cat > Dockerfile <<EOF
FROM limingyao/centos7-jdk8-base:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/kafka-manager && cd /opt/kafka-manager \\
&& wget http://$ip:$port/soft/kafka-manager-1.3.3.14.zip \\
&& unzip /opt/kafka-manager/kafka-manager-*.zip -d /opt/kafka-manager \\
&& chown -R work.work /opt/kafka-manager/kafka-manager-* \\
&& rm kafka-manager-*.zip \\
&& sed -i 's/kafka-manager.zkhosts=".*/kafka-manager.zkhosts="zk:2181"/g' /opt/kafka-manager/kafka-manager-*/conf/application.conf

ADD ./soft/kafka-manager.conf /etc/supervisord.d/work/

RUN mkdir -p /data/kafka-manager && chown -R work.work /data/kafka-manager \\
&& chown work.work /etc/supervisord.d/work/kafka-manager.conf

EXPOSE 9901

EOF

# docker build --no-cache -t limingyao/kafka-manager:latest .
docker build -t limingyao/kafka-manager:latest .

kill -9 $pid
rm nohup.out
