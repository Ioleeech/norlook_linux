define LINUX_FIRMWARE_CLEAN_TARGET_NORLOOK
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8712u*;    \
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8723aufw*; \
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8723befw*; \
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8723bu*;   \
	rm -f $(TARGET_DIR)/lib/firmware/rtlwifi/rtl8723fw*
endef

LINUX_FIRMWARE_POST_INSTALL_TARGET_HOOKS += LINUX_FIRMWARE_CLEAN_TARGET_NORLOOK
