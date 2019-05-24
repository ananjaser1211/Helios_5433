################################################################################
HOW TO BUILD KERNEL FOR SM-T710_EUR_NN_XX

1. How to Build
	- get Toolchain
		From android git server , codesourcery and etc ..
		- arm-linux-android-4.8
	- edit Makefile
		edit "CROSS_COMPILE" to right toolchain path(You downloaded).
		Ex)  cross-compile = /home/dpi/qb5_8814/workspace/P4_1716/android/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi    // You have to check.

	- make
		$ make ARCH=arm gts28wifi_03_defconfig
		$ make ARCH=arm

2. Output files
	- Kernel : arch/arm64/boot/Image
	- module : drivers/*/built-in.o

3. How to Clean	
		$ make clean
		$ make ARCH=arm distclean
################################################################################
