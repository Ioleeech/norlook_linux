GPM_CONF_OPTS += --exec-prefix= --bindir=/bin --sbindir=/sbin --libdir=/usr/lib

define GPM_INSTALL_LIBS_NORLOOK
	mv -f $(TARGET_DIR)/usr/lib/libgpm.so* $(TARGET_DIR)/lib/
endef

GPM_POST_INSTALL_TARGET_HOOKS += GPM_INSTALL_LIBS_NORLOOK
