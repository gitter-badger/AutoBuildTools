#!/bin/bash

STM32_Programmer_CLI -l usb

if [[ $upload_mode == "factory" ]]; then
    cd $PATH_FACTORY_IMAGE
    echo -e "\n$purple Restore factory image via usb1? $red_flash(y/N)$clear \c"
    read update_YN

    if [[ $update_YN == "y" || $update_YN == "Y" ]]; then
        SD_or_eMMC=0
        echo -e "\n$purple Revert to SD card or eMMC? (Please Choose)"
        echo -e " $red_flash( 1:SD card / 2:eMMC )$clear \c"
        read SD_or_eMMC
        if [[ $SD_or_eMMC == 2 ]]; then
            echo -e "\n$green Restore factory image to eMMC...$clear\n"
            STM32_Programmer_CLI -c port=usb1 -w atk_emmc-stm32mp157d-atk-qt.tsv -tm 20000
        elif [[ $SD_or_eMMC == 1 ]]; then
            echo -e "\n$green Restore factory image to SD card...$clear\n"
            STM32_Programmer_CLI -c port=usb1 -w atk_sdcard-stm32mp157d-atk-qt.tsv -tm 20000
        else
            echo -e "\n$blue/==================================================\\\\$clear"
            echo -e "$V_line $yellow                  [ Warning ]                   $clear $V_line"
            echo -e "$V_line $yellow              **** No Choose! ****              $clear $V_line"
            echo -e "$blue\\==================================================/$clear"
        fi
    fi

    exit 0
fi

#------------------------------------------------------

if [ $linuxVersion == "5.4" ]; then
    cd $PATH_UPDATE/STlinux5.4
elif [ $linuxVersion == "5.10" ]; then
    cd $PATH_UPDATE/STlinux5.10
fi

if [[ $Type_Chose -eq 11 || $Type_Chose -eq 33 ]]; then

    echo -e "\n$purple Update the bootfs via usb1? $red_flash(y/N)$clear \c"
    read update_YN

    if [[ $update_YN == "y" || $update_YN == "Y" ]]; then
        SD_or_eMMC=0
        echo -e "\n$purple Revert to SD card or eMMC? (Please Choose)"
        echo -e " $red_flash( 1:SD card / 2:eMMC )$clear \c"
        read SD_or_eMMC

        if [[ $SD_or_eMMC == 2 ]]; then
            echo -e "\n$green Update rootfs image to eMMC...$clear\n"

            if [ $CoreBoardModel == "Atk" ]; then
                if [ $linuxVersion == "5.4" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_emmc_bootfs-stm32mp157d_STlinux5.4.tsv -tm 20000
                elif [ $linuxVersion == "5.10" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_emmc_bootfs-stm32mp157d_STlinux5.10.tsv -tm 20000
                fi
            elif [ $CoreBoardModel == "${CompanyLogo}" ]; then
                if [ $linuxVersion == "5.4" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_emmc_bootfs-stm32mp157d-sr_STlinux5.4.tsv -tm 20000
                elif [ $linuxVersion == "5.10" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_emmc_bootfs-stm32mp157d-sr_STlinux5.10.tsv -tm 20000
                fi
            fi
            
        elif [[ $SD_or_eMMC == 1 ]]; then
            echo -e "\n$green Update rootfs image to SD card...$clear\n"

            if [ $CoreBoardModel == "Atk" ]; then
                if [ $linuxVersion == "5.4" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_sdcard_bootfs-stm32mp157d_STlinux5.4.tsv -tm 20000
                elif [ $linuxVersion == "5.10" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_sdcard_bootfs-stm32mp157d_STlinux5.10.tsv -tm 20000
                fi
            elif [ $CoreBoardModel == "${CompanyLogo}" ]; then
                if [ $linuxVersion == "5.4" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_sdcard_bootfs-stm32mp157d-sr_STlinux5.4.tsv -tm 20000
                elif [ $linuxVersion == "5.10" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_sdcard_bootfs-stm32mp157d-sr_STlinux5.10.tsv -tm 20000
                fi
            fi
            
        else
            echo -e "\n$blue/==================================================\\\\$clear"
            echo -e "$V_line $yellow                  [ Warning ]                   $clear $V_line"
            echo -e "$V_line $yellow              **** No Choose! ****              $clear $V_line"
            echo -e "$blue\\==================================================/$clear"
        fi
    fi

elif [[ $Type_Chose -eq 22 || $Type_Chose -eq 44 ]]; then

    echo -e "\n$purple Update the rootfs via usb1? $red_flash(y/N)$clear \c"
    read update_YN

    if [[ $update_YN == "y" || $update_YN == "Y" ]]; then
        SD_or_eMMC=0
        echo -e "\n$purple Revert to SD card or eMMC? (Please Choose)"
        echo -e " $red_flash( 1:SD card / 2:eMMC )$clear \c"
        read SD_or_eMMC

        if [[ $SD_or_eMMC == 2 ]]; then
            echo -e "\n$green Update rootfs image to eMMC...$clear\n"

            if [ $CoreBoardModel == "Atk" ]; then
                if [ $linuxVersion == "5.4" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_emmc_rootfs-stm32mp157d_STlinux5.4.tsv -tm 20000
                elif [ $linuxVersion == "5.10" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_emmc_rootfs-stm32mp157d_STlinux5.10.tsv -tm 20000
                fi
            elif [ $CoreBoardModel == "${CompanyLogo}" ]; then
                if [ $linuxVersion == "5.4" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_emmc_rootfs-stm32mp157d-sr_STlinux5.4.tsv -tm 20000
                elif [ $linuxVersion == "5.10" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_emmc_rootfs-stm32mp157d-sr_STlinux5.10.tsv -tm 20000
                fi
            fi
            
        elif [[ $SD_or_eMMC == 1 ]]; then
            echo -e "\n$green Update rootfs image to SD card...$clear\n"

            if [ $CoreBoardModel == "Atk" ]; then
                if [ $linuxVersion == "5.4" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_sdcard_rootfs-stm32mp157d_STlinux5.4.tsv -tm 20000
                elif [ $linuxVersion == "5.10" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_sdcard_rootfs-stm32mp157d_STlinux5.10.tsv -tm 20000
                fi
            elif [ $CoreBoardModel == "${CompanyLogo}" ]; then
                if [ $linuxVersion == "5.4" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_sdcard_rootfs-stm32mp157d-sr_STlinux5.4.tsv -tm 20000
                elif [ $linuxVersion == "5.10" ]; then
                    STM32_Programmer_CLI -c port=usb1 -w ${CompanyLogo}_sdcard_rootfs-stm32mp157d-sr_STlinux5.10.tsv -tm 20000
                fi
            fi
            
        else
            echo -e "\n$blue/==================================================\\\\$clear"
            echo -e "$V_line $yellow                  [ Warning ]                   $clear $V_line"
            echo -e "$V_line $yellow              **** No Choose! ****              $clear $V_line"
            echo -e "$blue\\==================================================/$clear"
        fi
    fi
fi
