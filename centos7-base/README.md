### change to aliyun mirrors
+ RUN cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
+ RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
+ RUN rpm -import http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7

### install aliyun epel
+ RUN rpm -Uvh http://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
+ RUN rpm -import http://mirrors.aliyun.com/epel/RPM-GPG-KEY-EPEL-7
+ RUN rpm -import http://mirrors.aliyun.com/epel/RPM-GPG-KEY-EPEL-7Server
