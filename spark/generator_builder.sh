#!/bin/bash

if [ ! -f "./soft/spark-2.2.3-bin-hadoop2.7.tgz" ]; then
    echo "./soft/spark-2.2.3-bin-hadoop2.7.tgz not exist"
    echo "please download spark-2.2.3-bin-hadoop2.7.tgz from https://mirrors.tuna.tsinghua.edu.cn/apache/spark"
    exit 1
fi

port=15973
ip=$(ifconfig -a | grep inet | grep broadcast | awk '{print $2}')
nohup python -m SimpleHTTPServer $port &
pid=$(ps -ef | grep SimpleHTTPServer | grep -v grep | awk '{print $2}')
echo "ip: "$ip
echo "pid: "$pid


cat > Dockerfile <<EOF
FROM limingyao/hadoop2.7:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/spark && cd /opt/spark \\
&& wget http://$ip:$port/soft/spark-2.2.3-bin-hadoop2.7.tgz \\
&& tar zxvf spark-2.2.3-bin-hadoop2.7.tgz && rm spark-2.2.3-bin-hadoop2.7.tgz \\
&& mv spark-2.2.3-bin-hadoop2.7 spark-2.2.3 \\
&& chown -R work.work /opt/spark/spark-* \\
&& rm /opt/spark/spark-2.2.3/jars/slf4j-* \\
&& cd /opt/spark/spark-*/conf \\
&& cp spark-env.sh.template spark-env.sh \\
&& cp spark-defaults.conf.template spark-defaults.conf \\
&& cp slaves.template slaves \\
&& echo "SPARK_MASTER_HOST=spark" >> spark-env.sh \\
&& echo "spark.master spark://spark:7077" >> spark-defaults.conf \\
&& sed -i 's/localhost/spark/g' slaves

ADD ./soft/spark.sh /etc/profile.d/

RUN mkdir -p /data/spark && chown -R work.work /data/spark \\
&& chown work.work /etc/profile.d/spark.sh

EXPOSE 4040 6066 7077 8080 8081 18080

EOF

# docker build --no-cache -t limingyao/spark2.2:latest .
docker build -t limingyao/spark2.2:latest .

kill -9 $pid
rm nohup.out
