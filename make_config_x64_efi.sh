#!/bin/bash

# Global parameters
CURRENT_DIR="$(pwd)"

# Build parameters
MAKE_OUTPUT="${CURRENT_DIR}/output"
MAKE_CONFIG="norlook_x64_efi_defconfig"

# Main routine
cp -f "${CURRENT_DIR}/${MAKE_CONFIG}" "${CURRENT_DIR}/buildroot/configs/${MAKE_CONFIG}"
make V=1 O="${MAKE_OUTPUT}" "${MAKE_CONFIG}" -C "${CURRENT_DIR}/buildroot"
