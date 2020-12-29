#!/bin/sh

# Remove lib32 symlinks
rm -f ${TARGET_DIR}/lib32
rm -f ${TARGET_DIR}/usr/lib32

# Remove default os-release file
rm -f ${TARGET_DIR}/usr/lib/os-release

# Remove bash-completion directory
rm -rf ${TARGET_DIR}/usr/share/bash-completion

exit 0
