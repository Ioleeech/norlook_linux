#GPM_CONF_OPTS += --exec-prefix= --bindir=/bin --sbindir=/sbin --libdir=/usr/lib
#
#define GPM_INSTALL_LIBS_NORLOOK
#	mv -f $(TARGET_DIR)/usr/lib/libgpm.so* $(TARGET_DIR)/lib/
#endef

GPM_TEST_TOOLS = gpm-root disable-paste display-buttons display-coords get-versions hltest mev mouse-test

define GPM_CLEAN_TARGET_NORLOOK
	rm -f $(TARGET_DIR)/etc/gpm-root.conf; \
	for i in $(GPM_TEST_TOOLS); do \
		rm -f $(TARGET_DIR)/usr/bin/$${i}; \
	done
endef

#define GPM_CLEAN_TARGET_NORLOOK
#	rm -f $(TARGET_DIR)/etc/gpm-root.conf; \
#	for i in $(GPM_TEST_TOOLS); do \
#		rm -f $(TARGET_DIR)/bin/$${i}; \
#	done
#endef
#
#GPM_POST_INSTALL_TARGET_HOOKS += GPM_INSTALL_LIBS_NORLOOK
GPM_POST_INSTALL_TARGET_HOOKS += GPM_CLEAN_TARGET_NORLOOK
