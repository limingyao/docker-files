FROM limingyao/centos7-jdk8-base:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/kafka-manager && cd /opt/kafka-manager \
&& wget http://192.168.188.146:15973/soft/kafka-manager-1.3.3.14.zip \
&& unzip /opt/kafka-manager/kafka-manager-*.zip -d /opt/kafka-manager \
&& chown -R work.work /opt/kafka-manager/kafka-manager-* \
&& rm kafka-manager-*.zip \
&& sed -i 's/kafka-manager.zkhosts=".*/kafka-manager.zkhosts="zk:2181"/g' /opt/kafka-manager/kafka-manager-*/conf/application.conf

ADD ./soft/kafka-manager.conf /etc/supervisord.d/work/

RUN mkdir -p /data/kafka-manager && chown -R work.work /data/kafka-manager \
&& chown work.work /etc/supervisord.d/work/kafka-manager.conf

EXPOSE 9901

