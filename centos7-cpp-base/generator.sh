#!/bin/bash

cat > Dockerfile <<EOF
FROM limingyao/centos7-base:latest
MAINTAINER mingyaoli@tencent.com

RUN yum -y -q install gcc gcc-c++ cmake cmake3 && yum clean all

EOF
