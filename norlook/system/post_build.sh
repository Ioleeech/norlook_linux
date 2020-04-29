#!/bin/sh

# Remove default os-release file
rm -f ${TARGET_DIR}/usr/lib/os-release

# Clean device folder
rm -fr ${TARGET_DIR}/dev/pts
rm -fr ${TARGET_DIR}/dev/shm
rm -f  ${TARGET_DIR}/dev/*

# Remove unused directories
rm -fr ${TARGET_DIR}/media
rm -fr ${TARGET_DIR}/opt

exit 0
