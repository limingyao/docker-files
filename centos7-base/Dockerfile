FROM centos:7
MAINTAINER mingyaoli@tencent.com

RUN yum -y -q upgrade \
&& yum -y -q install net-tools iproute traceroute \
&& yum -y -q install which tree wget unzip sudo lsof lrzsz less file \
&& yum -y -q install cronie openssh-server openssh-clients tmux vim && yum clean all

# iotop
RUN yum -y -q install epel-release \
&& yum -y -q install iftop ncdu htop atop sysstat && yum clean all

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

# set root
RUN echo 'sa' | passwd --stdin root

# add sudo user
RUN adduser sysadmin && echo 'sa' | passwd --stdin sysadmin \
&& echo "sysadmin    ALL=(ALL)       ALL" > /etc/sudoers.d/sysadmin && chmod 0440 /etc/sudoers.d/sysadmin

# add user
RUN adduser work && echo 'work' | passwd --stdin work

# for pip
ADD ./soft/pip /tmp/tmp/pip
RUN mkdir -p /root/.pip && cp /tmp/tmp/pip/pip.conf /root/.pip && python /tmp/tmp/pip/get-pip.py

# for virtualenv & virtualenvwrapper
RUN pip install virtualenv virtualenvwrapper \
&& echo -e "\n\nexport WORKON_HOME=\$HOME/.virtualenvs" >> /etc/profile \
&& echo "source /usr/bin/virtualenvwrapper.sh" >> /etc/profile \
&& echo "export LESSCHARSET=utf-8" >> /etc/profile \
&& echo "export LC_ALL=C" >> /etc/profile

# for supervisor
RUN pip install meld3==1.0.2 supervisor==3.3.2
ADD ./soft/supervisord /tmp/tmp/supervisord
RUN cp -r /tmp/tmp/supervisord/supervisord.d /etc/supervisord.d \
&& mkdir -p /var/log/supervisord && touch /var/log/supervisord/supervisord.log \
&& cp /tmp/tmp/supervisord/supervisord.conf /etc/supervisord.conf
RUN mkdir /etc/supervisord.d/sysadmin && chown sysadmin.sysadmin /etc/supervisord.d/sysadmin \
&& mkdir /etc/supervisord.d/work && chown work.work /etc/supervisord.d/work

# for sshd
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
&& ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
&& ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
&& sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config

# for tmux
ADD ./soft/tmux.conf /root/.tmux.conf

# for other
ADD ./soft/irm /usr/local/sbin
ADD ./soft/rsawrapper /usr/bin/
RUN rm -rf /tmp/tmp
RUN echo "set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936" >> /etc/vimrc \
&& echo "set termencoding=utf-8" >> /etc/vimrc \
&& echo "set encoding=utf-8" >> /etc/vimrc

EXPOSE 22 8801
CMD ["/usr/bin/supervisord","-n"]

