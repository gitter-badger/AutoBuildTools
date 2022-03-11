#!/bin/bash

# ********************** wifi ***************************** #
sudo ifconfig eth0 down

sudo ifconfig wlan0 up

sudo wpa_supplicant -Dnl80211 -c /etc/wpa_supplicant.conf -i wlan0 &

sudo udhcpc -i wlan0

sudo ifconfig eth0 up

# 扫描 wifi
# sudo iwlist wlan0 scanning
