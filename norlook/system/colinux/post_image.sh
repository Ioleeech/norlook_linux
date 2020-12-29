#!/bin/sh

# Remove previous rootfs images
rm -fv "${BINARIES_DIR}/norlook_root.img"
rm -fv "${BINARIES_DIR}/norlook_root.tar"

# Rename rootfs images
rm -fv "${BINARIES_DIR}/rootfs.ext3"
mv -fv "${BINARIES_DIR}/rootfs.ext2" "${BINARIES_DIR}/norlook_root.img"
mv -fv "${BINARIES_DIR}/rootfs.tar"  "${BINARIES_DIR}/norlook_root.tar"

exit 0
