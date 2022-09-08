#!/bin/bash

# IMPORTS
SCRIPT_DIR_PATH="$( cd "$(dirname "$0")" && pwd )"
source "${SCRIPT_DIR_PATH}/.core/functions.sh"
source "${SCRIPT_DIR_PATH}/.core/constants.sh"

# CONSTANTS
TOOL="${TOOLS_INSTALL_PATH}/spmgen"

# ––––––––––––––––––––––––––– SCRIPT –––––––––––––––––––––––––––

if ! $( is_installed "${TOOL}" ); then "${SCRIPT_DIR_PATH}/install_spmgen.sh"; fi

"$TOOL" resources "${SCRIPT_DIR_PATH}/../Sources/Resources/Resources" \
  --output "${SCRIPT_DIR_PATH}/../Sources/Resources/Resources.generated.swift" \
  --indentor " " \
  --tab-size 2

print_success "Did generate resources"
