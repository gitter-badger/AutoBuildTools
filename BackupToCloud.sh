#!/bin/bash

ls_date=`date +%Y-%m-%d`        # 获取当前日期;
CycleSelect=1

#---------------------------------------------------------------

if [ $# == 0 ]; then

    Type_Chose=0
    tput reset      # clear screen;

    while [ $CycleSelect == 1 ]
    do
        echo -e "\n$blue/==================================================\\\\$clear"
        echo -e "$V_line $skyblue                [ BackUp Menu ]                 $clear $V_line"
        echo -e "$V_line $skyblue     Which document needs to be backed up?      $clear $V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line            $yellow_flash***** Please choose *****$clear             $V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line $yellow  [99]:$clear$blue Back up all files to Baidu Cloud Drive!  $clear$V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line$green_flash  ** STM32MP157 **                                $clear$V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line $yellow  1:$clear Kernel image      $V_line $yellow  2:$clear uboot image        $V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line                             $purple Q/B: Quit or Back!$clear  $V_line"
        echo -e "$blue\\==================================================/$clear"
        echo -e "$yellow\n Your choice:$clear \c "
        
        read Type_Chose

        if [[ $Type_Chose == "q" || $Type_Chose == "Q" ]]; then
            exit 0
        fi

        if [[ $Type_Chose == "b" || $Type_Chose == "B" ]]; then
            . ./AutoBuildTool
        fi

        if [[ $Type_Chose -eq 9 || $Type_Chose -eq 6 || $Type_Chose -eq 99 ]]; then
            break
        fi

        if [[ $Type_Chose -ge 1 || $Type_Chose -le 2 ]]; then
            CycleSelect=0
        fi

        if [[ $Type_Chose -lt 1 || $Type_Chose -gt 2 ]]; then
            tput reset      # clear screen;
            echo -e "\n$blue/==================================================\\\\$clear"
            echo -e "$V_line $red_flash        Selection error,Please try again!       $clear $V_line"
            echo -e "$blue\\==================================================/$clear"
            Type_Chose=0
        fi

    done
else
    echo -e "\n$blue/==================================================\\\\$clear"
    echo -e "$V_line $red_flash    No parameters required,Please try again!    $clear $V_line"
    echo -e "$blue\\==================================================/$clear"
    exit 0
fi

#----------------------------------------------------------------------------------

case $Type_Chose in
    1)  echo -e "\n$purple Back up kernel for linux5.4$yellow(F)$purple or linux5.10$yellow(T)$purple? $red_flash(F/T)$clear \c"
        read LinuxVer

        if [[ $LinuxVer = "F" || $LinuxVer = "f" ]]; then
            cd $SourceDir_openSTLinux5_4
            linux_Ver="linux-5.4"
            
        elif [[ $LinuxVer = "T" || $LinuxVer = "t" ]]; then          # 恢复;
            cd $SourceDir_openSTLinux5_10
            linux_Ver="linux-5.10"
        fi

        filename="$linux_Ver-$ls_date.tar.gz"
        cd $linux_Ver

        echo -e "\n **** Copy Kernel config! ****\n"
        cp ./.config  ./arch/arm/configs/stm32mp157d_biqu_defconfig
        cp ./.config  ./arch/arm/configs/stm32mp157d_biqu_defconfig_$ls_date

        echo -e "\n **** clean Kernel! ****\n"
        make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- distclean

        cd ..
        echo -e "\n **** Backup Kernel! ****\n"
        tar cvfz $filename ./linux-5.4

        if [ ! -d "$BackUpDir/openSTLinux-5.4" ]; then  # 判断文件夹是否存在;
            mkdir $BackUpDir/openSTLinux-5.4
        fi

        mv $filename $BackUpDir/openSTLinux-5.4

        cd $linux_Ver
        make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- stm32mp157d_biqu_defconfig
        make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- DEVICE_TREE=stm32mp157d-biqu uImage dtbs LOADADDR=0XC2000040 -j16

        echo -e "\n **** Backup Kernel complete! ****\n"
    ;;

esac
