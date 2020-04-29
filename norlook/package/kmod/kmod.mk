KMOD_CONF_OPTS += --exec-prefix= --bindir=/sbin --sbindir=/sbin --libdir=/usr/lib

KMOD_USR_LIBS = libkmod

define KMOD_INSTALL_LIBS_NORLOOK
	for i in $(KMOD_USR_LIBS); do \
		mv -f $(TARGET_DIR)/usr/lib/$${i}.so* $(TARGET_DIR)/lib/; \
	done
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
