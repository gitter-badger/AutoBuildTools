#!/bin/bash

# 测试 io 口输出是否正常;

cd /sys/class/gpio

flashTime=3     # 闪烁频率 秒
cycleNum=2      # 循环次数

echo "OPEN"

for item in $(seq 0 1 27)
do
        sudo echo $item > export
        
        cd gpio$item
        
        sudo echo out > direction
        cd ..
done

for count in $(seq 1 1 $cycleNum)
do
        echo 'ON'

        for item in $(seq 0 1 27)
        do
                sudo echo 0 > ./gpio$item/value
        done

        sleep $flashTime

        echo 'OFF'

        for item in $(seq 0 1 27)
        do
                sudo echo 1 > ./gpio$item/value
        done

        sleep $flashTime
done

echo "CLOSE"

for item in $(seq 0 1 27)
do
        sudo echo $item > unexport
done
