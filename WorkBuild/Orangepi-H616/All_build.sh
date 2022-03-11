#!/bin/bash

Pi_user=orangepi
Pi_IP=192.168.0.239

cd /home/lodge/Allwinner/orangepi-build

sudo ./build.sh

echo -e "\n ==== copy images ====\n"
scp output/debs/linux-*.deb $Pi_user@$Pi_IP:/home/$Pi_user

echo -e "\n ==== copy update script ====\n"
scp $SHELL_ROOT_PATH/Orangepi-H616/update_kernel.sh $Pi_user@$Pi_IP:/home/$Pi_user

echo -e "\n **** build complete! ****\n"

