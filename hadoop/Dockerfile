FROM limingyao/centos7-jdk8-base:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/hadoop && cd /opt/hadoop \
&& wget http://192.168.1.202:15973/soft/hadoop-2.7.5.tar.gz \
&& tar zxvf hadoop-2.7.5.tar.gz \
&& chown -R work.work /opt/hadoop/hadoop-* \
&& rm hadoop-2.7.5.tar.gz

RUN mkdir -p /opt/tez && cd /opt/tez \
&& wget http://192.168.1.202:15973/soft/apache-tez-0.9.1-bin.tar.gz \
&& tar zxvf apache-tez-0.9.1-bin.tar.gz \
&& chown -R work.work /opt/tez/apache-tez-0.9.1-bin \
&& mv /opt/tez/apache-tez-0.9.1-bin /opt/tez/tez-0.9.1 \
&& rm -f /opt/tez/tez-0.9.1/lib/slf4j-* \
&& cp /opt/hadoop/hadoop-2.7.5/share/hadoop/mapreduce/hadoop-mapreduce-client-co* /opt/tez/tez-0.9.1/lib/ \
&& rm /opt/tez/tez-0.9.1/lib/hadoop-mapreduce-client-co*-2.7.0.jar \
&& rm apache-tez-0.9.1-bin.tar.gz

RUN mkdir -p /opt/tomcat && cd /opt/tomcat \
&& wget http://192.168.1.202:15973/soft/apache-tomcat-9.0.16.tar.gz \
&& tar zxvf apache-tomcat-9.0.16.tar.gz \
&& mv /opt/tomcat/apache-tomcat-9.0.16 /opt/tomcat/tomcat-9.0.16 \
&& mkdir /opt/tomcat/tomcat-9.0.16/webapps/tez-ui \
&& cp /opt/tez/tez-0.9.1/tez-ui-0.9.1.war /opt/tomcat/tomcat-9.0.16/webapps/tez-ui \
&& rm apache-tomcat-9.0.16.tar.gz \
&& cd /opt/tomcat/tomcat-9.0.16/webapps/tez-ui && unzip tez-ui-0.9.1.war && rm tez-ui-0.9.1.war \
&& chown -R work.work /opt/tomcat/tomcat-9.0.16

RUN mv /opt/hadoop/hadoop-2.7.5/etc/hadoop/core-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/core-site.xml.bak \
&& mv /opt/hadoop/hadoop-2.7.5/etc/hadoop/hdfs-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/hdfs-site.xml.bak \
&& mv /opt/hadoop/hadoop-2.7.5/etc/hadoop/yarn-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/yarn-site.xml.bak \
&& chmod -x /opt/hadoop/hadoop-*/bin/*.cmd && chmod -x /opt/hadoop/hadoop-*/sbin/*.cmd

ADD ./soft/conf/core-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/hdfs-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/mapred-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/yarn-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/conf/tez-site.xml /opt/hadoop/hadoop-2.7.5/etc/hadoop/
ADD ./soft/hadoop.sh /etc/profile.d/

RUN mkdir -p /data/hadoop && chown -R work.work /data/hadoop \
&& chown work.work /etc/profile.d/hadoop.sh \
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/core-site.xml \
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/hdfs-site.xml \
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/mapred-site.xml \
&& chown work.work /opt/hadoop/hadoop-*/etc/hadoop/yarn-site.xml

EXPOSE 8020 8042 8088 19888 50070

