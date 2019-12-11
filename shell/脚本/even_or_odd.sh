#!/usr/bin/env bash

# 判断奇偶性

num=0

echo "Please enter a number >"

read num
case $num in
[a-z] | [A-Z])
    echo "请输入0-9之间的数字"
    exit 0
    ;;
*) ;;
esac

echo "the num is $num"

if [ $((num % 2)) -eq 0 ]; then
    echo "the num is even"
else
    echo "the num is odd"

fi
