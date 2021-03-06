#!/bin/bash

# Global parameters
CURRENT_DIR="$(pwd)"

# Build parameters
MAKE_OUTPUT="${CURRENT_DIR}/output"
MAKE_TOPDIR="${CURRENT_DIR}/buildroot"
MAKE_EXTERNAL="${CURRENT_DIR}/norlook"

# Main routine
make V=1 O="${MAKE_OUTPUT}" all -C "${MAKE_TOPDIR}" BR2_EXTERNAL="${MAKE_EXTERNAL}"
