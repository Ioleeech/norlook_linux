undefine WPA_SUPPLICANT_BUILD_CMDS
undefine WPA_SUPPLICANT_INSTALL_TARGET_CMDS

define WPA_SUPPLICANT_BUILD_CMDS
	$(TARGET_MAKE_ENV) CFLAGS="$(WPA_SUPPLICANT_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" BINDIR=/sbin \
		LIBS="$(WPA_SUPPLICANT_LIBS)" LIBS_c="$(WPA_SUPPLICANT_LIBS)" \
		LIBS_p="$(WPA_SUPPLICANT_LIBS)" \
		$(MAKE) CC="$(TARGET_CC)" -C $(@D)/$(WPA_SUPPLICANT_SUBDIR)
endef

define WPA_SUPPLICANT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/$(WPA_SUPPLICANT_SUBDIR)/wpa_supplicant $(TARGET_DIR)/sbin/wpa_supplicant
	$(INSTALL) -m 0755 -D $(@D)/$(WPA_SUPPLICANT_SUBDIR)/wpa_passphrase $(TARGET_DIR)/sbin/wpa_passphrase
endef