FROM limingyao/centos7-jdk8-base:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/hbase && cd /opt/hbase \
&& wget http://192.168.188.146:15973/soft/hbase-1.3.1-bin.tar.gz \
&& tar zxvf hbase-1.3.1-bin.tar.gz \
&& chown -R work.work /opt/hbase/hbase-* \
&& rm hbase-1.3.1-bin.tar.gz

RUN mv /opt/hbase/hbase-1.3.1/conf/hbase-site.xml /opt/hbase/hbase-1.3.1/conf/hbase-site.xml.bak \
&& sed -i 's/# export HBASE_MANAGES_ZK=true/export HBASE_MANAGES_ZK=false/g' /opt/hbase/hbase-1.3.1/conf/hbase-env.sh

ADD ./soft/conf/hbase-site.xml /opt/hbase/hbase-1.3.1/conf/
ADD ./soft/hbase.sh /etc/profile.d/

RUN mkdir -p /data/hbase && chown -R work.work /data/hbase \
&& chown work.work /etc/profile.d/hbase.sh \
&& chown work.work /opt/hbase/hbase-*/conf/hbase-site.xml

EXPOSE 3181 8080 8085 9090 9095 16000 16010 16201 16301

