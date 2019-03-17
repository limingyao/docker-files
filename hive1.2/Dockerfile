FROM limingyao/hadoop2.7:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/hive && cd /opt/hive \
&& wget http://192.168.1.202:15973/soft/apache-hive-1.2.2-bin.tar.gz \
&& tar zxvf apache-hive-1.2.2-bin.tar.gz && rm apache-hive-1.2.2-bin.tar.gz \
&& mv apache-hive-1.2.2-bin hive-1.2.2 \
&& cd /opt/hive/hive-*/conf && cp beeline-log4j.properties.template beeline-log4j.properties \
&& cp hive-exec-log4j.properties.template hive-exec-log4j.properties \
&& cp hive-log4j.properties.template hive-log4j.properties \
&& chown -R work.work /opt/hive/hive-*

ADD ./soft/conf/hive-site.xml /opt/hive/hive-1.2.2/conf/
ADD ./soft/hive-hwi-1.2.2.war /opt/hive/hive-1.2.2/lib/
ADD ./soft/jasper-compiler-5.5.23.jar /opt/hive/hive-1.2.2/lib/
ADD ./soft/jasper-runtime-5.5.23.jar /opt/hive/hive-1.2.2/lib/
ADD ./soft/commons-el-1.0.jar /opt/hive/hive-1.2.2/lib/
ADD ./soft/mysql-connector-java-5.1.47.jar /opt/hive/hive-1.2.2/lib/
ADD ./soft/hive.sh /etc/profile.d/

RUN mkdir -p /data/hive/exec && mkdir -p /data/hive/downloadedsource \
&& mkdir -p /data/hive/logs && chown -R work.work /data/hive \
&& chown work.work /etc/profile.d/hive.sh \
&& chown work.work /opt/hive/hive-*/conf/hive-site.xml \
&& chown work.work /opt/hive/hive-*/lib/hive-hwi-1.2.2.war \
&& chown work.work /opt/hive/hive-*/lib/jasper-compiler-5.5.23.jar \
&& chown work.work /opt/hive/hive-*/lib/jasper-runtime-5.5.23.jar \
&& chown work.work /opt/hive/hive-*/lib/commons-el-1.0.jar \
&& chown work.work /opt/hive/hive-*/lib/mysql-connector-java-5.1.47.jar \
&& ln -s /opt/jdk/jdk*/lib/tools.jar /opt/hive/hive-1.2.2/lib/tools.jar

EXPOSE 9083 9999 10000

