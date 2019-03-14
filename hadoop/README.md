### hadoop download url
> https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/
> https://www.apache.org/dyn/closer.cgi/hadoop

### tez download url
> https://mirrors.tuna.tsinghua.edu.cn/apache/tez/0.9.1/apache-tez-0.9.1-bin.tar.gz

### how to use
  + su work
  + rsawrapper
  + test run
    + ssh localhost
  + hdfs namenode -format
  + ./sbin/start-dfs.sh
  + ./sbin/start-yarn.sh
  + ./sbin/mr-jobhistory-daemon.sh start historyserver
  + hdfs dfs -mkdir /user
  + hdfs dfs -mkdir /user/work
  + hdfs dfs -put etc/hadoop input
  + hdfs dfs -mkdir /user/tez
  + hdfs dfs -put tez-0.9.1/share/tez.tar.gz /user/tez
  + hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.5.jar grep input output 'dfs[a-z.]+'
  + hadoop jar tez-examples-0.9.1.jar orderedwordcount /input /output2