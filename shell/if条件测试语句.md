# if 条件测试

## 语法

```shell
if 条件测试操作1;
    then 命令序列1
elif 条件测试操作2;
    then 命令序列2
else
    命令序列2
fi
```

## 使用

```shell
#!/usr/bin/env bash

read -p "Enter you score(0-100):" GRADE

if [ $GRADE -ge 85 ] && [ $GRADE -le 100 ]; then
    echo "$GRADE score is excellent"
elif [ $GRADE -lt 85 ] && [ $GRADE -ge 60 ]; then
    echo "$GRADE good"
elif [ $GRADE -gt 100 ] || [ $GRADE -lt 0 ]; then
    echo "error"
else
    echo "bad"
fi
```
