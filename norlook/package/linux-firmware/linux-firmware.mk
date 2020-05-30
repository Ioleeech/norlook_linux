ifeq ($(BR2_PACKAGE_LINUX_FIRMWARE_INTEL_SST_DSP),y)
	LINUX_FIRMWARE_FILES += intel/fw_sst_0f28.bin
endif

define LINUX_FIRMWARE_CLEAN_TARGET_NORLOOK
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8712u*;    \
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8723aufw*; \
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8723befw*; \
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8723bu*;   \
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8723fw*;   \
	rm -f $(TARGET_DIR)/lib/firmware/intel/fw_sst_0f28.bin-48kHz_i2s_master
endef

LINUX_FIRMWARE_POST_INSTALL_TARGET_HOOKS += LINUX_FIRMWARE_CLEAN_TARGET_NORLOOK
