#!/bin/bash

Pi_user=orangepi
Pi_IP=192.168.0.96

cd /home/lodge/Allwinner/orangepi-build

cp ./u-boot/v2021.07-sunxi/.config ./u-boot/v2021.07-sunxi/configs/orangepi_zero2_defconfig

sudo ./build.sh

echo -e "\n ==== copy images ====\n"
scp output/debs/u-boot/linux-*.deb $Pi_user@$Pi_IP:/home/$Pi_user
scp output/debs/linux-*.deb $Pi_user@$Pi_IP:/home/$Pi_user

echo -e "\n ==== copy update script ====\n"
scp $SHELL_ROOT_PATH/H616/update_kernel.sh $Pi_user@$Pi_IP:/home/$Pi_user

echo -e "\n **** build complete! ****\n"

