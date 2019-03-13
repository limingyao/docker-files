#!/bin/bash

if [ ! -f "./soft/hadoop-2.7.5.tar.gz" ]; then
    echo "./soft/hadoop-2.7.5.tar.gz not exist"
    echo "please download hadoop-2.7.5.tar.gz from https://www.apache.org/dyn/closer.cgi/hadoop/"
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

RUN mkdir -p /opt/hadoop && cd /opt/hadoop \\
&& wget http://$ip:$port/soft/hadoop-2.7.5.tar.gz \\
&& tar zxvf hadoop-2.7.5.tar.gz \\
&& chown -R work.work /opt/hadoop/hadoop-* \\
&& rm hadoop-2.7.5.tar.gz

RUN mv /opt/hadoop/hadoop-2.7.5/etc/hadoop/core-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/core-site.xml.bak \\
&& mv /opt/hadoop/hadoop-2.7.5/etc/hadoop/hdfs-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/hdfs-site.xml.bak \\
&& mv /opt/hadoop/hadoop-2.7.5/etc/hadoop/yarn-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/yarn-site.xml.bak \\
&& chmod -x /opt/hadoop/hadoop-*/bin/*.cmd && chmod -x /opt/hadoop/hadoop-*/sbin/*.cmd

ADD ./soft/conf/core-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/hdfs-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/mapred-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/yarn-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/hadoop.sh /etc/profile.d/

RUN mkdir -p /data/hadoop && chown -R work.work /data/hadoop \\
&& chown work.work /etc/profile.d/hadoop.sh \\
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/core-site.xml \\
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/hdfs-site.xml \\
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/mapred-site.xml \\
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/yarn-site.xml

EXPOSE 8020 8042 8088 19888 50070

EOF

# docker build --no-cache -t limingyao/hadoop2.7:latest .
docker build -t limingyao/hadoop2.7:latest .

kill -9 $pid
rm nohup.out