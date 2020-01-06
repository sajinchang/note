# while 条件循环语句

## 语法

```shell
while 条件测试操作
    do
    命令序列
done
```

## 使用

```shell
#!/usr/bin/env bash

# 猜数值大小的游戏

NUM=$(expr $RANDOM % 1000)
TIMES=0

echo "实际数字在0-999之间,猜猜看时是多少"

while true; do
    read -p "请输入你心目中的值: " INT

    let TIMES++
    if [ $INT -lt 0 ] || [ $INT -gt 999 ]; then
        echo "请输入0-999之间的数字"
        continue
    fi

    if [ $INT -eq $NUM ]; then
        echo "恭喜你, 答对了, 结果为: $NUM"
        echo "您一共用了$TIMES次"
        exit 0
    elif [ $INT -lt $NUM ]; then
        echo "sorry 你的答案太小了"
    else
        echo "太大了"
    fi
done
```
