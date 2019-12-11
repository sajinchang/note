#!/usr/bin/env bash

# shift 的测试

echo "You start with $# positional parameters"

# Loop until all parameters are used up
while [ "$1" != "" ]; do
    echo "Parameter 1 equals $1"
    echo "You now have $# positional parameters"

    # Shift all the parameters down by one
    # 用一次shift所有参数往前推一位, $2变为$1, $3变为$2, and so on
    shift

done
