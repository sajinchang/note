#!/usr/bin/env bash

# 判断成绩

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
