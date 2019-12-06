# for 条件循环

## 语法

```shell
for 变量名 in 取值列表
do
    命令序列
done
```

## 使用

```shell
#!/usr/bin/env bash

# 查看主机列表是否在线
HOSTS=$(cat ./file/ipaddr)
for host in $HOSTS; do

    ping -c 3 -i 0.2 -w 3 $host &>/dev/null
    if [ $? -eq 0 ]; then
        echo "$host is online"
    else
        echo "$host is offline"
    fi
done
```
