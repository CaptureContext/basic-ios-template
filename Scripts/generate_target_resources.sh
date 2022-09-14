#!/bin/bash

# IMPORTS
SCRIPT_DIR_PATH="$( cd "$(dirname "$0")" && pwd )"
source "${SCRIPT_DIR_PATH}/.core/functions.sh"
source "${SCRIPT_DIR_PATH}/.core/constants.sh"

# CONSTANTS
TOOL="${TOOLS_INSTALL_PATH}/spmgen"

TARGET_FOLDER_NAME=$1

# ––––––––––––––––––––––––––– SCRIPT –––––––––––––––––––––––––––

if ! $( is_installed "${TOOL}" ); then "${SCRIPT_DIR_PATH}/install_spmgen.sh"; fi

"$TOOL" resources "${SCRIPT_DIR_PATH}/../Sources/${TARGET_FOLDER_NAME}/Resources" \
  --output "${SCRIPT_DIR_PATH}/../Sources/${TARGET_FOLDER_NAME}/Resources.generated.swift" \
  --indentor " " \
  --tab-size 2

echo ""
_print_success "Did generate resources for Sources/${TARGET_FOLDER_NAME}"
