#!/bin/bash

linuxVersion="5.4"
CoreBoardModel="Atk"

# 用作备份标识
CompanyLogo=biqu

USERNAME=lodge
MOUNT_DIR=rootfs

WindowsIP=192.168.0.203

# ======== PATH ========
SHELL_NAME=AutoBuildTools
SHELL_ROOT_PATH=/home/$USERNAME/Code/$SHELL_NAME/WorkBuild

WINDOWS_SHARE_DIR=/run/user/1000/gvfs/smb-share:server=$WindowsIP,share=code         # windows 共享文件夹;
WINDOWS_BACKUP_DIR=/run/user/1000/gvfs/smb-share:server=$WindowsIP,share=backup
#--------------------------- ArmDebian --------------------------------
ARM_DEBIAN_ROOTFS_PATH=/home/lodge/ArmDebian

OS_Choose=0
ARM_QT=0

Qt_dir=/home/lodge/Qt-Arm/qt-everywhere-src-5.12.11

#--------------------------- STM32MP157 -------------------------------
PATH_ST_WORKSPACE=/home/lodge/STM32MP157
PATH_UPDATE=$PATH_ST_WORKSPACE/flash_Image

PATH_FACTORY_IMAGE=$PATH_ST_WORKSPACE/flash_Image/DefaultImage
PATH_BUILD_SHELL=$SHELL_ROOT_PATH/stm32mp1

PATH_ST_SOURCE_5_4=$PATH_ST_WORKSPACE/openSTLinux-5.4
PATH_ST_SOURCE_5_10=$PATH_ST_WORKSPACE/openSTLinux-5.10

PATH_SOURCE_5_4_TF_A=$PATH_ST_SOURCE_5_4/tf-a-2.2/tf-a-stm32mp
PATH_SOURCE_5_4_U_BOOT=$PATH_ST_SOURCE_5_4/u-boot
PATH_SOURCE_5_4_KERNEL=$PATH_ST_SOURCE_5_4/linux-5.4
PATH_SOURCE_5_4_BUSYBOX=$PATH_ST_SOURCE_5_4/busybox
PATH_SOURCE_5_4_BUILDROOT=$PATH_ST_SOURCE_5_4/buildroot

PATH_SOURCE_5_10_TF_A=$PATH_ST_SOURCE_5_10/tf-a/tf-a-stm32mp
PATH_SOURCE_5_10_U_BOOT=$PATH_ST_SOURCE_5_10/u-boot/u-boot-stm32mp
PATH_SOURCE_5_10_KERNEL=$PATH_ST_SOURCE_5_10/linux/linux-5.10
PATH_SOURCE_5_10_OPTEE=$PATH_ST_SOURCE_5_10/optee/optee-os-stm32mp
PATH_SOURCE_5_10_BUSYBOX=$PATH_ST_SOURCE_5_10/busybox
PATH_SOURCE_5_10_BUILDROOT=$PATH_ST_SOURCE_5_10/buildroot

#--------------------------- RaspBerry --------------------------------
PATH_PI_WORKSPACE=/home/lodge/raspberrypi

PATH_PI_SOURCE_pi3=$PATH_PI_WORKSPACE/linux/Pi3
PATH_PI_SOURCE_pi4=$PATH_PI_WORKSPACE/linux/Pi4


# backup



# ======== color ========
clear='\033[0m'
black='\033[30m'
red='\033[31m'
green='\033[32m'
yellow='\033[33m'
blue='\033[34m'
purple='\033[35m'
skyblue='\033[36m'
white='\033[37m'

black_flash='\033[30;5m'
red_flash='\033[31;5m'
green_flash='\033[32;5m'
yellow_flash='\033[33;5m'
blue_flash='\033[34;5m'
purple_flash='\033[35;5m'
skyblue_flash='\033[36;5m'
white_flash='\033[37;5m'

# Var
S_line="$blue/$clear"       # /
V_line="$blue|$clear"       # |
H_line="$blue-$clear"       # -
BS_line="$blue\\\\$clear"   # \
