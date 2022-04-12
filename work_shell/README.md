- [0. 说明](#0-说明)
- [1. start_wifi.sh](#1-start_wifish)
  - [1.1 文件说明](#11-文件说明)
  - [1.2 配置文件](#12-配置文件)
- [2. start_can.sh](#2-start_cansh)
  - [2.1 文件说明](#21-文件说明)
  - [2.2 信息查看](#22-信息查看)
  - [2.3 klipper操作](#23-klipper操作)

---

# 0. 说明

编写工作中用到的小脚本

# 1. start_wifi.sh

## 1.1 文件说明

开机自启动，先断开 eth0，然后开启 wlan0，申请IP后再开启 eth0；

## 1.2 配置文件

文件路径：

    /etc/wpa_supplicant.conf

文件内容：

    ctrl_interface=/var/run/wpa_supplicant
    ctrl_interface_group=0
    update_config=1

    network={
        ssid="wifi_name"
        psk="wifi_Password"
    }


# 2. start_can.sh

## 2.1 文件说明

开机自启动，打开 can 通信；

## 2.2 信息查看

查看 can0 加载 信息

    dmesg | grep -i '\(can\|spi\)'

查看 can0 信息

    sudo ip -details link show can0

## 2.3 klipper操作

连接can设备

    ~/klippy-env/bin/python ~/klipper/scripts/canbus_query.py can0

若出现错误：

    mcu 'mcu': Unable to open CAN port: Failed to transmit: [Errno 100] Network is down

运行以下命令，然后重启

    ~/moonraker/scripts/set-policykit-rules.sh

