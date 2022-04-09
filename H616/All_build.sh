#!/bin/bash

Pi_user=orangepi
Pi_IP=192.168.0.96

cd /home/lodge/Allwinner/orangepi-build

cp ./u-boot/v2021.07-sunxi/.config ./u-boot/v2021.07-sunxi/configs/orangepi_zero2_defconfig

#=================================


echo -e "\n ==== copy update script ====\n"
cp $SHELL_ROOT_PATH/H616/update_kernel.sh /home/lodge/Allwinner/orangepi-build/nfs_folder/



echo -e "\n ==== copy wifi files ====\n"

#cd /home/lodge/Allwinner/orangepi-build/nfs_folder/29_WIFI
#cp regulatory.* /home/lodge/Allwinner/orangepi-build/nfs_folder/
# scp regulatory.db regulatory.db.p7s $Pi_user@$Pi_IP:/home/$Pi_user

cd ~/Allwinner/orangepi-build/kernel/orange-pi-5.13-sunxi64/drivers/net/wireless/rtl8189fs
#cp 8189fs.ko /home/lodge/Allwinner/orangepi-build/nfs_folder/

cd ~/Allwinner/orangepi-build/kernel/orange-pi-5.13-sunxi64/net/wireless/
#cp cfg80211.ko /home/lodge/Allwinner/orangepi-build/nfs_folder/


cd /home/lodge/Allwinner/orangepi-build
sudo ./build.sh

echo -e "\n ==== copy images ====\n"

cp output/debs/u-boot/linux-*.deb /home/lodge/Allwinner/orangepi-build/nfs_folder/
cp output/debs/linux-*.deb /home/lodge/Allwinner/orangepi-build/nfs_folder/

echo -e "\n ==== copy modules ====\n"
cd /home/lodge/Allwinner/orangepi-build/nfs_folder/

rm -fr 5.13.0-sun50iw9/

cd ~/Allwinner/orangepi-build/kernel/orange-pi-5.13-sunxi64/debian/tmp/lib/modules

cp -r 5.13.0-sun50iw9/ /home/lodge/Allwinner/orangepi-build/nfs_folder/


echo -e "\n ==== copy images ====\n"
cd /home/lodge/Allwinner/orangepi-build/nfs_folder/

#scp -r 5.13.0-sun50iw9 *.ko *.deb regulatory.* *.sh $Pi_user@$Pi_IP:/home/$Pi_user

scp -r 5.13.0-sun50iw9 *.deb regulatory.* *.sh $Pi_user@$Pi_IP:/home/$Pi_user

echo -e "\n **** build complete! ****\n"


