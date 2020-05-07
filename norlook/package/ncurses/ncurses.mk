NCURSES_CONF_OPTS += --exec-prefix= --bindir=/bin --sbindir=/sbin --libdir=/usr/lib --with-default-terminfo-dir=/lib/terminfo

NCURSES_USR_LIBS = libformw libmenuw libncursesw libpanelw

define NCURSES_INSTALL_LIBS_NORLOOK
	for i in $(NCURSES_USR_LIBS); do \
		mv -f $(TARGET_DIR)/usr/lib/$${i}.so* $(TARGET_DIR)/lib/; \
	done
endef

define NCURSES_CLEAN_TARGET_NORLOOK
	rm -f $(TARGET_DIR)/bin/ncursesw6-config; \
	rm -f $(TARGET_DIR)/bin/captoinfo; \
	rm -f $(TARGET_DIR)/bin/infotocap; \
	rm -f $(TARGET_DIR)/bin/tic; \
	rm -f $(TARGET_DIR)/bin/toe; \
	rm -f $(TARGET_DIR)/bin/tabs; \
	rm -f $(TARGET_DIR)/bin/infocmp
endef

define NCURSES_UPDATE_TERMINFO_NORLOOK
	rm -rf $(TARGET_DIR)/usr/share/terminfo; \
	rm -f  $(TARGET_DIR)/usr/lib/terminfo
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

define NCURSES_STAGING_TERMINFO_NORLOOK
	rm -f  $(STAGING_DIR)/usr/share/terminfo; \
	ln -sf $(STAGING_DIR)/lib/terminfo $(STAGING_DIR)/usr/share/terminfo
endef

NCURSES_PRE_INSTALL_TARGET_HOOKS += NCURSES_STAGING_TERMINFO_NORLOOK

define NCURSES_INSTALL_BIN_NORLOOK
	mv -f $(STAGING_DIR)/bin/ncursesw6-config $(STAGING_DIR)/usr/bin/
endef

NCURSES_POST_INSTALL_STAGING_HOOKS += NCURSES_INSTALL_BIN_NORLOOK
