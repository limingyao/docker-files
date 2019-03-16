### spark download url
> https://mirrors.tuna.tsinghua.edu.cn/apache/spark/spark-2.2.3/spark-2.2.3-bin-hadoop2.7.tgz


+ hdfs dfs -mkdir /user/work/spark_jars
+ hdfs dfs -put jars/* /user/work/spark_jars

+ spark.yarn.jars hdfs://hadoop:8020/user/work/spark_jars/*
+ spark-shell --master yarn --deploy-mode client

&& echo "spark.yarn.jars hdfs://hadoop:8020/user/work/spark_jars/*" >> spark-defaults.conf \\