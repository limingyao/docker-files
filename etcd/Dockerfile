FROM limingyao/centos7-base:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/etcd && cd /opt/etcd \
&& wget http://192.168.188.157:15973/soft/etcd-v3.3.12-linux-amd64.tar.gz \
&& tar zxvf etcd-v3.3.12-linux-amd64.tar.gz \
&& mv etcd-v3.3.12-linux-amd64 etcd-v3.3.12 \
&& chown -R work.work /opt/etcd/etcd-* \
&& rm etcd-v3.3.12-linux-amd64.tar.gz

ADD ./soft/conf-0.yml /opt/etcd/etcd-v3.3.12/
ADD ./soft/conf-1.yml /opt/etcd/etcd-v3.3.12/
ADD ./soft/conf-2.yml /opt/etcd/etcd-v3.3.12/
ADD ./soft/etcd.conf /etc/supervisord.d/work/
ADD ./soft/etcd.sh /etc/profile.d/

RUN mkdir -p /data/etcd && chown -R work.work /data/etcd \
&& chown work.work /etc/supervisord.d/work/etcd.conf \
&& chown work.work /etc/profile.d/etcd.sh \
&& chown work.work /opt/etcd/etcd-v3.3.12/conf-*.yml


EXPOSE 2379 2389 2399

