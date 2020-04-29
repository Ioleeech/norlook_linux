EUDEV_CONF_OPTS += --exec-prefix= --bindir=/sbin --sbindir=/sbin --libdir=/usr/lib

define EUDEV_INSTALL_LIBS_NORLOOK
	rm -f $(TARGET_DIR)/usr/lib/libudev.so; \
	rm -f $(TARGET_DIR)/lib/libudev.so; \
	cp -fP $(TARGET_DIR)/lib/libudev.so.1 $(TARGET_DIR)/lib/libudev.so
endef

EUDEV_POST_INSTALL_TARGET_HOOKS += EUDEV_INSTALL_LIBS_NORLOOK
