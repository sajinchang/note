# case 条件测试

## 语法

```shell
case 变量值 in
    模式1 )
    命令序列1
    ;;
    模式2 )
    命令序列2
    ;;
    ..........
    *)
    默认命令序列

esac
```

## 使用

```shell
#!/usr/bin/env bash

# 判断用户输入的字符

read -p "please enter a key and enter the keyboard'Enter':" KEY
case $KEY in
[0-9])
    echo "您输入的是数字: $KEY"
    ;;
[a-z] | [A-Z])
    echo "您输入的是字母: $KEY"
    ;;
*)
    # 默认命令序列
    echo "您输入的是其他字符: $KEY"
esac
```
