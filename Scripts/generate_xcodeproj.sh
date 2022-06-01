#!/bin/bash

# IMPORTS
SCRIPT_DIR_PATH="$( cd "$(dirname "$0")" && pwd )"
source "${SCRIPT_DIR_PATH}/.core/functions.sh"
source "${SCRIPT_DIR_PATH}/.core/constants.sh"

# CONSTANTS
TOOL="xcodegen"

# ––––––––––––––––––––––––––– SCRIPT –––––––––––––––––––––––––––

if ! $( is_installed "${TOOL}" ); then "${SCRIPT_DIR_PATH}/install_xcodegen.sh"; fi

"$TOOL" generate

print_success "Did generate xcoderoj"
