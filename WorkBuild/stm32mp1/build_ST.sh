#!/bin/bash

CycleSelect=1

cd $SHELL_ROOT_PATH/stm32mp1

if [ $# == 0 ]; then
    Type_Chose=0
    if [ $linuxVersion == "5.10" ]; then
        source ~/STM32MP157/SDK/environment-setup-cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi
    fi

    tput reset      # clear screen;

    while [ $CycleSelect == 1 ]
    do
        echo -e "\n$blue/==================================================\\\\$clear"
        if [ $linuxVersion == "5.4" ]; then
            echo -e "$V_line $skyblue         [ Build openSTLinux5.4 Menu ]          $clear $V_line"
        elif [ $linuxVersion == "5.10" ]; then
            echo -e "$V_line $skyblue         [ Build openSTLinux5.10 Menu ]         $clear $V_line"
        fi
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line            $yellow_flash***** Please choose *****$clear             $V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line $yellow  1:$clear compile TF-A;     $V_line $yellow  5:$clear clear TF-A         $V_line"
        echo -e "$V_line $yellow  2:$clear compile u-boot    $V_line $yellow  6:$clear clear u-boot       $V_line"
        echo -e "$V_line $yellow  3:$clear compile kernel    $V_line $yellow  7:$clear clear kernel       $V_line"
        echo -e "$V_line $yellow  4:$clear compile rootfs    $V_line $yellow  8:$clear clear rootfs       $V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$blue|          $yellow Flash firmware to Core-Board $clear          $V_line"
        echo -e "$blue|------$blue_flash Atk-Model$clear $blue-------|-------$blue_flash Biqu-Model$clear $blue------|$clear"
        echo -e "$V_line $yellow  11:$clear flash bootfs     $V_line  $yellow 33:$clear flash bootfs      $V_line"
        echo -e "$V_line $yellow  22:$clear flash rootfs     $V_line  $yellow 44:$clear flash rootfs      $V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line                            $purple Q/B: Quit or Back!$clear   $V_line"
        echo -e "$blue\\==================================================/$clear"
        echo -e "$yellow\n Your choice:$clear \c "
        
        read Type_Chose

        if [[ $Type_Chose == "q" || $Type_Chose == "Q" ]]; then
            exit 0
        fi

        if [[ $Type_Chose == "b" || $Type_Chose == "B" ]]; then
            . ../AutoBuildTool
        fi

        if [[ $Type_Chose -ge 1 && $Type_Chose -le 8 ]]; then
            CycleSelect=0
        fi

        if [[ $Type_Chose -lt 1 || $Type_Chose -gt 8 ]]; then
            if [[ $Type_Chose -eq 11 || $Type_Chose -eq 22 || $Type_Chose -eq 33 || $Type_Chose -eq 44 ]]; then
                CycleSelect=0
            else
                tput reset      # clear screen;
                echo -e "\n$blue/=================================================\\\\$clear"
                echo -e "$V_line $red_flash       Selection error,Please try again!       $clear $V_line"
                echo -e "$blue\\=================================================/$clear"
                Type_Chose=0
            fi
        fi
        
    done
else
    echo -e "\n$blue/==================================================\\\\$clear"
    echo -e "$V_line $red_flash    No parameters required,Please try again!    $clear $V_line"
    echo -e "$blue\\==================================================/$clear"
    exit 0
fi

cd $PATH_BUILD_SHELL

set | grep CROSS   # 筛选包含 CROSS 的环境变量;

if [[ $Type_Chose -le 4 && $Type_Chose -ge 1 ]]; then
    . ./compileFirmware.sh
elif [[ $Type_Chose -le 8 && $Type_Chose -ge 5 ]]; then
    . ./clearFirmware.sh
elif [[ $Type_Chose -eq 11 || $Type_Chose -eq 22 ]]; then
    CoreBoardModel="Atk"
    . ./flashFirmware.sh
elif [[ $Type_Chose -eq 33 || $Type_Chose -eq 44 ]]; then
    CoreBoardModel="${CompanyLogo}"
    . ./flashFirmware.sh
fi
