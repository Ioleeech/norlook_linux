#!/bin/bash

# Global parameters
CURRENT_DIR="$(pwd)"

# Build parameters
MAKE_OUTPUT="${CURRENT_DIR}/output"
MAKE_TOPDIR="${CURRENT_DIR}/buildroot"
MAKE_EXTERNAL="${CURRENT_DIR}/norlook"
MAKE_CONFIG="${MAKE_EXTERNAL}/configs/norlook_prestigio_defconfig"

# Extarct buildroot
[ ! -d "${MAKE_TOPDIR}" ] && "${CURRENT_DIR}/extract_buildroot.sh"

# Workaround for "No rule to make target .br-external.mk" error
if [ ! -f "${MAKE_OUTPUT}/.br-external.mk" ]; then
    EXTERNAL_DESC=$(sed 's/name: //' "${MAKE_EXTERNAL}/external.desc")

    mkdir -p "${MAKE_OUTPUT}"
    echo -ne ""                                                 > "${MAKE_OUTPUT}/.br-external.mk"
    echo "BR2_EXTERNAL       ?= ${MAKE_EXTERNAL}"              >> "${MAKE_OUTPUT}/.br-external.mk"
    echo "BR2_EXTERNAL_NAMES  = "                              >> "${MAKE_OUTPUT}/.br-external.mk"
    echo "BR2_EXTERNAL_DIRS   = "                              >> "${MAKE_OUTPUT}/.br-external.mk"
    echo "BR2_EXTERNAL_MKS    = "                              >> "${MAKE_OUTPUT}/.br-external.mk"
    echo "BR2_EXTERNAL_NAMES += ${EXTERNAL_DESC}"              >> "${MAKE_OUTPUT}/.br-external.mk"
    echo "BR2_EXTERNAL_DIRS  += ${MAKE_EXTERNAL}"              >> "${MAKE_OUTPUT}/.br-external.mk"
    echo "BR2_EXTERNAL_MKS   += ${MAKE_EXTERNAL}/external.mk"  >> "${MAKE_OUTPUT}/.br-external.mk"
    echo "export BR2_EXTERNAL_NORLOOK_PATH = ${MAKE_EXTERNAL}" >> "${MAKE_OUTPUT}/.br-external.mk"
    echo "export BR2_EXTERNAL_NORLOOK_DESC = ${EXTERNAL_DESC}" >> "${MAKE_OUTPUT}/.br-external.mk"
fi

# Main routine
make V=1 O="${MAKE_OUTPUT}" defconfig -C "${MAKE_TOPDIR}" BR2_EXTERNAL="${MAKE_EXTERNAL}" BR2_DEFCONFIG="${MAKE_CONFIG}"
