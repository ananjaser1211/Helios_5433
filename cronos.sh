#!/bin/bash
#
# Cronos Build Script V3.3
# For Exynos7870
# Coded by BlackMesa/AnanJaser1211 @2019
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software

# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Main Dir
CR_DIR=$(pwd)
# Define toolchan path
CR_TC=~/Android/Toolchains/linaro-4.9.4-arm-eabi/bin/arm-eabi-
# Define proper arch and dir for dts files
CR_DTS=arch/arm/boot/dts
# Define boot.img out dir
CR_OUT=$CR_DIR/Helios/Out
# Presistant A.I.K Location
CR_AIK=$CR_DIR/Helios/AIK-Linux
# Compiled image name and location (Image/zImage)
CR_KERNEL=$CR_DIR/arch/arm/boot/zImage
# Compiled dtb by dtbtool
CR_DTB=$CR_DIR/boot.img-dtb
# Kernel Ramdisk/split-img
CR_RAMDISK_MAIN=$CR_DIR/Helios/Ramdisk
# Kernel Name and Version
CR_VERSION=V3.0
CR_NAME=Helios_Kernel
# Thread count
CR_JOBS=$((`nproc`-1))
# Target android version and platform (7/n/8/o)
CR_ANDROID=7
CR_PLATFORM=7.0.0
# Target ARCH
CR_ARCH=arm
# Current Date
CR_DATE=$(date +%Y%m%d)
# Init build
export CROSS_COMPILE=$CR_TC
# General init
export ANDROID_MAJOR_VERSION=$CR_ANDROID
export PLATFORM_VERSION=$CR_PLATFORM
export $CR_ARCH
##########################################
# Device specific Variables [SM-N910C/H]
CR_DTSFILES_N910CH="exynos5433-tre_eur_open_07.dtb exynos5433-tre_eur_open_08.dtb exynos5433-tre_eur_open_09.dtb exynos5433-tre_eur_open_10.dtb exynos5433-tre_eur_open_12.dtb exynos5433-tre_eur_open_13.dtb exynos5433-tre_eur_open_14.dtb exynos5433-tre_eur_open_16.dtb"
CR_CONFG_N910CH=trelte_defconfig
CR_VARIANT_N910CH=N910C.H
CR_RAMDISK_N910CH=$CR_DIR/Helios/Device-specific/N910C
# Device specific Variables [SM-N910U]
CR_DTSFILES_N910U="exynos5433-trlte_eur_open_00.dtb exynos5433-trlte_eur_open_09.dtb exynos5433-trlte_eur_open_10.dtb exynos5433-trlte_eur_open_11.dtb exynos5433-trlte_eur_open_12.dtb"
CR_CONFG_N910U=trhplte_defconfig
CR_VARIANT_N910U=N910U
CR_RAMDISK_N910U=$CR_DIR/Helios/Device-specific/N910U
# Device specific Variables [SM-N910S/L/K]
CR_DTSFILES_N910SLK="exynos5433-trelte_kor_open_06.dtb exynos5433-trelte_kor_open_07.dtb exynos5433-trelte_kor_open_09.dtb exynos5433-trelte_kor_open_11.dtb exynos5433-trelte_kor_open_12.dtb"
CR_CONFG_N910SLK=trelteskt_defconfig
CR_VARIANT_N910SLK=N910S.L.K
CR_RAMDISK_N910SLK=$CR_DIR/Helios/Device-specific/N910S
# Device specific Variables [SM-N915S/L/K]
CR_DTSFILES_N915SLK="exynos5433-tbelte_kor_open_07.dtb exynos5433-tbelte_kor_open_09.dtb exynos5433-tbelte_kor_open_11.dtb exynos5433-tbelte_kor_open_12.dtb exynos5433-tbelte_kor_open_14.dtb"
CR_CONFG_N915SLK=tbelteskt_defconfig
CR_VARIANT_N915SLK=N915S.L.K
CR_RAMDISK_N915SLK=$CR_DIR/Helios/Device-specific/N915S
# Device specific Variables [SM-N916S/L/K]
CR_DTSFILES_N916SLK="exynos5433-tre3calte_kor_open_05.dtb exynos5433-tre3calte_kor_open_14.dtb"
CR_CONFG_N916SLK=tre3caltelgt_defconfig
CR_VARIANT_N916SLK=N916S.L.K
CR_RAMDISK_N916SLK=$CR_DIR/Helios/Device-specific/N916S
##########################################

# Script functions

read -p "Clean source (y/n) > " yn
if [ "$yn" = "Y" -o "$yn" = "y" ]; then
     echo "Clean Build"
     make clean && make mrproper
     rm -r -f $CR_DTB
     rm -rf $CR_DTS/.*.tmp
     rm -rf $CR_DTS/.*.cmd
     rm -rf $CR_DTS/*.dtb
     rm -rf $CR_DIR/.config
     rm -rf $CR_OUT/*.img
else
     echo "Dirty Build"
     rm -r -f $CR_DTB
     rm -rf $CR_DTS/.*.tmp
     rm -rf $CR_DTS/.*.cmd
     rm -rf $CR_DTS/*.dtb
fi

BUILD_IMAGE_NAME()
{
	CR_IMAGE_NAME=$CR_NAME-$CR_VERSION-$CR_VARIANT-$CR_DATE
}

BUILD_ZIMAGE()
{
	echo "----------------------------------------------"
	echo " "
	echo "Building zImage for $CR_VARIANT"
	export LOCALVERSION=-$CR_IMAGE_NAME
	echo "Make $CR_CONFG"
	make  $CR_CONFG
	make -j$CR_JOBS
	if [ ! -e $CR_KERNEL ]; then
	exit 0;
	echo "Image Failed to Compile"
	echo " Abort "
	fi
	du -k "$CR_KERNEL" | cut -f1 >sizT
	sizT=$(head -n 1 sizT)
	rm -rf sizT
	echo " "
	echo "----------------------------------------------"
}
BUILD_DTB()
{
	echo "----------------------------------------------"
	echo " "
	echo "Building DTB for $CR_VARIANT"
	# Dont use the DTS list provided in the build script.
	# This source compiles dtbs while doing Image
	#make  $CR_CONFG
	#make $CR_DTSFILES
	./tools/dtbtool -o ./boot.img-dtb -v -s 2048 -p ./scripts/dtc/ $CR_DTS/
	if [ ! -e $CR_DTB ]; then
	exit 0;
	echo "DTB Failed to Compile"
	echo " Abort "
	fi
	du -k "$CR_DTB" | cut -f1 >sizdT
	sizdT=$(head -n 1 sizdT)
	rm -rf sizdT
	rm -rf $CR_DTS/.*.tmp
	rm -rf $CR_DTS/.*.cmd
	rm -rf $CR_DTS/*.dtb
	echo " "
	echo "----------------------------------------------"
}
PACK_BOOT_IMG()
{
	echo "----------------------------------------------"
	echo " "
	echo "Building Boot.img for $CR_VARIANT"
	# General Ramdisk for all variants
	cp -rf $CR_RAMDISK_MAIN/* $CR_AIK
	# Device specific changes
	cp -rf $CR_RAMDISK_SUB/* $CR_AIK
	# To avoid any permission issues
	echo "Fix Ramdisk Permissions"
	cd $CR_RAMDISK_MAIN
	find -type d -exec chmod 755 {} \;
	find -type f -exec chmod 644 {} \;
	find -name "*.rc" -exec chmod 750 {} \;
	find -name "*.sh" -exec chmod 750 {} \;
	chmod -Rf 750 init sbin
	# Move Compiled kernel and dtb to A.I.K Folder
	mv $CR_KERNEL $CR_AIK/split_img/boot.img-zImage
	mv $CR_DTB $CR_AIK/split_img/boot.img-dtb
	# Create boot.img
	$CR_AIK/repackimg.sh
	# Remove red warning at boot
	echo -n "SEANDROIDENFORCE" » $CR_AIK/image-new.img
	# Move boot.img to out dir
	mv $CR_AIK/image-new.img $CR_OUT/$CR_IMAGE_NAME.img
	# Cleanup A.I.K Workspace
	du -k "$CR_OUT/$CR_IMAGE_NAME.img" | cut -f1 >sizkT
	sizkT=$(head -n 1 sizkT)
	rm -rf sizkT
	echo " "
	$CR_AIK/cleanup.sh
}

# Main Menu
PS3='Please select your option (1-6): '
menuvar=("SM-N910C-H" "SM-N910S-L-K" "SM-N910U" "SM-N915S" "SM-N916S" "Exit")
select menuvar in "${menuvar[@]}"
do
    case $menuvar in
        "SM-N910C-H")
            clear
            echo "Starting $CR_VARIANT_N910CH kernel build..."
            CR_VARIANT=$CR_VARIANT_N910CH
            CR_CONFG=$CR_CONFG_N910CH
            CR_DTSFILES=$CR_DTSFILES_N910CH
       	    CR_RAMDISK_SUB=$CR_RAMDISK_N910CH
       	    BUILD_IMAGE_NAME
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_BOOT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "$CR_VARIANT kernel build finished."
            echo "Compiled DTB Size = $sizdT Kb"
            echo "Kernel Image Size = $sizT Kb"
            echo "Boot Image   Size = $sizkT Kb"
            echo "$CR_OUT/$CR_IMAGE_NAME.img Ready"
            echo "Press Any key to end the script"
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "SM-N910S-L-K")
            clear
            echo "Starting $CR_VARIANT_N910SLK kernel build..."
            CR_VARIANT=$CR_VARIANT_N910SLK
       	    CR_CONFG=$CR_CONFG_N910SLK
            CR_DTSFILES=$CR_DTSFILES_N910SLK
       	    CR_RAMDISK_SUB=$CR_RAMDISK_N910SLK
       	    BUILD_IMAGE_NAME
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_BOOT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "$CR_VARIANT kernel build finished."
            echo "Compiled DTB Size = $sizdT Kb"
            echo "Kernel Image Size = $sizT Kb"
            echo "Boot Image   Size = $sizkT Kb"
            echo "$CR_OUT/$CR_IMAGE_NAME.img Ready"
            echo "Press Any key to end the script"
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "SM-N910U")
            clear
            echo "Starting $CR_VARIANT_N910U kernel build..."
            CR_VARIANT=$CR_VARIANT_N910U
       	    CR_CONFG=$CR_CONFG_N910U
            CR_DTSFILES=$CR_DTSFILES_N910U
       	    CR_RAMDISK_SUB=$CR_RAMDISK_N910U
       	    BUILD_IMAGE_NAME
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_BOOT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "$CR_VARIANT kernel build finished."
            echo "Compiled DTB Size = $sizdT Kb"
            echo "Kernel Image Size = $sizT Kb"
            echo "Boot Image   Size = $sizkT Kb"
            echo "$CR_OUT/$CR_IMAGE_NAME.img Ready"
            echo "Press Any key to end the script"
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "SM-N915S")
            clear
            echo "Starting $CR_VARIANT_N915SLK kernel build..."
            CR_VARIANT=$CR_VARIANT_N915SLK
       	    CR_CONFG=$CR_CONFG_N915SLK
            CR_DTSFILES=$CR_DTSFILES_N915SLK
       	    CR_RAMDISK_SUB=$CR_RAMDISK_N915SLK
       	    BUILD_IMAGE_NAME
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_BOOT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "$CR_VARIANT kernel build finished."
            echo "Compiled DTB Size = $sizdT Kb"
            echo "Kernel Image Size = $sizT Kb"
            echo "Boot Image   Size = $sizkT Kb"
            echo "$CR_OUT/$CR_IMAGE_NAME.img Ready"
            echo "Press Any key to end the script"
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "SM-N916S")
            clear
            echo "Starting $CR_VARIANT_N916SLK kernel build..."
            CR_VARIANT=$CR_VARIANT_N916SLK
       	    CR_CONFG=$CR_CONFG_N916SLK
            CR_DTSFILES=$CR_DTSFILES_N916SLK
       	    CR_RAMDISK_SUB=$CR_RAMDISK_N916SLK
       	    BUILD_IMAGE_NAME
            BUILD_ZIMAGE
            BUILD_DTB
            PACK_BOOT_IMG
            echo " "
            echo "----------------------------------------------"
            echo "$CR_VARIANT kernel build finished."
            echo "Compiled DTB Size = $sizdT Kb"
            echo "Kernel Image Size = $sizT Kb"
            echo "Boot Image   Size = $sizkT Kb"
            echo "$CR_OUT/$CR_IMAGE_NAME.img Ready"
            echo "Press Any key to end the script"
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;
        "Exit")
            break
            ;;
        *) echo Invalid option.;;
    esac
done
