#!/bin/bash

# Global parameters
CURRENT_DIR="$(pwd)"

# Buildroot parameters
BUILDROOT_VERSION="2020.02.1"
BUILDROOT_URL="https://buildroot.org/downloads"

BUILDROOT_GZIP="buildroot-${BUILDROOT_VERSION}.tar.gz"
BUILDROOT_BZIP="buildroot-${BUILDROOT_VERSION}.tar.bz2"

# Get buildroot package
if [ ! -d "${CURRENT_DIR}/distfiles" ]; then
    rm   -rf "${CURRENT_DIR}/distfiles"
    mkdir -p "${CURRENT_DIR}/distfiles"
fi

if [ ! -d "${CURRENT_DIR}/distfiles/buildroot" ]; then
    rm   -rf "${CURRENT_DIR}/distfiles/buildroot"
    mkdir -p "${CURRENT_DIR}/distfiles/buildroot"
fi

DOWNLOAD_GZIP="N"
tar -tf "${CURRENT_DIR}/distfiles/buildroot/${BUILDROOT_GZIP}" > /dev/null 2> /dev/null || DOWNLOAD_GZIP="Y"

if [ "X${DOWNLOAD_GZIP}" != "XN" ]; then
    rm   -f "${CURRENT_DIR}/distfiles/buildroot/${BUILDROOT_GZIP}"
    wget --passive-ftp -nd -t 3 -P "${CURRENT_DIR}/distfiles/buildroot" "${BUILDROOT_URL}/${BUILDROOT_GZIP}"
fi

# Main routine
rm  -rf  "${CURRENT_DIR}/buildroot"
tar -xzf "${CURRENT_DIR}/distfiles/buildroot/${BUILDROOT_GZIP}" -C "${CURRENT_DIR}"
mv  -f   "${CURRENT_DIR}/buildroot-${BUILDROOT_VERSION}" "${CURRENT_DIR}/buildroot"
