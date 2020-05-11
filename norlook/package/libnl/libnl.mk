LIBNL_USR_LIBS = libnl-3 libnl-genl-3 libnl-idiag-3 libnl-nf-3 libnl-route-3 libnl-xfrm-3

define LIBNL_INSTALL_LIBS_NORLOOK
	for i in $(LIBNL_USR_LIBS); do \
		mv -f $(TARGET_DIR)/usr/lib/$${i}.so* $(TARGET_DIR)/lib/; \
	done
endef

define LIBNL_CLEAN_TARGET_NORLOOK
	rm -rf $(TARGET_DIR)/etc/libnl
endef

LIBNL_POST_INSTALL_TARGET_HOOKS += LIBNL_INSTALL_LIBS_NORLOOK
LIBNL_POST_INSTALL_TARGET_HOOKS += LIBNL_CLEAN_TARGET_NORLOOK
