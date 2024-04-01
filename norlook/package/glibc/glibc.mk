undefine GLIBC_CONFIGURE_CMDS

define GLIBC_CONFIGURE_CMDS
	mkdir -p $(@D)/build
	# Do the configuration
	(cd $(@D)/build; \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(GLIBC_CFLAGS) $(GLIBC_EXTRA_CFLAGS)" CPPFLAGS="" \
		CXXFLAGS="$(GLIBC_CFLAGS) $(GLIBC_EXTRA_CFLAGS)" \
		$(GLIBC_CONF_ENV) \
		$(SHELL) $(@D)/configure \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
		--enable-shared \
		$(if $(BR2_x86_64),--enable-lock-elision) \
		--with-pkgversion=$(NORLOOK_TOOLCHAIN_LABEL) \
		--with-bugurl="https://github.com/ioleeech/norlook_linux" \
		--disable-profile \
		--disable-werror \
		--without-gd \
		--with-headers=$(STAGING_DIR)/usr/include \
		$(if $(BR2_aarch64)$(BR2_aarch64_be),--enable-mathvec) \
		--enable-crypt \
		$(GLIBC_CONF_OPTS))
	$(GLIBC_ADD_MISSING_STUB_H)
endef
