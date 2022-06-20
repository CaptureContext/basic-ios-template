#!/bin/bash

# Temporary xcodegen is installed globally
# TODO: Implement local installation

# IMPORTS
SCRIPT_DIR_PATH="$( cd "$(dirname "$0")" && pwd )"
source "${SCRIPT_DIR_PATH}/.core/functions.sh"
source "${SCRIPT_DIR_PATH}/.core/constants.sh"

# CONFIG
TOOL_NAME="xcodegen"
TOOL_OWNER="yonaskolb"

# ––––––––––––––––––––––––––– SCRIPT –––––––––––––––––––––––––––

if $( is_installed xcodegen ); then
  print_warning "${TOOL_NAME} already installed"
  exit ${SUCCESS_CODE}
fi

brew install ${TOOL_NAME}

print_success "${TOOL_NAME} successfully installed"