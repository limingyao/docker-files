#!/bin/bash

if [ ! -f "./soft/jdk-7u80-linux-x64.tar.gz" ]; then
    echo "./soft/jdk-7u80-linux-x64.tar.gz not exist"
    echo "please see README.md to download jdk-7u80-linux-x64.tar.gz"
    exit 1
fi

cat > Dockerfile <<EOF
FROM limingyao/centos7-base:latest
MAINTAINER mingyaoli@tencent.com

RUN mkdir -p /opt/jdk
ADD ./soft/jdk-7u80-linux-x64.tar.gz /opt/jdk/
ADD ./soft/jdk.sh /etc/profile.d/

EOF
