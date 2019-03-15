### hive download url
> https://mirrors.tuna.tsinghua.edu.cn/apache/hive/
> http://www.apache.org/dyn/closer.cgi/hive/

### how to build hive-hwi-1.2.2.war
  + download apache-hive-1.2.2-src.tar.gz
  + cd apache-hive-1.2.2-src/hwi
  + jar cfM hive-hwi-1.2.2.war -C web .

### how to use
  + hdfs dfs -mkdir -p /hive1.2/warehouse
  + hdfs dfs -mkdir -p /hive1.2/logs
  + hdfs dfs -mkdir -p /hive1.2/tmp
  + hive --service metastore
  + hive --service hiveserver2
  + hive --service hwi
  + hive
  + hiveserver2
    + hive jdbc
    + beeline