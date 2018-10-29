FROM limingyao/centos7-jdk8-base:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/zookeeper && cd /opt/zookeeper \
&& wget http://192.168.188.146:15973/soft/zookeeper-3.4.10.tar.gz \
&& tar zxvf zookeeper-3.4.10.tar.gz \
&& chown -R work.work /opt/zookeeper/zookeeper-* \
&& rm zookeeper-3.4.10.tar.gz

# for auth & config
RUN chmod -x /opt/zookeeper/zookeeper-*/bin/*.cmd && chmod -x /opt/zookeeper/zookeeper-*/bin/README.txt \
&& sed -i 's/zookeeper.root.logger=.*/zookeeper.root.logger=INFO, CONSOLE, ROLLINGFILE/g' /opt/zookeeper/zookeeper-*/conf/log4j.properties \
&& sed -i 's/log4j.appender.ROLLINGFILE=.*/log4j.appender.ROLLINGFILE=org.apache.log4j.DailyRollingFileAppender/g' /opt/zookeeper/zookeeper-*/conf/log4j.properties \
&& sed -i 's/log4j.appender.ROLLINGFILE.MaxFileSize/#log4j.appender.ROLLINGFILE.MaxFileSize/g' /opt/zookeeper/zookeeper-*/conf/log4j.properties \
&& sed -i 's#ZOO_LOG_DIR="."#ZOO_LOG_DIR=/data/zookeeper/logs#g' /opt/zookeeper/zookeeper-*/bin/zkEnv.sh \
&& sed -i 's/ZOO_LOG4J_PROP=.*/ZOO_LOG4J_PROP="INFO, CONSOLE, ROLLINGFILE"/g' /opt/zookeeper/zookeeper-*/bin/zkEnv.sh

ADD ./soft/zoo.cfg /opt/zookeeper/zookeeper-3.4.10/conf/
ADD ./soft/zk.conf /etc/supervisord.d/work/
ADD ./soft/zk.sh /etc/profile.d/

RUN mkdir -p /data/zookeeper/logs && chown -R work.work /data/zookeeper \
&& chown work.work /etc/supervisord.d/work/zk.conf \
&& chown work.work /etc/profile.d/zk.sh \
&& chown work.work /opt/zookeeper/zookeeper-3.4.10/conf/zoo.cfg

EXPOSE 2181

