FROM limingyao/hadoop2.7:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/spark && cd /opt/spark \
&& wget http://192.168.188.157:15973/soft/spark-2.2.3-bin-hadoop2.7.tgz \
&& tar zxvf spark-2.2.3-bin-hadoop2.7.tgz && rm spark-2.2.3-bin-hadoop2.7.tgz \
&& mv spark-2.2.3-bin-hadoop2.7 spark-2.2.3 \
&& chown -R work.work /opt/spark/spark-* \
&& cd /opt/spark/spark-*/conf \
&& cp spark-env.sh.template spark-env.sh \
&& cp spark-defaults.conf.template spark-defaults.conf \
&& cp slaves.template slaves \
&& echo "SPARK_MASTER_HOST=spark" >> spark-env.sh \
&& echo "spark.master spark://spark:7077" >> spark-defaults.conf \
&& sed -i 's/localhost/spark/g' slaves

ADD ./soft/spark.sh /etc/profile.d/

RUN mkdir -p /data/spark && chown -R work.work /data/spark \
&& chown work.work /etc/profile.d/spark.sh

EXPOSE 7077

