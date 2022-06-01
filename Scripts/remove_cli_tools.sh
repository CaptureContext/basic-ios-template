#!/bin/bash

# IMPORTS
SCRIPT_DIR_PATH="$( cd "$(dirname "$0")" && pwd )"
source "${SCRIPT_DIR_PATH}/.core/constants.sh"

# ––––––––––––––––––––––––––– SCRIPT –––––––––––––––––––––––––––

rm -rf "${TOOLS_INSTALL_PATH}"
