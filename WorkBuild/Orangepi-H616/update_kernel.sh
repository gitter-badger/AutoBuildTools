#!/bin/bash

echo -e "\n **** remove dtb ****\n"
sudo apt purge -y linux-dtb-current-sun50iw9
echo -e "\n **** install dtb ****\n"
sudo dpkg -i linux-dtb-current-sun50iw9_2.1.8_arm64.deb

echo -e "\n **** remove kernel ****\n"
sudo apt purge -y linux-image-current-sun50iw9
echo -e "\n **** install kernel ****\n"
sudo dpkg -i linux-image-current-sun50iw9_2.1.8_arm64.deb

sudo rm ./linux-*.deb

sudo reboot
