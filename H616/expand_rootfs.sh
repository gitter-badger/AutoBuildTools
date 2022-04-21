#!/bin/bash

cd /
sudo mkdir /udisk

ROOT_DEV=/dev/mmcblk1

ROOT_NUM=1
UDISK_NUM=2

PART_SIZE=`cat /sys/block/mmcblk1/size`

UDISK_START=`expr $PART_SIZE - 614400`

ROOTFS_START=8192
ROOTFS_END=`expr $UDISK_START - 1`

# 使用 fdisk 工具进行磁盘分区;
sudo fdisk "$ROOT_DEV" << EOF
p
d
n
p
$ROOT_NUM
$ROOTFS_START
$ROOTFS_END
y
n
p
$UDISK_NUM
$UDISK_START

y
t
$UDISK_NUM
b
w
EOF

sudo resize2fs /dev/mmcblk1p1           # 扩展分区;

sudo mkfs.fat /dev/mmcblk1p2            # 格式化分区为 FAT 格式;

#-----------------------
sudo mount /dev/mmcblk1p2 /udisk/
cd /udisk
mkdir gcode 
cd /
sudo umount /udisk
#-----------------------

mkdir /home/orangepi/scripts

cd /home/orangepi/scripts

touch init.sh
chmod +x init.sh

cat >> init.sh << EOF

sudo rm /home/orangepi/expand_rootfs.sh -f

sudo mount /dev/mmcblk1p2 /udisk/
cd /udisk/gcode
sudo cp ./* /home/orangepi/ -fr
cd ../
sudo cp ./wpa_supplicant /etc/

sudo umount /udisk

sudo killall wpa_supplicant
sudo ifconfig eth0 down
sudo ifconfig wlan0 up
sudo wpa_supplicant -Dnl80211 -c /etc/wpa_supplicant.conf -i wlan0 &
sudo udhcpc -i wlan0
sudo ifconfig eth0 up

EOF

# trap "sudo rm ~/expand_rootfs.sh -f" EXIT		#脚本退出执行trap后面双引号中的命令
# sudo sed -i 's/\/home\/orangepi\/expand_rootfs.sh/sudo rm \/home\/orangepi\/expand_rootfs.sh/' /etc/rc.local

sudo sed -i 's/expand_rootfs.sh/scripts\/init.sh/' /etc/rc.local

sudo reboot
