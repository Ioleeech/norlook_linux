READLINE_USR_LIBS = libhistory libreadline

define READLINE_INSTALL_LIBS_NORLOOK
	for i in $(READLINE_USR_LIBS); do \
		mv -f $(TARGET_DIR)/usr/lib/$${i}.so* $(TARGET_DIR)/lib/; \
	done
endef

READLINE_POST_INSTALL_TARGET_HOOKS += READLINE_INSTALL_LIBS_NORLOOK
