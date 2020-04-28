KMOD_CONF_OPTS += --bindir=/sbin --sbindir=/sbin --libdir=/lib

ifeq ($(BR2_PACKAGE_KMOD_TOOLS),y)
define KMOD_INSTALL_TOOLS_NORLOOK
	ln -sf kmod $(TARGET_DIR)/sbin/depmod;   \
	ln -sf kmod $(TARGET_DIR)/sbin/insmod;   \
	ln -sf kmod $(TARGET_DIR)/sbin/lsmod;    \
	ln -sf kmod $(TARGET_DIR)/sbin/modinfo;  \
	ln -sf kmod $(TARGET_DIR)/sbin/modprobe; \
	ln -sf kmod $(TARGET_DIR)/sbin/rmmod
endef

KMOD_POST_INSTALL_TARGET_HOOKS += KMOD_INSTALL_TOOLS_NORLOOK
endif
