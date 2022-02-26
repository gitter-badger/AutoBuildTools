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
        echo -e "$V_line $yellow  [5]:$clear Backup all files to Baidu Cloud Drive!    $clear$V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line $yellow  [9]:$clear Backup or Recovery this script!           $V_line"
        echo -e "$blue|--------------------------------------------------|$clear"
        echo -e "$V_line$green_flash  ** STM32MP157 **                                $clear$V_line"
        echo -e "$blue|---- linux5.4 ------------------------------------|$clear"
        echo -e "$V_line $yellow  1:$clear tf-a     $V_line $yellow  2:$clear uboot     $V_line $yellow  3:$clear kernel     $V_line"
        echo -e "$blue|---- linux5.10 -----------------------------------|$clear"
        echo -e "$V_line $yellow  4:$clear tf-a     $V_line $yellow  5:$clear uboot     $V_line $yellow  6:$clear kernel     $V_line"
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

        if [[ $Type_Chose -eq 5 ]]; then
            . ./BackupToCloud.sh
            exit 0
        fi

        if [[ $Type_Chose -eq 9 ]]; then
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
if [[ $Type_Chose -eq 9 ]]; then            # This script;

    echo -e "\n$purple Backup$yellow(B)$purple or Recovery$yellow(R)$purple this script? $red_flash(B/R)$clear \c"
    read B_or_R
    
    if [[ $B_or_R == "B" || $B_or_R == "b" ]]; then
        cd $SHELL_ROOT_PATH
        git add .
        
        echo -e "\n Please input commit message:\n"
        read git_MSG

        git commit -m "$git_MSG"
        git push -u origin master

        if [ $? != 0 ]; then        # 判断上一条命令是否成功执行;
            echo -e "\n$blue/==================================================\\\\$clear"
            echo -e "$V_line $green                  [  Notice  ]                  $clear $V_line"
            echo -e "$V_line $green          **** Backup Successful! ****          $clear $V_line"
            echo -e "$blue\\==================================================/$clear"
        else
            echo -e "\n$blue/==================================================\\\\$clear"
            echo -e "$V_line $red                  [  Warning  ]                 $clear $V_line"
            echo -e "$V_line $red            **** Backup failed! ****            $clear $V_line"
            echo -e "$blue\\==================================================/$clear"
        fi
    fi

    if [[ $B_or_R == "R" || $B_or_R == "r" ]]; then
        cd $SHELL_ROOT_PATH/..
        rm $SHELL_ROOT_PATH -fr

        git clone --depth 1 git@github.com:hsl416604093/AutoBuildTools.git

        if [ $? != 0 ]; then        # 判断上一条命令是否成功执行;
            echo -e "\n$blue/==================================================\\\\$clear"
            echo -e "$V_line $green                  [  Notice  ]                  $clear $V_line"
            echo -e "$V_line $green         **** Recovery Successful! ****         $clear $V_line"
            echo -e "$blue\\==================================================/$clear"
        else
            echo -e "\n$blue/==================================================\\\\$clear"
            echo -e "$V_line $red                  [  Warning  ]                 $clear $V_line"
            echo -e "$V_line $red           **** Recovery failed! ****           $clear $V_line"
            echo -e "$blue\\==================================================/$clear"
        fi
    fi

fi

#----------------------------------------------------------------------------------
case $Type_Chose in                         # stm32mp157
    1)  echo -e "\n$purple Whether to backup openlinux5.4's tf-a? $red_flash(y/N)$clear \c"
        read Yes_No

        if [[ $Yes_No = "Y" || $Yes_No = "y" ]]; then
            cd $PATH_SOURCE_5_4_TF_A/../

            git add .
        
            echo -e "\n Please input commit message:\n"
            read git_MSG

            git commit -m "$git_MSG"
            git push -u origin openSTlinux5.4_TF-a

            if [ $? != 0 ]; then        # 判断上一条命令是否成功执行;
                echo -e "\n$blue/==================================================\\\\$clear"
                echo -e "$V_line $green                  [  Notice  ]                  $clear $V_line"
                echo -e "$V_line $green          **** Backup Successful! ****          $clear $V_line"
                echo -e "$blue\\==================================================/$clear"
            elif
                echo -e "\n$blue/==================================================\\\\$clear"
                echo -e "$V_line $red                  [  Warning  ]                 $clear $V_line"
                echo -e "$V_line $red            **** Backup failed! ****            $clear $V_line"
                echo -e "$blue\\==================================================/$clear"
            fi

        fi
    ;;
    
    2)  echo -e "\n$purple Whether to backup openlinux5.4's uboot? $red_flash(y/N)$clear \c"
        read Yes_No

        if [[ $Yes_No = "Y" || $Yes_No = "y" ]]; then
            cd $PATH_SOURCE_5_4_U_BOOT/

            echo -e "\n **** Copy uboot config! ****\n"
            cp ./.config ./configs/stm32mp157d_${CompanyLogo}_defconfig
            cp ./.config ./configs/stm32mp157d_${CompanyLogo}_defconfig_$ls_date

            git add .
        
            echo -e "\n Please input commit message:\n"
            read git_MSG

            git commit -m "$git_MSG"
            git push -u origin openSTlinux5.4_u-boot

            if [ $? != 0 ]; then        # 判断上一条命令是否成功执行;
                echo -e "\n$blue/==================================================\\\\$clear"
                echo -e "$V_line $green                  [  Notice  ]                  $clear $V_line"
                echo -e "$V_line $green          **** Backup Successful! ****          $clear $V_line"
                echo -e "$blue\\==================================================/$clear"
            elif
                echo -e "\n$blue/==================================================\\\\$clear"
                echo -e "$V_line $red                  [  Warning  ]                 $clear $V_line"
                echo -e "$V_line $red            **** Backup failed! ****            $clear $V_line"
                echo -e "$blue\\==================================================/$clear"
            fi

        fi
    ;;

    3)  echo -e "\n$purple Whether to backup openlinux5.4's kernel? $red_flash(y/N)$clear \c"
        read Yes_No

        if [[ $Yes_No = "Y" || $Yes_No = "y" ]]; then
            cd $PATH_SOURCE_5_4_KERNEL/

            echo -e "\n **** Copy Kernel config! ****\n"
            cp ./.config  ./arch/arm/configs/stm32mp157d_${CompanyLogo}_defconfig
            cp ./.config  ./arch/arm/configs/stm32mp157d_${CompanyLogo}_defconfig_$ls_date

            git add .
        
            echo -e "\n Please input commit message:\n"
            read git_MSG

            git commit -m "$git_MSG"
            git push -u origin openSTlinux5.4_linux

            if [ $? != 0 ]; then        # 判断上一条命令是否成功执行;
                echo -e "\n$blue/==================================================\\\\$clear"
                echo -e "$V_line $green                  [  Notice  ]                  $clear $V_line"
                echo -e "$V_line $green          **** Backup Successful! ****          $clear $V_line"
                echo -e "$blue\\==================================================/$clear"
            elif
                echo -e "\n$blue/==================================================\\\\$clear"
                echo -e "$V_line $red                  [  Warning  ]                 $clear $V_line"
                echo -e "$V_line $red            **** Backup failed! ****            $clear $V_line"
                echo -e "$blue\\==================================================/$clear"
            fi

        fi
    ;;

esac

