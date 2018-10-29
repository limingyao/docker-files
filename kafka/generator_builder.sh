#!/bin/bash

if [ ! -f "./soft/kafka_2.12-0.10.2.0.tgz" ]; then
    echo "./soft/kafka_2.12-0.10.2.0.tgz not exist"
    echo "please download kafka_2.12-0.10.2.0.tgz from https://archive.apache.org/dist/kafka/"
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

RUN mkdir -p /opt/kafka && cd /opt/kafka \\
&& wget http://$ip:$port/soft/kafka_2.12-0.10.2.0.tgz \\
&& tar zxvf kafka_2.12-0.10.2.0.tgz \\
&& chown -R work.work /opt/kafka/kafka_* \\
&& rm kafka_2.12-0.10.2.0.tgz

RUN sed -i 's/#delete.topic.enable=true/delete.topic.enable=true/g' /opt/kafka/kafka_*/config/server.properties \\
&& sed -i 's#log.dirs=.*#log.dirs=/data/kafka/data/logs#g' /opt/kafka/kafka_*/config/server.properties \\
&& sed -i 's#zookeeper.connect=.*#zookeeper.connect=zk:2181/kafka0.10.2.0#g' /opt/kafka/kafka_*/config/server.properties
# && sed -i 's#dataDir=.*#dataDir=/data/kafka/data/zookeeper#g' /opt/kafka/kafka_*/config/zookeeper.properties \\
# && sed -i 's/clientPort=.*/clientPort=4181/g' /opt/kafka/kafka_*/config/zookeeper.properties

# ADD ./soft/kafka-zk.conf /etc/supervisord.d/work/
ADD ./soft/kafka.conf /etc/supervisord.d/work/
ADD ./soft/kafka.sh /etc/profile.d/

RUN mkdir -p /data/kafka && chown -R work.work /data/kafka \\
&& chown work.work /etc/supervisord.d/work/kafka*.conf \\
&& chown work.work /etc/profile.d/kafka.sh

# EXPOSE 4181 9092
EXPOSE 9092

EOF

# docker build --no-cache -t limingyao/kafka_2.12-0.10.2.0:latest .
docker build -t limingyao/kafka_2.12-0.10.2.0:latest .

kill -9 $pid
rm nohup.out
