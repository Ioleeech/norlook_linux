#!/bin/sh

# Create boot image
${BR2_EXTERNAL_NORLOOK_PATH}/package/grub2/post_image_efi_gpt.sh

# Rename rootfs.cpio to initrd
mv -f ${BINARIES_DIR}/rootfs.cpio ${BINARIES_DIR}/initrd

exit 0
