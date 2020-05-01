KMOD_CONF_OPTS += --exec-prefix= --bindir=/sbin --sbindir=/sbin --libdir=/usr/lib

define KMOD_INSTALL_LIBS_NORLOOK
	mv -f $(TARGET_DIR)/usr/lib/libkmod.so* $(TARGET_DIR)/lib/
endef

KMOD_POST_INSTALL_TARGET_HOOKS += KMOD_INSTALL_LIBS_NORLOOK

ifeq ($(BR2_PACKAGE_KMOD_TOOLS),y)
KMOD_SBIN_TOOLS = depmod insmod lsmod modinfo modprobe rmmod

define KMOD_INSTALL_TOOLS_NORLOOK
	for i in $(KMOD_SBIN_TOOLS); do \
		ln -sf kmod $(TARGET_DIR)/sbin/$${i}; \
	done
endef

KMOD_POST_INSTALL_TARGET_HOOKS += KMOD_INSTALL_TOOLS_NORLOOK
endif
