NORLOOK_GCC_VERSION      = $(call qstrip,$(BR2_GCC_VERSION))
NORLOOK_GCC_SITE         = $(BR2_GNU_MIRROR:/=)/gcc/gcc-$(NORLOOK_GCC_VERSION)
NORLOOK_GCC_SOURCE       = gcc-$(NORLOOK_GCC_VERSION).tar.xz
NORLOOK_GCC_DEPENDENCIES = binutils gmp mpc mpfr $(NORLOOK_TOOLCHAIN_LIBC)

# Use already downloaded archive
NORLOOK_GCC_DL_SUBDIR = gcc

# Do not extract files for Java and Go
NORLOOK_GCC_EXCLUDES = libjava/* libgo/*

# gcc doesn't support in-tree build, so we create a 'build' subdirectory
# in the gcc sources, and build from there
NORLOOK_GCC_SUBDIR = build

# Don't build documentation. It takes up extra space / build time,
# and sometimes needs specific makeinfo versions to work
NORLOOK_GCC_CONF_ENV = MAKEINFO=missing

# Propagate options used for target software building to GCC target libs
NORLOOK_GCC_CONF_ENV += CFLAGS_FOR_TARGET="$(TARGET_CFLAGS)"
NORLOOK_GCC_CONF_ENV += CXXFLAGS_FOR_TARGET="$(TARGET_CXXFLAGS)"

# The logic in libbacktrace/configure.ac to detect if __sync builtins
# are available assumes they are as soon as target_subdir is not empty,
# i.e when cross-compiling
# However, some platforms do not have __sync builtins, so help the configure script a bit
ifeq ($(BR2_TOOLCHAIN_HAS_SYNC_4),)
NORLOOK_GCC_CONF_ENV += target_configargs="libbacktrace_cv_sys_sync=no"
endif

# Languages supported by the cross-compiler
NORLOOK_GCC_CROSS_LANGUAGES-y = c
NORLOOK_GCC_CROSS_LANGUAGES-$(BR2_INSTALL_LIBSTDCPP) += c++
NORLOOK_GCC_CROSS_LANGUAGES = $(subst $(space),$(comma),$(NORLOOK_GCC_CROSS_LANGUAGES-y))

NORLOOK_GCC_CONF_OPTS = \
	--host=$(GNU_TARGET_NAME) \
	--target=$(GNU_TARGET_NAME) \
	--enable-__cxa_atexit \
	--enable-languages=$(NORLOOK_GCC_CROSS_LANGUAGES) \
	--with-gnu-ld \
	--without-isl \
	--without-cloog \
	--disable-libssp \
	--disable-multilib \
	--disable-decimal-float \
	--with-pkgversion=$(NORLOOK_TOOLCHAIN_LABEL) \
	--with-bugurl="https://github.com/ioleeech/norlook_linux"

# libmpx uses secure_getenv and struct _libc_fpstate not present in musl
ifeq ($(BR2_TOOLCHAIN_BUILDROOT_MUSL)$(BR2_TOOLCHAIN_GCC_AT_LEAST_6),yy)
NORLOOK_GCC_CONF_OPTS += --disable-libmpx
endif

# quadmath support requires wchar
ifeq ($(BR2_USE_WCHAR)$(BR2_TOOLCHAIN_HAS_LIBQUADMATH),yy)
NORLOOK_GCC_CONF_OPTS += --enable-libquadmath
else
NORLOOK_GCC_CONF_OPTS += --disable-libquadmath --disable-libquadmath-support
endif

# libsanitizer requires wordexp, not in default uClibc config,
# also doesn't build properly with musl
ifeq ($(BR2_TOOLCHAIN_BUILDROOT_UCLIBC)$(BR2_TOOLCHAIN_BUILDROOT_MUSL),y)
NORLOOK_GCC_CONF_OPTS += --disable-libsanitizer
endif

# TLS support is not needed on uClibc/no-thread and uClibc/linux-threads,
# otherwise, for all other situations (glibc, musl and uClibc/NPTL), it is needed
ifeq ($(BR2_TOOLCHAIN_BUILDROOT_UCLIBC)$(BR2_PTHREADS)$(BR2_PTHREADS_NONE),yy)
NORLOOK_GCC_CONF_OPTS += --disable-tls
else
NORLOOK_GCC_CONF_OPTS += --enable-tls
endif

ifeq ($(BR2_GCC_ENABLE_LTO),y)
NORLOOK_GCC_CONF_OPTS += --enable-plugins --enable-lto
endif

ifeq ($(BR2_PTHREADS_NONE),y)
NORLOOK_GCC_CONF_OPTS += --disable-threads --disable-libitm --disable-libatomic
else
NORLOOK_GCC_CONF_OPTS += --enable-threads
endif

# Disable shared libs like libstdc++ if we do static since it confuses linking
ifeq ($(BR2_STATIC_LIBS),y)
NORLOOK_GCC_CONF_OPTS += --disable-shared
else
NORLOOK_GCC_CONF_OPTS += --enable-shared
endif

ifeq ($(BR2_GCC_ENABLE_OPENMP),y)
NORLOOK_GCC_CONF_OPTS += --enable-libgomp
else
NORLOOK_GCC_CONF_OPTS += --disable-libgomp
endif

# Determine arch/tune/abi/cpu options
ifneq ($(GCC_TARGET_ARCH),)
NORLOOK_GCC_CONF_OPTS += --with-arch="$(GCC_TARGET_ARCH)"
endif

ifneq ($(GCC_TARGET_ABI),)
NORLOOK_GCC_CONF_OPTS += --with-abi="$(GCC_TARGET_ABI)"
endif

ifeq ($(BR2_TOOLCHAIN_HAS_MNAN_OPTION),y)
ifneq ($(GCC_TARGET_NAN),)
NORLOOK_GCC_CONF_OPTS += --with-nan="$(GCC_TARGET_NAN)"
endif
endif

ifneq ($(GCC_TARGET_FP32_MODE),)
NORLOOK_GCC_CONF_OPTS += --with-fp-32="$(GCC_TARGET_FP32_MODE)"
endif

ifneq ($(GCC_TARGET_CPU),)
NORLOOK_GCC_CONF_OPTS += --with-cpu=$(GCC_TARGET_CPU)
endif

ifneq ($(GCC_TARGET_FPU),)
NORLOOK_GCC_CONF_OPTS += --with-fpu=$(GCC_TARGET_FPU)
endif

ifneq ($(GCC_TARGET_FLOAT_ABI),)
NORLOOK_GCC_CONF_OPTS += --with-float=$(GCC_TARGET_FLOAT_ABI)
endif

ifneq ($(GCC_TARGET_MODE),)
NORLOOK_GCC_CONF_OPTS += --with-mode=$(GCC_TARGET_MODE)
endif

# End with user-provided options, so that they can override previously defined options
NORLOOK_GCC_CONF_OPTS += $(call qstrip,$(BR2_EXTRA_GCC_CONFIG_OPTIONS))

# norlook-gcc uses patches are stored in package/gcc directory in buildroot tree,
# and potentially in BR2_GLOBAL_PATCH_DIR directories as well
define NORLOOK_GCC_APPLY_PATCHES
	for patchdir in \
	    package/gcc/$(NORLOOK_GCC_VERSION) \
	    $(addsuffix /gcc/$(NORLOOK_GCC_VERSION),$(call qstrip,$(BR2_GLOBAL_PATCH_DIR))) \
	    $(addsuffix /gcc,$(call qstrip,$(BR2_GLOBAL_PATCH_DIR))) ; do \
		if test -d $${patchdir}; then \
			$(APPLY_PATCHES) $(@D) $${patchdir} \*.patch || exit 1; \
		fi; \
	done
endef

# Create 'build' directory and configure symlink
define NORLOOK_GCC_CONFIGURE_SYMLINK
	mkdir -p $(@D)/build
	ln -sf ../configure $(@D)/build/configure
endef

# Create 'usr/include' directory
define NORLOOK_GCC_CREATE_HEADERS_DIR
	mkdir -p "$(TARGET_DIR)/usr/include"
endef

NORLOOK_GCC_LIB_DIR = $(TARGET_DIR)/$(GNU_TARGET_NAME)/lib*

# Make sure we have 'cc'
define NORLOOK_GCC_CREATE_CC_SYMLINKS
	if [ ! -e $(TARGET_DIR)/bin/$(GNU_TARGET_NAME)-cc ]; then \
		ln -f $(TARGET_DIR)/bin/$(GNU_TARGET_NAME)-gcc $(TARGET_DIR)/bin/$(GNU_TARGET_NAME)-cc; \
	fi
endef

# Cannot use the NORLOOK_GCC_USR_LIBS mechanism below, because we want libgcc_s to be installed in /lib and not /usr/lib
define NORLOOK_GCC_INSTALL_LIBGCC_AND_LIBATOMIC
	-cp -dpf $(NORLOOK_GCC_LIB_DIR)/libgcc_s*  $(TARGET_DIR)/lib/; \
	-cp -dpf $(NORLOOK_GCC_LIB_DIR)/libatomic* $(TARGET_DIR)/lib/
endef

NORLOOK_GCC_POST_PATCH_HOOKS    += NORLOOK_GCC_APPLY_PATCHES
NORLOOK_GCC_PRE_CONFIGURE_HOOKS += NORLOOK_GCC_CONFIGURE_SYMLINK
NORLOOK_GCC_PRE_BUILD_HOOKS     += NORLOOK_GCC_CREATE_HEADERS_DIR
NORLOOK_GCC_POST_INSTALL_HOOKS  += NORLOOK_GCC_CREATE_CC_SYMLINKS
NORLOOK_GCC_POST_INSTALL_HOOKS  += NORLOOK_GCC_INSTALL_LIBGCC_AND_LIBATOMIC

# Handle the installation of libraries in /usr/lib
NORLOOK_GCC_USR_LIBS =

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
NORLOOK_GCC_USR_LIBS += libstdc++
endif

ifeq ($(BR2_GCC_ENABLE_OPENMP),y)
NORLOOK_GCC_USR_LIBS += libgomp
endif

NORLOOK_GCC_USR_LIBS += $(call qstrip,$(BR2_TOOLCHAIN_EXTRA_LIBS))

ifneq ($(NORLOOK_GCC_USR_LIBS),)
define NORLOOK_GCC_INSTALL_USR_LIBS
	mkdir -p $(TARGET_DIR)/usr/lib; \
	for i in $(NORLOOK_GCC_USR_LIBS); do \
		cp -dpf $(NORLOOK_GCC_LIB_DIR)/$${i}.a   $(TARGET_DIR)/usr/lib/; \
		cp -dpf $(NORLOOK_GCC_LIB_DIR)/$${i}.so* $(TARGET_DIR)/usr/lib/; \
	done
endef

NORLOOK_GCC_POST_INSTALL_HOOKS += NORLOOK_GCC_INSTALL_USR_LIBS
endif

# We want to always build the static variants of all the gcc libraries,
# of which libstdc++, libgomp, libmudflap...
# To do so, we can not just pass --enable-static to override the generic
# --disable-static flag, otherwise gcc fails to build some of those
# libraries, see;
#   http://lists.busybox.net/pipermail/buildroot/2013-October/080412.html
#
# So we must completely override the generic commands and provide our own.
#
#		--prefix="$(TARGET_DIR)"
#		--sysconfdir="$(TARGET_DIR)/etc"
define  NORLOOK_GCC_CONFIGURE_CMDS
	(cd $(NORLOOK_GCC_SRCDIR) && rm -rf config.cache; \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		$(NORLOOK_GCC_CONF_ENV) \
		./configure \
		--prefix="/usr" \
		--sysconfdir="/etc" \
		--enable-static \
		$(QUIET) $(NORLOOK_GCC_CONF_OPTS) \
	)
endef

$(eval $(autotools-package))
