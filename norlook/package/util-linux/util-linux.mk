ifneq ($(BR2_ROOTFS_MERGED_USR),y)
UTIL_LINUX_CONF_OPTS += --exec-prefix= --bindir=/bin --sbindir=/sbin --libdir=/lib
endif
