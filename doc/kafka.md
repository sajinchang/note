# kafka

## 1. kafka 和 zookeeper 配置

zookeeper 配置
复制 zookeeper/conf/zoo_sample.cfg 文件

==修改 dataDir==

==修改 logDataDir==

==端口默认2181==

```python
'''
zookeeper配置
复制zookeeper/conf/zoo_sample.cfg文件为zoo.cfg
'''
# The number of milliseconds of each tick
tickTime=2000
# The number of ticks that the initial
# synchronization phase can take
initLimit=10
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
syncLimit=5
# the directory where the snapshot is stored.
# do not use /tmp for storage, /tmp here is just
# example sakes.
dataDir=/app/data # 修改dataDir
logDataDir=/app/log # 修改logDataDir
# the port at which the clients will connect
clientPort=2181 # 端口默认2181
# the maximum number of client connections.
# increase this if you need to handle more clients
#maxClientCnxns=60
#
# Be sure to read the maintenance section of the
# administrator guide before turning on autopurge.
#
# http://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_maintenance
#
# The number of snapshots to retain in dataDir
#autopurge.snapRetainCount=3
# Purge task interval in hours
# Set to "0" to disable auto purge feature
#autopurge.purgeInterval=1
```

## 2. kafka 配置

打开 kafka/config/consumer.properties 文件

==修改 zookeeper.connect=127.0.0.1:2181==

------
 连接 zookeeper

```python
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# see kafka.consumer.ConsumerConfig for more details

# Zookeeper connection string
# comma separated host:port pairs, each corresponding to a zk
# server. e.g. "127.0.0.1:3000,127.0.0.1:3001,127.0.0.1:3002"
zookeeper.connect=127.0.0.1:2181

# timeout in ms for connecting to zookeeper
zookeeper.connection.timeout.ms=6000

#consumer group id
group.id=test-consumer-group

#consumer timeout
#consumer.timeout.ms=5000

```

## 3. 启动

```shell
# 启动zookeeper
./zkServer.sh start  ../conf/zoo.cfg

# 启动kafka
./kafka-server-start.sh -daemon ../config/server.properties

# 创建topic
./kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic sam01

# 创建生产者
./kafka-console-producer.sh --broker-list localhost:9092 --topic sam01

# 创建消费者    订阅所有消息
./kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic sam01 --from-beginning

# 删除topic
./kafka-topic.sh --zookeeper localhost:2181 --delete --topic sam0
# 上面命令将主题test_topic标记为删除，但是如果delete.topic.enable没有配置为True，上述命令无效.
# 可对数据进行删除

# 修改topic
./kafka-topic.sh --zookeeper localhost:2181 --later --partition 10 --topic sam0

# 查询topic详细信息
./kafka-topic.sh --zookeeper localhost:2181 --describe --topic sam0

# 查看所有的tpoic
kafka-topic.sh --list --zookeeper 127.0.0.1:2181
```
