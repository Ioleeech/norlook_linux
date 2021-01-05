undefine GLIBC_CONFIGURE_CMDS

define GLIBC_CONFIGURE_CMDS
	mkdir -p $(@D)/build
	# Do the configuration
	(cd $(@D)/build; \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="-O2 $(GLIBC_EXTRA_CFLAGS)" CPPFLAGS="" \
		CXXFLAGS="-O2 $(GLIBC_EXTRA_CFLAGS)" \
		$(GLIBC_CONF_ENV) \
		$(SHELL) $(@D)/configure \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
		--enable-shared \
		$(if $(BR2_x86_64),--enable-lock-elision) \
		--with-pkgversion=$(NORLOOK_TOOLCHAIN_LABEL) \
		--without-cvs \
		--disable-profile \
		--without-gd \
		--enable-obsolete-rpc \
		--enable-kernel=$(call qstrip,$(BR2_TOOLCHAIN_HEADERS_AT_LEAST)) \
		--with-headers=$(STAGING_DIR)/usr/include)
	$(GLIBC_ADD_MISSING_STUB_H)
endef
