define IW_INSTALL_TOOLS_NORLOOK
	mv -f $(TARGET_DIR)/usr/sbin/iw $(TARGET_DIR)/sbin/
endef

IW_POST_INSTALL_TARGET_HOOKS += IW_INSTALL_TOOLS_NORLOOK
