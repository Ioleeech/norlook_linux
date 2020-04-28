#!/bin/sh

# Remove default os-release file
rm -f ${TARGET_DIR}/usr/lib/os-release

# Clean device folder
rm -fr ${TARGET_DIR}/dev/pts
rm -fr ${TARGET_DIR}/dev/shm
rm -f  ${TARGET_DIR}/dev/*

exit 0
