#!/bin/bash

if [ $linuxVersion == "5.4" ]; then
    case $Type_Chose in
        5)  cd $PATH_SOURCE_5_4_TF_A

            echo -e "\n Clean the TF-A? (y/N) \c"
            read Clean_TF_A_YN
            if [[ $Clean_TF_A_YN = "y" || $Clean_TF_A_YN = "Y" ]]
            then
                make -f $PWD/../Makefile.sdk clean
                echo -e "\n **** Clean TF-A complete! ****\n"
            fi
        ;;

        6)  cd $PATH_SOURCE_5_4_U_BOOT

            echo -e "\n Clean the u-boot? (y/N) \c"
            read Clean_u_boot_YN
            if [[ $Clean_u_boot_YN = "y" || $Clean_u_boot_YN = "Y" ]]
            then

                make distclean
                make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- stm32mp157d_${CompanyLogo}_defconfig
                
                echo -e "\n **** Clean u-boot complete! ****\n"
            fi
        ;;

        7)  cd $PATH_SOURCE_5_4_KERNEL

            echo -e "\n Clean the kernel? (y/N) \c"
            read Clean_kernel_YN
            if [[ $Clean_kernel_YN = "y" || $Clean_kernel_YN = "Y" ]]
            then

                make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- distclean
                make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabihf- stm32mp157d_${CompanyLogo}_defconfig

                echo -e "\n **** Clean kernel complete! ****\n"
            fi
        ;;
    esac
elif [ $linuxVersion == "5.10" ]; then
    case $Type_Chose in
        5)  cd $PATH_SOURCE_5_10_TF_A

            echo -e "\n Clean the TF-A? (y/N) \c"
            read Clean_TF_A_YN
            if [[ $Clean_TF_A_YN = "y" || $Clean_TF_A_YN = "Y" ]]
            then
                export FIP_DEPLOYDIR_ROOT=$PWD/../../FIP_artifacts
                make -f $PWD/../Makefile.sdk clean
                echo -e "\n **** Clean TF-A complete! ****\n"
            fi
        ;;

        6)  cd $PATH_SOURCE_5_10_U_BOOT

            echo -e "\n Clean the u-boot? (y/N) \c"
            read Clean_u_boot_YN
            if [[ $Clean_u_boot_YN = "y" || $Clean_u_boot_YN = "Y" ]]
            then
                export FIP_DEPLOYDIR_ROOT=$PWD/../../FIP_artifacts
                make -f $PWD/../Makefile.sdk clean
                echo -e "\n **** Clean u-boot complete! ****\n"
            fi
        ;;

        7)  cd $PATH_SOURCE_5_10_KERNEL

            echo -e "\n Clean the kernel? (y/N) \c"
            read Clean_kernel_YN
            if [[ $Clean_kernel_YN = "y" || $Clean_kernel_YN = "Y" ]]
            then
                echo -e "\n **** Clean kernel complete! ****\n"
            fi
        ;;
    esac
fi


