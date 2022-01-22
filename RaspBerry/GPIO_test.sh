#!/bin/bash


cd /sys/class/gpio

flashTime=3     # 闪烁频率 秒
cycleNum=2      # 循环次数

for count in $(seq 1 1 $cycleNum)
do
        echo 'ON'

        for item in $(seq 0 1 27)
        do
                echo "$item ON"

                sudo echo $item > export

                cd gpio$item

                sudo echo out > direction
                sudo echo 1 > value

                cd ..
        done

        sleep $flashTime

        echo 'OFF'

        for item in $(seq 0 1 27)
        do
                echo "$item off"

                cd gpio$item

                sudo echo 0 > value

                cd ..

                sudo echo $item > unexport
        done

        sleep $flashTime
done

