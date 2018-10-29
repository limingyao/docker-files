#!/bin/bash

if [ ! -f "./soft/zookeeper-3.4.10.tar.gz" ]; then
    echo "./soft/zookeeper-3.4.10.tar.gz not exist"
    echo "please download zookeeper-3.4.10.tar.gz from https://www.apache.org/dyn/closer.cgi/zookeeper/"
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

RUN mkdir -p /opt/zookeeper && cd /opt/zookeeper \\
&& wget http://$ip:$port/soft/zookeeper-3.4.10.tar.gz \\
&& tar zxvf zookeeper-3.4.10.tar.gz \\
&& chown -R work.work /opt/zookeeper/zookeeper-* \\
&& rm zookeeper-3.4.10.tar.gz

# for auth & config
RUN chmod -x /opt/zookeeper/zookeeper-*/bin/*.cmd && chmod -x /opt/zookeeper/zookeeper-*/bin/README.txt \\
&& sed -i 's/zookeeper.root.logger=.*/zookeeper.root.logger=INFO, CONSOLE, ROLLINGFILE/g' /opt/zookeeper/zookeeper-*/conf/log4j.properties \\
&& sed -i 's/log4j.appender.ROLLINGFILE=.*/log4j.appender.ROLLINGFILE=org.apache.log4j.DailyRollingFileAppender/g' /opt/zookeeper/zookeeper-*/conf/log4j.properties \\
&& sed -i 's/log4j.appender.ROLLINGFILE.MaxFileSize/#log4j.appender.ROLLINGFILE.MaxFileSize/g' /opt/zookeeper/zookeeper-*/conf/log4j.properties \\
&& sed -i 's#ZOO_LOG_DIR="."#ZOO_LOG_DIR=/data/zookeeper/logs#g' /opt/zookeeper/zookeeper-*/bin/zkEnv.sh \\
&& sed -i 's/ZOO_LOG4J_PROP=.*/ZOO_LOG4J_PROP="INFO, CONSOLE, ROLLINGFILE"/g' /opt/zookeeper/zookeeper-*/bin/zkEnv.sh

ADD ./soft/zoo.cfg /opt/zookeeper/zookeeper-3.4.10/conf/
ADD ./soft/zk.conf /etc/supervisord.d/work/
ADD ./soft/zk.sh /etc/profile.d/

RUN mkdir -p /data/zookeeper/logs && chown -R work.work /data/zookeeper \\
&& chown work.work /etc/supervisord.d/work/zk.conf \\
&& chown work.work /etc/profile.d/zk.sh \\
&& chown work.work /opt/zookeeper/zookeeper-3.4.10/conf/zoo.cfg

EXPOSE 2181

EOF

# docker build --no-cache -t limingyao/zookeeper3.4:latest .
docker build -t limingyao/zookeeper3.4:latest .

kill -9 $pid
rm nohup.out
