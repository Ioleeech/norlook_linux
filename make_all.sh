#!/bin/bash

# Global parameters
CURRENT_DIR="$(pwd)"

# Build parameters
MAKE_OUTPUT="${CURRENT_DIR}/output"

# Main routine
make V=1 O="${MAKE_OUTPUT}" all -C "${CURRENT_DIR}/buildroot"
