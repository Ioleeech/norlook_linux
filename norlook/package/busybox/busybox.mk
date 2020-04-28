undefine BUSYBOX_INSTALL_UDHCPC_SCRIPT
undefine BUSYBOX_INSTALL_TARGET_CMDS

define BUSYBOX_INSTALL_UDHCPC_SCRIPT
	grep -q CONFIG_UDHCPC=y $(@D)/.config && $(INSTALL) -m 0755 -D package/busybox/udhcpc.script $(TARGET_DIR)/etc/udhcpc/default.script
endef

define BUSYBOX_INSTALL_TARGET_CMDS
	# Use the 'noclobber' install rule, to prevent BusyBox from overwriting
	# any full-blown versions of apps installed by other packages.
	$(BUSYBOX_MAKE_ENV) $(MAKE) $(BUSYBOX_MAKE_OPTS) -C $(@D) install-noclobber
	$(BUSYBOX_INSTALL_INITTAB)
	$(BUSYBOX_INSTALL_UDHCPC_SCRIPT)
	$(BUSYBOX_INSTALL_MDEV_CONF)
endef
