ifneq ($(HOST_GCC_FINAL_USR_LIBS),)
ifeq ($(BR2_STATIC_LIBS),)

define HOST_GCC_FINAL_INSTALL_LIBS_NORLOOK
	for i in $(HOST_GCC_FINAL_USR_LIBS); do \
		mv -f $(STAGING_DIR)/usr/lib/$${i}.so* $(STAGING_DIR)/lib/; \
		mv -f $(TARGET_DIR)/usr/lib/$${i}.so* $(TARGET_DIR)/lib/; \
	done; \
	rm -f $(TARGET_DIR)/lib/libstdc++.so.*.py
endef

HOST_GCC_FINAL_POST_INSTALL_HOOKS += HOST_GCC_FINAL_INSTALL_LIBS_NORLOOK

endif
endif
