ifneq ($(BR2_ROOTFS_MERGED_USR),y)
UTIL_LINUX_CONF_OPTS += --exec-prefix= --bindir=/bin --sbindir=/sbin --libdir=/usr/lib

UTIL_LINUX_USR_LIBS = libblkid libuuid

define UTIL_LINUX_INSTALL_LIBS_NORLOOK
	for i in $(UTIL_LINUX_USR_LIBS); do \
		mv -f $(TARGET_DIR)/usr/lib/$${i}.so* $(TARGET_DIR)/lib/; \
	done
endef

UTIL_LINUX_POST_INSTALL_TARGET_HOOKS += UTIL_LINUX_INSTALL_LIBS_NORLOOK
endif
