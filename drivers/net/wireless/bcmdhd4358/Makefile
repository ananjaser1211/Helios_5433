# bcmdhd
#####################
# Basic feature
#####################

DHDCFLAGS += -Wall -Wstrict-prototypes -Dlinux -DLINUX -DBCMDRIVER      \
        -DBCMDONGLEHOST -DUNRELEASEDCHIP -DBCMDMA32 -DBCMFILEIMAGE      \
        -DDHDTHREAD -DDHD_BCMEVENTS -DSHOW_EVENTS -DBCMDBG -DWLP2P      \
        -DWIFI_ACT_FRAME -DARP_OFFLOAD_SUPPORT -DKEEP_ALIVE -DCSCAN     \
        -DPKT_FILTER_SUPPORT -DEMBEDDED_PLATFORM -DPNO_SUPPORT

#####################
# Bus Interface Type
#####################
ifneq ($(CONFIG_BCMDHD_PCIE),)
	BUS_IFACE_PCIE=y
else
	BUS_IFACE_SDIO=y
endif

#####################
# SDIO I/F
#####################
ifeq ($(BUS_IFACE_SDIO),y)
	DHDCFLAGS += -DBDC -DOOB_INTR_ONLY -DDHD_BCMEVENTS -DMMC_SDIO_ABORT
	DHDCFLAGS += -DBCMSDIO -DBCMLXSDMMC -DUSE_SDIOFIFO_IOVAR
	DHDCFLAGS += -U__ARM_ARCH_7A__
	# DPC priority
	DHDCFLAGS += -DCUSTOM_DPC_PRIO_SETTING=98
	# idle count
	DHDCFLAGS += -DDHD_USE_IDLECOUNT
	# SKB TAILPAD to avoid out of boundary memory access
	DHDCFLAGS += -DDHDENABLE_TAILPAD
	# Enable PROP_TXSTATUS
	DHDCFLAGS += -DPROP_TXSTATUS
	DHDCFLAGS += -DSUPPORT_P2P_GO_PS
endif

#####################
# PCIE I/F
#####################
ifeq ($(BUS_IFACE_PCIE),y)
	DHDCFLAGS += -DPCIE_FULL_DONGLE -DBCMPCIE
	# DPC priority
	DHDCFLAGS += -DCUSTOM_DPC_PRIO_SETTING=-1
	# Disable watchdog thread
	DHDCFLAGS += -DCUSTOM_DHD_WATCHDOG_MS=0
	# Enable Link down recovery
	DHDCFLAGS += -DSUPPORT_LINKDOWN_RECOVERY
#ifeq ($(CONFIG_BCMDHD_DEBUG_PAGEALLOC),y)
	# Debugging Pagealloc
#	DHDCFLAGS += -DDHD_DEBUG_PAGEALLOC
#endif
	# Enable packet audit at host side
	DHDCFLAGS += -DDHD_PKTID_AUDIT_ENABLED
	# Extended HANG event with reason codes
	DHDCFALGS += -DDHD_USE_EXTENDED_HANG_REASON

endif



#################
# Common feature
#################

DHDCFLAGS += -DCUSTOMER_HW4
DHDCFLAGS += -DWL_CFG80211

# Debug
DHDCFLAGS += -DSIMPLE_MAC_PRINT
DHDCFLAGS += -DDEBUGFS_CFG80211
# Enable wakelock debug function
DHDCFLAGS += -DDHD_TRACE_WAKE_LOCK
# Print out kernel panic point of file and line info when assertion happened
DHDCFLAGS += -DBCMASSERT_LOG
# Collect Current Assoc/Reject Status for Big Data logging
DHDCFLAGS += -DDHD_ENABLE_BIGDATA_LOGGING

# Print 8021X
DHDCFLAGS += -DDHD_8021X_DUMP

# Print DHCP
DHDCFLAGS += -DDHD_DHCP_DUMP

# VSDB
DHDCFLAGS += -DVSDB

# Wi-Fi Direct
DHDCFLAGS += -DWL_CFG80211_VSDB_PRIORITIZE_SCAN_REQUEST
# For p2p connection issue
DHDCFLAGS += -DWL_SCB_TIMEOUT=10
# For TDLS tear down inactive time 10 sec
DHDCFLAGS += -DCUSTOM_TDLS_IDLE_MODE_SETTING=10000
# for TDLS RSSI HIGH for establishing TDLS link
DHDCFLAGS += -DCUSTOM_TDLS_RSSI_THRESHOLD_HIGH=-80
# for TDLS RSSI HIGH for tearing down TDLS link
DHDCFLAGS += -DCUSTOM_TDLS_RSSI_THRESHOLD_LOW=-85

# Roaming
DHDCFLAGS += -DROAM_AP_ENV_DETECTION
DHDCFLAGS += -DROAM_ENABLE -DROAM_CHANNEL_CACHE -DROAM_API
DHDCFLAGS += -DENABLE_FW_ROAM_SUSPEND
DHDCFLAGS += -DDHD_LOSSLESS_ROAMING

# Enable Roam time thresh
DHDCFLAGS += -DENABLE_MAX_DTIM_IN_SUSPEND
DHDCFLAGS += -DCUSTOM_BCN_TIMEOUT_IN_SUSPEND=10
DHDCFLAGS += -DCUSTOM_ROAM_TIME_THRESH_IN_SUSPEND=6000
DHDCFLAGS += -DMAX_DTIM_ALLOWED_INTERVAL=925

# CCX
ifeq ($(CONFIG_BRCM_CCX),y)
  DHDCFLAGS += -DBCMCCX
endif

# SoftAP
DHDCFLAGS += -DWL_SUPPORT_AUTO_CHANNEL -DSUPPORT_HIDDEN_AP
DHDCFLAGS += -DSUPPORT_SOFTAP_SINGL_DISASSOC
DHDCFLAGS += -DDISABLE_11H_SOFTAP

# HW4 specific features
DHDCFLAGS += -DSUPPORT_PM2_ONLY
DHDCFLAGS += -DSUPPORT_DEEP_SLEEP
DHDCFLAGS += -DSUPPORT_AMPDU_MPDU_CMD
DHDCFLAGS += -DSOFTAP_SEND_HANGEVT
DHDCFLAGS += -DTDLS_MSG_ONLY_WFD
DHDCFLAGS += -DSKIP_WLFC_ON_CONCURRENT
DHDCFLAGS += -DCUSTOM_EVENT_PM_WAKE=20
DHDCFLAGS += -DCUSTOM_KEEP_ALIVE_SETTING=30000

# For special PNO Event keep wake lock for 10sec
DHDCFLAGS += -DCUSTOM_PNO_EVENT_LOCK_xTIME=10

# For Passing all multicast packets to host when not in suspend mode.
# DHDCFLAGS += -DPASS_ALL_MCAST_PKTS

# Early suspend
DHDCFLAGS += -DDHD_USE_EARLYSUSPEND

# WiFi turn off delay
DHDCFLAGS += -DWIFI_TURNOFF_DELAY=100

# For Scan result patch
DHDCFLAGS += -DESCAN_RESULT_PATCH
DHDCFLAGS += -DDUAL_ESCAN_RESULT_BUFFER
DHDCFLAGS += -DESCAN_BUF_OVERFLOW_MGMT

# For Static Buffer
ifeq ($(CONFIG_BROADCOM_WIFI_RESERVED_MEM),y)
  DHDCFLAGS += -DCONFIG_DHD_USE_STATIC_BUF
  DHDCFLAGS += -DENHANCED_STATIC_BUF
  DHDCFLAGS += -DSTATIC_WL_PRIV_STRUCT
ifeq ($(BUS_IFACE_PCIE),y)
  # Use preallocated IOCTL and EVENT buffer
  DHDCFLAGS += -DDHD_USE_STATIC_CTRLBUF
endif
ifeq ($(CONFIG_BCMDHD_PREALLOC_MEMDUMP),y)
  DHDCFLAGS += -DDHD_USE_STATIC_MEMDUMP
endif
endif

# Ioctl timeout 10000ms
DHDCFLAGS += -DIOCTL_RESP_TIMEOUT=10000

# Priority mismatch fix with kernel stack
DHDCFLAGS += -DPKTPRIO_OVERRIDE

# Prevent rx thread monopolize
DHDCFLAGS += -DWAIT_DEQUEUE

# Config PM Control
DHDCFLAGS += -DCONFIG_CONTROL_PM

# Use Android wake lock mechanism
DHDCFLAGS += -DCONFIG_HAS_WAKELOCK

# Used short dwell time during initial scan
DHDCFLAGS += -DUSE_INITIAL_SHORT_DWELL_TIME

# Korea and Japan ccode revision will be fixed by nvram's value
DHDCFLAGS += -DKEEP_KR_REGREV
DHDCFLAGS += -DKEEP_JP_REGREV

# NAN feature
ifeq ($(CONFIG_WL_NAN),y)
DHDCFLAGS += -DWL_NAN
endif

# FCC power limit control on ch12/13.
DHDCFLAGS += -DFCC_PWR_LIMIT_2G

# WFA Certification feature
DHDCFLAGS += -DUSE_WFA_CERT_CONF

##############################
# Android Platform Definition
##############################

###########
# Lollipop
###########
# Definitions are filtered by Kernel version
DHDCFLAGS += -DWL_ENABLE_P2P_IF
DHDCFLAGS += -DWL_SUPPORT_BACKPORTED_KPATCHES
# Default definitions for KitKat, Lollipop
DHDCFLAGS += -DWL_CFG80211_STA_EVENT
DHDCFLAGS += -DWL_IFACE_COMB_NUM_CHANNELS
# To support p2p private command on kernel 3.8 or above
DHDCFLAGS += -DWL_NEWCFG_PRIVCMD_SUPPORT
# Link Statistics feature
DHDCFLAGS += -DLINKSTAT_SUPPORT

# To support GSCAN
DHDCFLAGS += -DGSCAN_SUPPORT

# To support RTT
DHDCFLAGS += -DRTT_SUPPORT

# To support WL_VENDOR_EXT_SUPPORT
DHDCFLAGS += -DWL_VENDOR_EXT_SUPPORT

# Extra file list for Lollipop
DHD_ANDROID_OFILES := wl_cfgvendor.o dhd_rtt.o

# GN4 platform still disabled Lollipop features
ifeq ($(filter y,$(CONFIG_MACH_UNIVERSAL5433) $(CONFIG_ARCH_APQ8084)),y)
DHD_ANDROID_OFILES :=$(filter-out wl_cfgvendor.o dhd_rtt.o,$(DHD_ANDROID_OFILES))
DHDCFLAGS :=$(filter-out -DLINKSTAT_SUPPORT,$(DHDCFLAGS))
DHDCFLAGS :=$(filter-out -DGSCAN_SUPPORT,$(DHDCFLAGS))
DHDCFLAGS :=$(filter-out -DRTT_SUPPORT,$(DHDCFLAGS))
DHDCFLAGS :=$(filter-out -DWL_VENDOR_EXT_SUPPORT,$(DHDCFLAGS))
endif




##########################
# driver type
# m: module type driver
# y: built-in type driver
##########################
DRIVER_TYPE ?= m

#########################
# Chip dependent feature
#########################
# Chipsets supported both SDIO and PCIE
ifneq ($(CONFIG_BCM4358),)
  DHDCFLAGS += -DBCM4358_CHIP -DSUPPORT_MULTIPLE_REVISION
  DHDCFLAGS += -DMIMO_ANT_SETTING
  DHDCFLAGS += -DUSE_CID_CHECK
  DHDCFLAGS += -DENABLE_BCN_LI_BCN_WAKEUP
  DHDCFLAGS += -DDHD_DONOT_FORWARD_BCMEVENT_AS_NETWORK_PKT
  DHDCFLAGS += -DCUSTOM_BCN_TIMEOUT=6
  DHDCFLAGS += -DSOFTAP_UAPSD_OFF
# tput enhancement for common
  DHDCFLAGS += -DUSE_WL_TXBF
  DHDCFLAGS += -DUSE_WL_FRAMEBURST
  DHDCFLAGS += -DDISABLE_FRAMEBURST_VSDB
  DHDCFLAGS += -DDISABLE_PM_BCNRX

# tput enhancement for SDIO
ifeq ($(BUS_IFACE_SDIO),y)
  DHDCFLAGS += -DHW_OOB
  DHDCFLAGS += -DCUSTOM_GLOM_SETTING=8 -DCUSTOM_RXCHAIN=1
  DHDCFLAGS += -DUSE_DYNAMIC_F2_BLKSIZE -DDYNAMIC_F2_BLKSIZE_FOR_NONLEGACY=128
  DHDCFLAGS += -DBCMSDIOH_TXGLOM -DCUSTOM_TXGLOM=1 -DBCMSDIOH_TXGLOM_HIGHSPEED
  DHDCFLAGS += -DRXFRAME_THREAD
  DHDCFLAGS += -DCUSTOM_AMPDU_BA_WSIZE=64 -DCUSTOM_IBSS_AMPDU_BA_WSIZE=16
  DHDCFLAGS += -DCUSTOM_DPC_CPUCORE=0
  DHDCFLAGS += -DCUSTOM_DEF_TXGLOM_SIZE=40 -DDHD_TXBOUND=40
  DHDCFLAGS += -DENABLE_ADAPTIVE_SCHED -DCUSTOM_CPUFREQ_THRESH=1000000
  DHDCFLAGS += -DCUSTOM_MAX_TXGLOM_SIZE=40
  DHDCFLAGS += -DMAX_HDR_READ=128
  DHDCFLAGS += -DDHD_FIRSTREAD=128
  DHDCFLAGS += -DCUSTOM_AMPDU_MPDU=16
  DHDCFLAGS += -DDHDTCPACK_SUPPRESS
  DHDCFLAGS += -DPROP_TXSTATUS_VSDB
endif

# tput enhancement for PCIE
ifeq ($(BUS_IFACE_PCIE),y)
  DHDCFLAGS += -DCUSTOM_AMPDU_BA_WSIZE=64 -DCUSTOM_IBSS_AMPDU_BA_WSIZE=16
  DHDCFLAGS += -DCUSTOM_AMPDU_MPDU=32
  DHDCFLAGS += -DCUSTOM_AMPDU_RELEASE=16
  DHDCFLAGS += -DCUSTOM_AMSDU_AGGSF=4
  DHDCFLAGS += -DCUSTOM_TCPACK_SUPP_RATIO=15
  DHDCFLAGS += -DCUSTOM_TCPACK_DELAY_TIME=10
  DHDCFLAGS += -DDHDTCPACK_SUPPRESS
endif

# Disabled DHDTCPACK_SUPPRESS for T Project / Enabled for Zero Project
ifeq ($(CONFIG_ARCH_APQ8084)),y)
  DHDCFLAGS :=$(filter-out -DDHDTCPACK_SUPPRESS,$(DHDCFLAGS))
# For enable temperature throttling feature at BCM4358A3
#  DHDCFLAGS += -DENABLE_TEMP_THROTTLING
endif

ifeq ($(CONFIG_ARCH_MSM),y)
  DHDCFLAGS += -DSET_RPS_CPUS
endif

# New Features
  DHDCFLAGS += -DWL11U -DMFP
  DHDCFLAGS += -DBCMCCX
  DHDCFLAGS += -DWES_SUPPORT
  DHDCFLAGS += -DOKC_SUPPORT
  DHDCFLAGS += -DWLTDLS
  DHDCFLAGS += -DWLFBT
  DHDCFLAGS += -DDHD_ENABLE_LPC
  DHDCFLAGS += -DWLAIBSS -DWLAIBSS_PS
  DHDCFLAGS += -DSUPPORT_LTECX
  DHDCFLAGS += -DSUPPORT_2G_VHT
  DHDCFLAGS += -DSUPPORT_WL_TXPOWER
  DHDCFLAGS += -DDHD_LOG_DUMP
ifeq ($(CONFIG_BCM4358),y)
  DHDCFLAGS += -DENABLE_INSMOD_NO_FW_LOAD
  DHDCFLAGS += -DUSE_LATE_INITCALL_SYNC
  DHDCFLAGS += -fno-pic
  DRIVER_TYPE = y
endif
ifeq ($(CONFIG_BCM4358),m)
ifeq ($(CONFIG_64BIT),y)
  DHDCFLAGS += -fno-pic
endif
endif
ifeq ($(BUS_IFACE_SDIO),y)
  DHDCFLAGS += -DCUSTOM_PSPRETEND_THR=30
endif
endif

ifneq ($(CONFIG_BCM4354),)
  DHDCFLAGS += -DBCM4354_CHIP -DSUPPORT_MULTIPLE_REVISION
  DHDCFLAGS += -DMIMO_ANT_SETTING
  DHDCFLAGS += -DUSE_CID_CHECK
  DHDCFLAGS += -DENABLE_BCN_LI_BCN_WAKEUP
  DHDCFLAGS += -DSOFTAP_UAPSD_OFF

# tput enhancement for common
  DHDCFLAGS += -DUSE_WL_TXBF
  DHDCFLAGS += -DUSE_WL_FRAMEBURST

# tput enhancement for SDIO
ifeq ($(BUS_IFACE_SDIO),y)
  DHDCFLAGS += -DHW_OOB
  DHDCFLAGS += -DCUSTOM_GLOM_SETTING=8 -DCUSTOM_RXCHAIN=1
  DHDCFLAGS += -DUSE_DYNAMIC_F2_BLKSIZE -DDYNAMIC_F2_BLKSIZE_FOR_NONLEGACY=128
  DHDCFLAGS += -DBCMSDIOH_TXGLOM -DCUSTOM_TXGLOM=1 -DBCMSDIOH_TXGLOM_HIGHSPEED
  DHDCFLAGS += -DRXFRAME_THREAD
  DHDCFLAGS += -DCUSTOM_AMPDU_BA_WSIZE=64 -DCUSTOM_IBSS_AMPDU_BA_WSIZE=16
  DHDCFLAGS += -DCUSTOM_DPC_CPUCORE=0
  DHDCFLAGS += -DCUSTOM_DEF_TXGLOM_SIZE=40 -DDHD_TXBOUND=40
  DHDCFLAGS += -DENABLE_ADAPTIVE_SCHED -DCUSTOM_CPUFREQ_THRESH=1000000
  DHDCFLAGS += -DCUSTOM_MAX_TXGLOM_SIZE=40
  DHDCFLAGS += -DMAX_HDR_READ=128
  DHDCFLAGS += -DDHD_FIRSTREAD=128
  DHDCFLAGS += -DCUSTOM_AMPDU_MPDU=16
  DHDCFLAGS += -DDHDTCPACK_SUPPRESS
  DHDCFLAGS += -DPROP_TXSTATUS_VSDB
endif

# tput enhancement for PCIE
ifeq ($(BUS_IFACE_PCIE),y)
  DHDCFLAGS += -DCUSTOM_AMPDU_BA_WSIZE=64 -DCUSTOM_IBSS_AMPDU_BA_WSIZE=16
  DHDCFLAGS += -DCUSTOM_AMPDU_MPDU=32
  DHDCFLAGS += -DCUSTOM_AMPDU_RELEASE=16
endif


# New Features
  DHDCFLAGS += -DWL11U -DMFP
  DHDCFLAGS += -DBCMCCX
  DHDCFLAGS += -DWES_SUPPORT
  DHDCFLAGS += -DOKC_SUPPORT
  DHDCFLAGS += -DWLTDLS
  DHDCFLAGS += -DWLFBT
  DHDCFLAGS += -DDHD_ENABLE_LPC
  DHDCFLAGS += -DWLAIBSS
  DHDCFLAGS += -DSUPPORT_LTECX
  DHDCFLAGS += -DSUPPORT_2G_VHT
  DHDCFLAGS += -DSUPPORT_WL_TXPOWER
  DHDCFLAGS += -fno-pic
ifeq ($(CONFIG_BCM4354),y)
  DHDCFLAGS += -DENABLE_INSMOD_NO_FW_LOAD
  DHDCFLAGS += -DUSE_LATE_INITCALL_SYNC
  DRIVER_TYPE = y
endif
ifeq ($(BUS_IFACE_SDIO),y)
  DHDCFLAGS += -DCUSTOM_PSPRETEND_THR=30
endif
endif

# Chipsets supported SDIO only
ifeq ($(BUS_IFACE_SDIO),y)
ifneq ($(CONFIG_BCM4339),)
  DHDCFLAGS += -DBCM4339_CHIP -DHW_OOB
  DHDCFLAGS += -DUSE_CID_CHECK
  DHDCFLAGS += -DENABLE_BCN_LI_BCN_WAKEUP
  DHDCFLAGS += -DUSE_SDIOFIFO_IOVAR

  # tput enhancement
  DHDCFLAGS += -DCUSTOM_GLOM_SETTING=8 -DCUSTOM_RXCHAIN=1
  DHDCFLAGS += -DUSE_DYNAMIC_F2_BLKSIZE -DDYNAMIC_F2_BLKSIZE_FOR_NONLEGACY=128
  DHDCFLAGS += -DBCMSDIOH_TXGLOM -DCUSTOM_TXGLOM=1 -DBCMSDIOH_TXGLOM_HIGHSPEED
  DHDCFLAGS += -DDHDTCPACK_SUPPRESS
  DHDCFLAGS += -DUSE_WL_TXBF
  DHDCFLAGS += -DUSE_WL_FRAMEBURST
  DHDCFLAGS += -DRXFRAME_THREAD
  DHDCFLAGS += -DCUSTOM_AMPDU_BA_WSIZE=64 -DCUSTOM_IBSS_AMPDU_BA_WSIZE=16
  DHDCFLAGS += -DCUSTOM_DPC_CPUCORE=0
  DHDCFLAGS += -DPROP_TXSTATUS_VSDB
ifeq ($(CONFIG_ARCH_MSM),y)
  DHDCFLAGS += -DCUSTOM_DEF_TXGLOM_SIZE=32 -DDHD_TXBOUND=32
  DHDCFLAGS += -DENABLE_ADAPTIVE_SCHED -DCUSTOM_CPUFREQ_THRESH=1000000
endif
  DHDCFLAGS += -DCUSTOM_MAX_TXGLOM_SIZE=32

  # New Features
  DHDCFLAGS += -DWL11U -DMFP
  DHDCFLAGS += -DBCMCCX
  DHDCFLAGS += -DWES_SUPPORT
  DHDCFLAGS += -DOKC_SUPPORT
  DHDCFLAGS += -DWLTDLS -DWLTDLS_AUTO_ENABLE
  DHDCFLAGS += -DWLFBT
  DHDCFLAGS += -DDHD_ENABLE_LPC
  DHDCFLAGS += -DWLAIBSS
  DHDCFLAGS += -DSUPPORT_LTECX
  DHDCFLAGS += -DSUPPORT_2G_VHT
  DHDCFLAGS += -DSUPPORT_WL_TXPOWER
  DHDCFLAGS += -DBCMCCX_S69
ifeq ($(CONFIG_BCM4339),y)
  DHDCFLAGS += -DENABLE_INSMOD_NO_FW_LOAD
  DHDCFLAGS += -DUSE_LATE_INITCALL_SYNC
  DRIVER_TYPE = y
endif
  DHDCFLAGS += -DCUSTOM_PSPRETEND_THR=30
endif

ifneq ($(CONFIG_BCM4335),)
  DHDCFLAGS += -DBCM4335_CHIP -DHW_OOB -DSUPPORT_MULTIPLE_REVISION
  DHDCFLAGS += -DUSE_CID_CHECK
  DHDCFLAGS += -DENABLE_BCN_LI_BCN_WAKEUP
  DHDCFLAGS += -DUSE_SDIOFIFO_IOVAR

  # tput enhancement
  DHDCFLAGS += -DCUSTOM_GLOM_SETTING=8 -DCUSTOM_RXCHAIN=1
  DHDCFLAGS += -DUSE_DYNAMIC_F2_BLKSIZE -DDYNAMIC_F2_BLKSIZE_FOR_NONLEGACY=128
  DHDCFLAGS += -DBCMSDIOH_TXGLOM -DCUSTOM_TXGLOM=1 -DBCMSDIOH_TXGLOM_HIGHSPEED
  DHDCFLAGS += -DDHDTCPACK_SUPPRESS
# DHDCFLAGS += -DDHD_SET_FW_HIGHSPEED
  DHDCFLAGS += -DUSE_WL_TXBF
  DHDCFLAGS += -DUSE_WL_FRAMEBURST
  DHDCFLAGS += -DRXFRAME_THREAD
  DHDCFLAGS += -DREPEAT_READFRAME
  DHDCFLAGS += -DCUSTOM_AMPDU_BA_WSIZE=64
  DHDCFLAGS += -DCUSTOM_DPC_CPUCORE=0
  DHDCFLAGS += -DPROP_TXSTATUS_VSDB
# DHDCFLAGS += -DTPUT_DEBUG
ifeq ($(CONFIG_MACH_JF),y)
  DHDCFLAGS += -DCUSTOM_DEF_TXGLOM_SIZE=32 -DDHD_TXBOUND=32
endif
ifeq ($(CONFIG_ARCH_MSM),y)
  DHDCFLAGS += -DCUSTOM_DEF_TXGLOM_SIZE=32 -DDHD_TXBOUND=32
  DHDCFLAGS += -DENABLE_ADAPTIVE_SCHED -DCUSTOM_CPUFREQ_THRESH=1000000
endif
  DHDCFLAGS += -DCUSTOM_MAX_TXGLOM_SIZE=32

  # New Features
  DHDCFLAGS += -DWL11U -DMFP
  DHDCFLAGS += -DBCMCCX
  DHDCFLAGS += -DWES_SUPPORT
  DHDCFLAGS += -DOKC_SUPPORT
  DHDCFLAGS += -DWLTDLS -DWLTDLS_AUTO_ENABLE
  DHDCFLAGS += -DWLFBT
  DHDCFLAGS += -DDHD_ENABLE_LPC
  DHDCFLAGS += -DWLAIBSS
  DHDCFLAGS += -DSUPPORT_LTECX
  DHDCFLAGS += -DSUPPORT_2G_VHT
  DHDCFLAGS += -DSUPPORT_WL_TXPOWER
# For BT LOCK
ifeq ($(CONFIG_BCM4335BT),y)
  DHDCFLAGS += -DENABLE_4335BT_WAR
endif
ifeq ($(CONFIG_BCM4335),y)
  DHDCFLAGS += -DENABLE_INSMOD_NO_FW_LOAD
  DHDCFLAGS += -DUSE_LATE_INITCALL_SYNC
  DRIVER_TYPE = y
endif
endif

ifneq ($(CONFIG_BCM4334),)
  DHDCFLAGS += -DBCM4334_CHIP -DHW_OOB -DSUPPORT_MULTIPLE_REVISION
  DHDCFLAGS += -DUSE_CID_CHECK
  DHDCFLAGS += -DENABLE_BCN_LI_BCN_WAKEUP
  DHDCFLAGS += -DUSE_DYNAMIC_F2_BLKSIZE -DDYNAMIC_F2_BLKSIZE_FOR_NONLEGACY=64
  DHDCFLAGS += -DCUSTOM_GLOM_SETTING=5
  DHDCFLAGS += -DPROP_TXSTATUS_VSDB
  DHDCFLAGS += -DWES_SUPPORT
  DHDCFLAGS += -DSUPPORT_WL_TXPOWER
ifeq ($(CONFIG_ARCH_MSM8960),y)
  DHDCFLAGS += -DDHD_SDALIGN=4
endif
  # New Features
  DHDCFLAGS += -DWL11U
ifeq ($(CONFIG_BCM4334),y)
  DHDCFLAGS += -DENABLE_INSMOD_NO_FW_LOAD
  DHDCFLAGS += -DUSE_LATE_INITCALL_SYNC
  DRIVER_TYPE = y
endif
endif

ifneq ($(CONFIG_BCM4343),)
  DHDCFLAGS += -DBCM43430_CHIP -DSUPPORT_MULTIPLE_REVISION -DHW_OOB
  DHDCFLAGS += -DMCAST_LIST_ACCUMULATION
  DHDCFLAGS += -DCUSTOM_GLOM_SETTING=0
ifeq ($(CONFIG_BCM4343),y)
  DHDCFLAGS += -DENABLE_INSMOD_NO_FW_LOAD
  DHDCFLAGS += -DUSE_LATE_INITCALL_SYNC
  DRIVER_TYPE = y
endif
  # Remove common feature for BCM4343
  DHDCFLAGS :=$(filter-out -DSUPPORT_AMPDU_MPDU_CMD,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DVSDB,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DPROP_TXSTATUS,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DROAM_AP_ENV_DETECTION,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DDHD_USE_IDLECOUNT,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DDISABLE_11H_SOFTAP,$(DHDCFLAGS))
endif

ifneq ($(CONFIG_BCM4330),)
  DHDCFLAGS += -DBCM4330_CHIP -DSUPPORT_MULTIPLE_REVISION
  DHDCFLAGS += -DMCAST_LIST_ACCUMULATION
  DHDCFLAGS += -DCUSTOM_GLOM_SETTING=0
  DHDCFLAGS += -DWL_CFG80211_GON_COLLISION
ifeq ($(CONFIG_BCM4330),y)
  DHDCFLAGS += -DENABLE_INSMOD_NO_FW_LOAD
  DHDCFLAGS += -DUSE_LATE_INITCALL_SYNC
  DRIVER_TYPE = y
endif
  # Remove common feature for BCM4330
  DHDCFLAGS :=$(filter-out -DSUPPORT_AMPDU_MPDU_CMD,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DVSDB,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DPROP_TXSTATUS,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DROAM_AP_ENV_DETECTION,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DDHD_USE_IDLECOUNT,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DDISABLE_11H_SOFTAP,$(DHDCFLAGS))
endif

ifneq ($(CONFIG_BCM43241),)
  DHDCFLAGS += -DBCM43241_CHIP -DHW_OOB
  DHDCFLAGS += -DMIMO_ANT_SETTING
  DHDCFLAGS += -DCUSTOM_GLOM_SETTING=1 -DCUSTOM_SDIO_F2_BLKSIZE=128
  DHDCFLAGS += -DUSE_SDIOFIFO_IOVAR
  DHDCFLAGS += -DAMPDU_HOSTREORDER
ifeq ($(CONFIG_BCM43241),m)
  DHDCFLAGS += -fno-pic
endif
ifeq ($(CONFIG_BCM43241),y)
  DHDCFLAGS += -DENABLE_INSMOD_NO_FW_LOAD
  DHDCFLAGS += -DUSE_LATE_INITCALL_SYNC
  DRIVER_TYPE = y
endif
endif
endif # chipset supported SDIO only


#############################
# Platform dependent feature
#############################

ifeq ($(CONFIG_SPI_SC8810),y)
  DHDCFLAGS += -DREAD_MACADDR -DBCMSPI -DBCMSPI_ANDROID -DSPI_PIO_32BIT_RW -DSPI_PIO_RW_BIGENDIAN
  DHDCFLAGS += -UCUSTOM_DPC_PRIO_SETTING

  #Remove defines for SDMMC
  DHDCFLAGS :=$(filter-out -DOOB_INTR_ONLY,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DBCMLXSDMMC,$(DHDCFLAGS))

  #Remove defines for JB
  DHDCFLAGS :=$(filter-out -DWL_ENABLE_P2P_IF,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DMULTIPLE_SUPPLICANT,$(DHDCFLAGS))
  DHDCFLAGS :=$(filter-out -DWL_CFG80211_STA_EVENT,$(DHDCFLAGS))
endif

# For SLP feature
ifeq ($(CONFIG_SLP),y)
  DHDCFLAGS += -DUSE_INITIAL_2G_SCAN
  DHDCFLAGS += -DPLATFORM_SLP -DWRITE_MACADDR
  DHDCFLAGS += -DSUPPORT_MULTIPLE_CHIPS -DENABLE_4335BT_WAR
  DHDCFLAGS += -USUPPORT_MULTIPLE_REVISION -UCONFIG_HAS_WAKELOCK
endif

# GGSM_WIFI_5GHz_CHANNELS feature is define for only GGSM model
ifeq ($(GGSM_WIFI_5GHz_CHANNELS),true)
  DHDCFLAGS += -DCUSTOMER_SET_COUNTRY
endif


ifeq ($(CONFIG_OF),y)
ifneq ($(CONFIG_MACH_UNIVERSAL7420),)
DHDCFLAGS += -DDHD_OF_SUPPORT
DHDCFLAGS += -DBCMPCIE_OOB_HOST_WAKE
endif
ifneq ($(CONFIG_MACH_UNIVERSAL5433),)
DHDCFLAGS += -DDHD_OF_SUPPORT
DHDCFLAGS += -DBCMPCIE_OOB_HOST_WAKE
DHDCFLAGS += -DDHD_API_SUPPORT
endif
ifneq ($(CONFIG_MACH_UNIVERSAL5430),)
DHDCFLAGS += -DDHD_OF_SUPPORT
endif
ifneq ($(CONFIG_MACH_UNIVERSAL5422),)
DHDCFLAGS += -DDHD_OF_SUPPORT
endif
ifneq ($(CONFIG_ARCH_MSM8994),)
DHDCFLAGS += -DDHD_OF_SUPPORT
endif
endif # CONFIG_OF

##############################################################
# dhd_sec_feature.h
DHDCFLAGS += -include "dhd_sec_feature.h"
##############################################################

#########
# Others
#########

#EXTRA_LDFLAGS += --strip-debug

EXTRA_CFLAGS += $(DHDCFLAGS) -DDHD_DEBUG
EXTRA_CFLAGS += -DSRCBASE=\"$(src)\"
EXTRA_CFLAGS += -I$(src)/include/ -I$(src)/
KBUILD_CFLAGS += -I$(LINUXDIR)/include -I$(shell pwd)

DHDOFILES := dhd_pno.o dhd_common.o dhd_ip.o dhd_custom_gpio.o dhd_custom_sec.o \
	dhd_linux.o dhd_linux_sched.o dhd_cfg80211.o dhd_linux_wq.o aiutils.o bcmevent.o \
	bcmutils.o bcmwifi_channels.o hndpmu.o linux_osl.o sbutils.o siutils.o \
	wl_android.o wl_cfg80211.o wl_cfgp2p.o wl_cfg_btcoex.o wldev_common.o \
	wl_linux_mon.o wl_roam.o dhd_linux_platdev.o dhd_linux_wq.o wl_cfg_btcoex.o \
	hnd_pktq.o hnd_pktpool.o


ifeq ($(BUS_IFACE_SDIO),y)
DHDOFILES += bcmsdh.o bcmsdh_linux.o bcmsdh_sdmmc.o bcmsdh_sdmmc_linux.o
DHDOFILES += dhd_cdc.o dhd_sdio.o
DHDOFILES += dhd_wlfc.o
endif

ifeq ($(BUS_IFACE_PCIE),y)
DHDOFILES += dhd_pcie.o dhd_pcie_linux.o pcie_core.o dhd_flowring.o dhd_msgbuf.o
endif

DHDOFILES += $(DHD_ANDROID_OFILES)

# For SPI projects
ifeq ($(CONFIG_SPI_SC8810),y)
DHDOFILES += bcmsdspi_linux.o bcmspibrcm.o
DHDOFILES :=$(filter-out bcmsdh_sdmmc.o,$(DHDOFILES))
DHDOFILES :=$(filter-out bcmsdh_sdmmc_linux.o,$(DHDOFILES))
endif

# NAN feature
ifeq ($(CONFIG_WL_NAN),y)
DHDOFILES += wl_cfgnan.o bcmxtlv.o
endif

dhd-y := $(DHDOFILES)
obj-$(DRIVER_TYPE)   += dhd.o

all:
	@echo "$(MAKE) --no-print-directory -C $(KDIR) SUBDIRS=$(CURDIR) modules"
	@$(MAKE) --no-print-directory -C $(KDIR) SUBDIRS=$(CURDIR) modules

clean:
	rm -rf *.o *.ko *.mod.c *~ .*.cmd *.o.cmd .*.o.cmd \
	Module.symvers modules.order .tmp_versions modules.builtin

install:
	@$(MAKE) --no-print-directory -C $(KDIR) \
		SUBDIRS=$(CURDIR) modules_install
