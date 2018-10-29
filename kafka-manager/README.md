# kafka管理器kafka-manager部署安装

## 功能
  + 管理多个kafka集群
  + 便捷的检查kafka集群状态（topics, brokers, 备份分布情况, 分区分布情况）
  + 选择你要运行的副本
  + 可以选择topic配置并创建topic
  + 删除topic（只支持0.8.2以上的版本并且要在broker配置中设置delete.topic.enable=true）
  + topic list会指明哪些topic被删除（在0.8.2以上版本适用）
  + 为已存在的topic增加分区
  + 为已存在的topic更新配置
  + 在多个topic上批量重分区
  + 在多个topic上批量重分区（可选partition broker位置）

## 环境要求
  + Kafka 0.8.. or 0.9.. or 0.10.. or 0.11..
  + sbt 0.13.x
  + Java 8+

## 安装部署
  + 安装 sbt
  + git clone https://github.com/yahoo/kafka-manager.git
  + cd kafka-manager
  + sbt clean dist
  + 编译成功后，会在target/universal下生成一个zip包
  + unzip kafka-manager-*.zip
  + vim kafka-manager-*/conf/application.conf
  + 配置 application.conf 中 kafka-manager.zkhosts 的值
  + bin/kafka-manager -Dconfig.file=conf/application.conf -Dhttp.port=9001
  + 第一次进入web UI要进行kafka cluster的相关配置

> https://github.com/yahoo/kafka-manager
