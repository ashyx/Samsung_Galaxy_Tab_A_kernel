#!/bin/bash

#BUILD SCRIPT BY ASHYX

#SETUP BUILD ENVIROMENT
export ARCH=arm
export CROSS_COMPILE=/home/mark/Kernels/tool-chains/arm-cortex-linux-gnueabi-linaro_4.9.3-2015.03/bin/arm-eabi-

#MAKE DEFCONFIG
make  msm8916_sec_defconfig VARIANT_DEFCONFIG=msm8916_sec_gt510lte_eur_defconfig SELINUX_DEFCONFIG=selinux_defconfig
cp $(pwd)/arch/arm/configs/ashyx_gt510lte_defconfig $(pwd)/.config

#MAKE MENU CONFIG(REMOVE # TO ENABLE)
#make nconfig

#GET CPU COUNT
CORE_COUNT=`grep processor /proc/cpuinfo|wc -l`
make -j$CORE_COUNT

#BUILD DTB
tools/dtbTool -s 2048 -o arch/arm/boot/dt.img -p scripts/dtc/ arch/arm/boot/dts/
