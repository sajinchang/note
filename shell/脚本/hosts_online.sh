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
