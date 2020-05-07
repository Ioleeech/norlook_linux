BASH_CONF_ENV  += loadablesdir=/lib/bash
BASH_CONF_OPTS += --exec-prefix= --bindir=/bin --sbindir=/sbin --libdir=/usr/lib

define BASH_UPDATE_TARGET_NORLOOK
	rm -f  $(TARGET_DIR)/lib/bash/Makefile.inc; \
	rm -rf $(TARGET_DIR)/lib/bash; \
	ln -sf bash $(TARGET_DIR)/bin/sh
endef

BASH_POST_INSTALL_TARGET_HOOKS += BASH_UPDATE_TARGET_NORLOOK
