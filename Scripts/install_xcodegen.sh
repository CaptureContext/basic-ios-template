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

# CONSTANTS
TOOL_DOWNLOAD_DIR="${TOOLS_INSTALL_PATH}/${TOOL_NAME}-installer"

# CLEAN UP
trap clean_up err exit SIGTERM SIGINT
clean_up() {
  if [ -d "${TOOL_DOWNLOAD_DIR}" ]; then rm -rf "${TOOL_DOWNLOAD_DIR}"; fi
}

# ––––––––––––––––––––––––––– SCRIPT –––––––––––––––––––––––––––

if $( is_installed xcodegen ); then
  print_warning "${TOOL_NAME} already installed"
  exit ${SUCCESS_CODE}
fi

force_cd "${TOOL_DOWNLOAD_DIR}"

print ⬇️ "Fetching ${TOOL_NAME}..."
git clone "https://github.com/${TOOL_OWNER}/${TOOL_NAME}.git"
cd "${TOOL_NAME}"

print 🔨 "Building and Installing ${TOOL_NAME}..."
make install

print_success "${TOOL_NAME} successfully installed"