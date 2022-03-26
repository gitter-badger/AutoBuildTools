#!/bin/bash

if [ $linuxVersion == "5.4" ]; then
    case $Type_Chose in
        1)  cd $PATH_SOURCE_5_4_TF_A
        
            echo -e "\n$purple Compile TF-A firmware? $red_flash(y/N)$clear \c"
            read Compile_TF_A_YN
            if [[ $Compile_TF_A_YN == "y" || $Compile_TF_A_YN == "Y" ]]; then
                echo -e "\n$green -------------------- $clear\n"

                make -f ../Makefile.sdk clean 
                make -f ../Makefile.sdk TFA_DEVICETREE=stm32mp157d-${CompanyLogo} TF_A_CONFIG=serialboot ELF_DEBUG_ENABLE='1' all
                cp ../build/serialboot/tf-a-stm32mp157d-${CompanyLogo}-serialboot.stm32 $PATH_UPDATE/STlinux5.4/tf-a/
                sync
                
                make -f ../Makefile.sdk clean
                make -f ../Makefile.sdk TFA_DEVICETREE=stm32mp157d-${CompanyLogo}-sr TF_A_CONFIG=serialboot ELF_DEBUG_ENABLE='1' all
                cp ../build/serialboot/tf-a-stm32mp157d-${CompanyLogo}-sr-serialboot.stm32 $PATH_UPDATE/STlinux5.4/tf-a/
                make -f ../Makefile.sdk clean
                sync

                make -f ../Makefile.sdk all

                echo -e "\n$green **** Copy file... ****$clear\n"

                cp ../build/trusted/tf-a-stm32mp157d-${CompanyLogo}-trusted.stm32 $PATH_UPDATE/STlinux5.4/tf-a/
                cp ../build/trusted/tf-a-stm32mp157d-${CompanyLogo}-sr-trusted.stm32 $PATH_UPDATE/STlinux5.4/tf-a/

                sync

                echo -e "\n$green **** Build TF-A complete! ****$clear\n"
            fi
        ;;

        2)  cd $PATH_SOURCE_5_4_U_BOOT
            
            echo -e "\n$purple Compile u-boot firmware? $red_flash(y/N)$clear \c"
            read Compile_u_boot_YN
            if [[ $Compile_u_boot_YN == "y" || $Compile_u_boot_YN == "Y" ]]; then
                echo -e "\n$green -------------------- $clear\n"

                # make V=1 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- DEVICE_TREE=stm32mp157d-${CompanyLogo} all -j8
                make DEVICE_TREE=stm32mp157d-${CompanyLogo} all -j8
                
                #make DEVICE_TREE=stm32mp157d-${CompanyLogo} UBOOT_CONFIGS=stm32mp15_${CompanyLogo}_trusted_defconfig,trusted,u-boot.stm32 all

                echo -e "\n$green **** Copy file... ****$clear\n"

                # cp ./u-boot.stm32 $PATH_UPDATE/STlinux5.4/u-boot/
                cp ./u-boot.stm32 $PATH_UPDATE/STlinux5.4/u-boot/u-boot-stm32mp157d-${CompanyLogo}.stm32
                cp ./u-boot.stm32 $PATH_UPDATE/STlinux5.4/u-boot/u-boot-stm32mp157d-${CompanyLogo}-sr.stm32

                sync
                
                echo -e "\n$green **** Build u-boot complete! ****$clear\n"
            fi
        ;;

        3)  cd $PATH_SOURCE_5_4_KERNEL

            echo -e "\n$purple Compile kernel firmware? $red_flash(y/N)$clear \c"
            read Compile_kernel_YN
            
            if [[ $Compile_kernel_YN == "y" || $Compile_kernel_YN == "Y" ]]; then
                echo -e "\n$purple Install kernel driver modules? $red_flash(y/N)$clear \c"
                read ModuleInstall_YN

                echo -e "\n$green ------ make menuconfig ------ $clear\n"
                # make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- stm32mp157d_${CompanyLogo}_defconfig
                
                make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- menuconfig
                
                if [[ $ModuleInstall_YN == "y" || $ModuleInstall_YN == "Y" ]]; then
                    if [ -d "/media/$USERNAME/$MOUNT_DIR" ];then                                    # 判断文件夹是否存在;
                        echo -e "\n$green **** Compile module files... ****$clear\n"
                        make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- dtbs          # 重新编译设备树;
                        make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- modules -j12  # 编译驱动模块;

                        echo -e "\n$green **** Modules install... ****$clear\n"
                        sudo make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- modules_install INSTALL_MOD_PATH=/media/$USERNAME/$MOUNT_DIR   # 安装模块;
                    else    # 文件夹不存在;
                        echo -e "\n$blue/==================================================\\\\$clear"
                        echo -e "$V_line $yellow                  [ Warning ]                   $clear $V_line"
                        echo -e "$V_line $yellow         **** No sd card inserted! ****         $clear $V_line"
                        echo -e "$blue\\==================================================/$clear"
                        exit 0
                    fi
                fi

                echo -e "\n$green **** Compile kernel... ****$clear\n"
                make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- DEVICE_TREE=stm32mp157d-${CompanyLogo} uImage dtbs LOADADDR=0XC2000040 -j16

                echo -e "\n$green **** Copy file... ****$clear\n"

                cp $PWD/arch/arm/boot/uImage $PATH_UPDATE/tftpboot/
                cp $PWD/arch/arm/boot/dts/stm32mp157d-${CompanyLogo}.dtb $PATH_UPDATE/tftpboot/

                cp $PWD/arch/arm/boot/uImage $PATH_UPDATE/STlinux5.4/bootfs/
                cp $PWD/arch/arm/boot/dts/stm32mp157d-${CompanyLogo}.dtb $PATH_UPDATE/STlinux5.4/bootfs/

                echo -e "\n$green **** Packing bootfs... ****$clear\n"

                cd $PATH_UPDATE/STlinux5.4/bootfs/
                dd if=/dev/zero of=bootfs.ext4 bs=1M count=20
                mkfs.ext4 -L bootfs bootfs.ext4

                sudo mount bootfs.ext4 /mnt/bootfs/
                sudo cp uImage stm32mp157d-${CompanyLogo}.dtb /mnt/bootfs/
                sudo umount /mnt/bootfs
                mv bootfs.ext4 $PATH_UPDATE/STlinux5.4/${CompanyLogo}-image-bootfs.ext4
                
                sync

                echo -e "\n$blue/==================================================\\\\$clear"
                echo -e "$V_line $yellow                  [  Notice  ]                  $clear $V_line"
                echo -e "$V_line $yellow        **** Build kernel complete! ****        $clear $V_line"
                echo -e "$blue\\==================================================/$clear"
            fi
        ;;

        4)  cd $PATH_SOURCE_5_4_BUSYBOX

            echo -e "\n Compile busybox firmware? (y/N) \c"
            read Compile_busybox_YN
            if [[ $Compile_busybox_YN == "y" || $Compile_busybox_YN == "Y" ]]; then
                echo -e "\n$green -------------------- $clear\n"

                make 

                echo -e "\n$green **** Copy file... ****$clear\n"

                cp $PWD/arch/arm/boot/uImage $PATH_UPDATE/tftpboot/
                cp $PWD/arch/arm/boot/dts/stm32mp157d-${CompanyLogo}.dtb $PATH_UPDATE/tftpboot/

                cp $PWD/arch/arm/boot/uImage $PATH_UPDATE/STlinux5.4/bootfs/
                cp $PWD/arch/arm/boot/dts/stm32mp157d-${CompanyLogo}.dtb $PATH_UPDATE/STlinux5.4/bootfs/

                echo -e "\n$green **** Build busybox complete! ****$clear\n"
            fi
        ;;
    esac
elif [ $linuxVersion == "5.10" ]; then
    case $Type_Chose in
        1)  cd $PATH_SOURCE_5_10_TF_A
        
            echo -e "\n Compile TF-A firmware? (y/N) \c"
            read Compile_TF_A_YN
            if [[ $Compile_TF_A_YN == "y" || $Compile_TF_A_YN == "Y" ]]; then
                echo -e "\n$green -------------------- $clear\n"

                export FIP_DEPLOYDIR_ROOT=$PWD/../../FIP_artifacts
                make -f $PWD/../Makefile.sdk all
                # make -f $PWD/../Makefile.sdk TFA_DEVICETREE=stm32mp157a-dk1 TF_A_CONFIG=trusted ELF_DEBUG_ENABLE='1' all

                echo -e "\n$green **** Copy file... ****$clear\n"

                cp ../../FIP_artifacts/fip/fip-stm32mp157d-${CompanyLogo}-trusted.bin ~/STM32MP157/install
                cp ../build/usb/tf-a-stm32mp157d-${CompanyLogo}.stm32 ~/STM32MP157/install/tf-a-stm32mp157d-${CompanyLogo}-usb.stm32
                
                cp ../build/emmc/tf-a-stm32mp157d-${CompanyLogo}.stm32 ~/STM32MP157/install/tf-a-stm32mp157d-${CompanyLogo}-emmc.stm32
                cp ../build/sdcard/tf-a-stm32mp157d-${CompanyLogo}.stm32 ~/STM32MP157/install/tf-a-stm32mp157d-${CompanyLogo}-sdcard.stm32
 
                echo -e "\n$green **** Build TF-A complete! ****$clear\n"
            fi
        ;;

        2)  cd $PATH_SOURCE_5_10_U_BOOT
            
            echo -e "\n$green Compile u-boot firmware? (y/N) \c"
            read Compile_u_boot_YN
            if [[ $Compile_u_boot_YN == "y" || $Compile_u_boot_YN == "Y" ]]; then
                echo -e "\n$green -------------------- $clear\n"

                export FIP_DEPLOYDIR_ROOT=$PWD/../../FIP_artifacts
                #make -f $PWD/../Makefile.sdk all
                # make -f $PWD/../Makefile.sdk all UBOOT_CONFIG=trusted UBOOT_DEFCONFIG=stm32mp15_trusted_defconfig UBOOT_BINARY=u-boot.dtb DEVICETREE=stm32mp157d-ev1
                
                make stm32mp15_${CompanyLogo}_trusted_defconfig
                make DEVICE_TREE=stm32mp157d-${CompanyLogo} UBOOT_CONFIGS=stm32mp15_${CompanyLogo}_trusted_defconfig,trusted,u-boot.stm32 all

                echo -e "\n **** Copy file... ****\n"

                cp ../../FIP_artifacts/fip/fip-stm32mp157d-${CompanyLogo}-trusted.bin ~/STM32MP157/install/u-boot-stm32mp157d-${CompanyLogo}-trusted.bin
                echo -e "\n **** Build u-boot complete! ****\n"
            fi
        ;;

        3)  cd $PATH_SOURCE_5_10_KERNEL

            echo -e "\n Compile kernel firmware? (y/N) \c"
            read Compile_kernel_YN
            if [[ $Compile_kernel_YN == "y" || $Compile_kernel_YN == "Y" ]]; then
                echo -e "\n$green -------------------- $clear\n"

                make ARCH=arm uImage vmlinux dtbs LOADADDR=0xC2000040 O="$PWD/../build"
                make ARCH=arm modules O="$PWD/../build"
                make ARCH=arm INSTALL_MOD_PATH="$PWD/../build/install_artifact" modules_install O="$PWD/../build"
                mkdir -p $PWD/../build/install_artifact/boot/

                echo -e "\n **** Copy file... ****\n"

                cp $PWD/../build/arch/arm/boot/uImage $PWD/../build/install_artifact/boot/
                cp $PWD/../build/arch/arm/boot/dts/st*.dtb $PWD/../build/install_artifact/boot/

                echo -e "\n **** Build kernel complete! ****\n"
            fi
        ;;
    esac
fi

