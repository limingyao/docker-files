#!/bin/bash

if [ ! -f "./soft/etcd-v3.3.12-linux-amd64.tar.gz" ]; then
    echo "./soft/etcd-v3.3.12-linux-amd64.tar.gz not exist"
    echo "please download etcd-v3.3.12-linux-amd64.tar.gz from https://github.com/etcd-io/etcd/releases/download/v3.3.12/etcd-v3.3.12-linux-amd64.tar.gz"
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

RUN mkdir -p /opt/etcd && cd /opt/etcd \\
&& wget http://$ip:$port/soft/etcd-v3.3.12-linux-amd64.tar.gz \\
&& tar zxvf etcd-v3.3.12-linux-amd64.tar.gz \\
&& mv etcd-v3.3.12-linux-amd64 etcd-v3.3.12 \\
&& chown -R work.work /opt/etcd/etcd-* \\
&& rm etcd-v3.3.12-linux-amd64.tar.gz

ADD ./soft/conf-0.yml /opt/etcd/etcd-v3.3.12/
ADD ./soft/conf-1.yml /opt/etcd/etcd-v3.3.12/
ADD ./soft/conf-2.yml /opt/etcd/etcd-v3.3.12/
ADD ./soft/etcd.conf /etc/supervisord.d/work/
ADD ./soft/etcd.sh /etc/profile.d/

RUN mkdir -p /data/etcd && chown -R work.work /data/etcd \\
&& chown work.work /etc/supervisord.d/work/etcd.conf \\
&& chown work.work /etc/profile.d/etcd.sh \\
&& chown work.work /opt/etcd/etcd-v3.3.12/conf-*.yml


EXPOSE 2379 2389 2399

EOF

# docker build --no-cache -t limingyao/etcd3.3:latest .
docker build -t limingyao/etcd3.3:latest .

kill -9 $pid
rm nohup.out
