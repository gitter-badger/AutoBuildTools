#!/bin/bash

c=0
cd /dev
for file in `ls mmcblk*`
do
  filelist[$c]=$file
  ((c++))
done

cd /

ROOT_DEV=/dev/${filelist[0]}

ROOT_NUM=1
UDISK_NUM=2

PART_SIZE=`cat /sys/block/${filelist[0]}/size`

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

sudo resize2fs /dev/${filelist[1]}           # 扩展分区;

sudo mkdir /udisk

if [[ \${filelist[2]} == mmcblk0p2 ]]; then
    sudo mkfs.vfat /dev/mmcblk0p2            # 格式化分区为 FAT 格式;
    sudo mount /dev/mmcblk0p2 /udisk/
fi

if [[ \${filelist[2]} == mmcblk1p2 ]]; then
    sudo mkfs.vfat /dev/mmcblk1p2            # 格式化分区为 FAT 格式;
    sudo mount /dev/mmcblk1p2 /udisk/
fi

#-----------------------
cd /udisk
sudo mkdir gcode

cd /
sudo umount /udisk
sudo rm /udisk -fr
#-----------------------

cd /home/orangepi/scripts

sudo rm init.sh -fr
touch init.sh
chmod +x init.sh

cat >> init.sh << EOF
#!/bin/bash

c=0
cd /dev
for file in \`ls mmcblk*\`
do
    filelist[\$c]=\$file
    ((c++))
done

cd /home/orangepi/scripts
if [ -e "expand_rootfs.sh" ];then  
    sudo rm ./expand_rootfs.sh -fr
fi

sudo chown orangepi:orangepi /home/orangepi/ -R

sudo mkdir /udisk
if [[ \${filelist[2]} == mmcblk0p2 ]]; then
    sudo mount /dev/mmcblk0p2 /udisk/
fi

if [[ \${filelist[2]} == mmcblk1p2 ]]; then
    sudo mount /dev/mmcblk1p2 /udisk/
fi

cd /udisk/gcode
if ls *.gcode > /dev/null 2>&1;then
    sudo cp ./*.gcode /home/orangepi/gcode_files -fr
    sudo rm ./*.gcode -fr
fi

cd /udisk
if [ -e "wpa_supplicant.conf" ];then
    sudo cp ./wpa_supplicant.conf /etc/
fi

cd /
sudo umount /udisk
sudo rm /udisk -fr

cd /home/orangepi/scripts
./start_wifi.sh

EOF

# trap "sudo rm ~/expand_rootfs.sh -f" EXIT		#脚本退出执行trap后面双引号中的命令
# sudo sed -i 's/\/home\/orangepi\/expand_rootfs.sh/sudo rm \/home\/orangepi\/expand_rootfs.sh/' /etc/rc.local

sudo sed -i 's/expand_rootfs.sh/init.sh/' /etc/rc.local

sudo reboot
