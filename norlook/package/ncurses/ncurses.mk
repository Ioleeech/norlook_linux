NCURSES_CONF_OPTS += --exec-prefix= --bindir=/bin --sbindir=/sbin --libdir=/usr/lib --with-terminfo-dirs=/lib

NCURSES_USR_LIBS = libformw libmenuw libncursesw libpanelw

define NCURSES_INSTALL_LIBS_NORLOOK
	for i in $(NCURSES_USR_LIBS); do \
		mv -f $(TARGET_DIR)/usr/lib/$${i}.so* $(TARGET_DIR)/lib/; \
	done
endef

define NCURSES_CLEAN_TARGET_NORLOOK
	rm -f $(TARGET_DIR)/bin/ncursesw6-config
endef

define NCURSES_UPDATE_TERMINFO_NORLOOK
	rm -rf $(TARGET_DIR)/usr/share/terminfo; \
	rm -f $(TARGET_DIR)/usr/lib/terminfo; \
	cp -rf $(STAGING_DIR)/usr/share/terminfo $(TARGET_DIR)/usr/share
endef

NCURSES_POST_INSTALL_TARGET_HOOKS += NCURSES_INSTALL_LIBS_NORLOOK
NCURSES_POST_INSTALL_TARGET_HOOKS += NCURSES_CLEAN_TARGET_NORLOOK
NCURSES_POST_INSTALL_TARGET_HOOKS += NCURSES_UPDATE_TERMINFO_NORLOOK

ifeq ($(BR2_PACKAGE_NCURSES_TARGET_PROGS),y)
define NCURSES_UPDATE_TOOLS_NORLOOK
	rm -f $(TARGET_DIR)/usr/bin/reset; \
	ln -sf tset $(TARGET_DIR)/bin/reset
endef

NCURSES_POST_INSTALL_TARGET_HOOKS += NCURSES_UPDATE_TOOLS_NORLOOK
endif

define NCURSES_INSTALL_BIN_NORLOOK
	mv -f $(STAGING_DIR)/bin/ncursesw6-config $(STAGING_DIR)/usr/bin/
endef

NCURSES_POST_INSTALL_STAGING_HOOKS += NCURSES_INSTALL_BIN_NORLOOK
