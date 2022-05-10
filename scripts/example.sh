#!/bin/bash

c=0
cd /dev
for file in `ls mmcblk*`
do
  filelist[$c]=$file
  ((c++))
done

echo ${filelist[2]}

# b=0
# for value in ${filelist[*]}
# do 
#   echo $value
# done


sudo rm /home/orangepi/expand_rootfs.sh -f

sudo chown orangepi:orangepi /home/orangepi/ -R

c=0
cd /dev
for file in `ls mmcblk*`
do
  filelist[$c]=$file
  ((c++))
done

sudo mount /dev/${filelist[2]} /udisk/
cd /udisk/gcode
sudo cp ./* /home/orangepi/gcode_files -fr
cd ../
sudo cp ./wpa_supplicant.conf /etc/

cd /
sudo umount /udisk

sudo killall wpa_supplicant
sudo ifconfig eth0 down
sudo ifconfig wlan0 up
sudo wpa_supplicant -Dnl80211 -c /etc/wpa_supplicant.conf -i wlan0 &
sudo udhcpc -i wlan0
sudo ifconfig eth0 up
