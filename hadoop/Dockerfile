FROM limingyao/centos7-jdk8-base:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/hadoop && cd /opt/hadoop \
&& wget http://192.168.188.146:15973/soft/hadoop-2.7.5.tar.gz \
&& tar zxvf hadoop-2.7.5.tar.gz \
&& chown -R work.work /opt/hadoop/hadoop-* \
&& rm hadoop-2.7.5.tar.gz

RUN mv /opt/hadoop/hadoop-2.7.5/etc/hadoop/core-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/core-site.xml.bak \
&& mv /opt/hadoop/hadoop-2.7.5/etc/hadoop/hdfs-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/hdfs-site.xml.bak \
&& mv /opt/hadoop/hadoop-2.7.5/etc/hadoop/yarn-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/yarn-site.xml.bak \
&& chmod -x /opt/hadoop/hadoop-*/bin/*.cmd && chmod -x /opt/hadoop/hadoop-*/sbin/*.cmd

ADD ./soft/conf/core-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/hdfs-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/mapred-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/yarn-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/hadoop.sh /etc/profile.d/

RUN mkdir -p /data/hadoop && chown -R work.work /data/hadoop \
&& chown work.work /etc/profile.d/hadoop.sh \
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/core-site.xml \
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/hdfs-site.xml \
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/mapred-site.xml \
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/yarn-site.xml

EXPOSE 8020 8042 8088 19888 50070

