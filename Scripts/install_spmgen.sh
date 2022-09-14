#!/bin/bash

# TODO: Support aliasing for local installations

# IMPORTS
SCRIPT_DIR_PATH="$( cd "$(dirname "$0")" && pwd )"
source "${SCRIPT_DIR_PATH}/.core/functions.sh"
source "${SCRIPT_DIR_PATH}/.core/constants.sh"

# CONFIG
TOOL_NAME="spmgen"
TOOL_OWNER="capturecontext"
TOOL_VERSION="2.1.1"

# CONSTANTS
TOOL_INSTALL_PATH="${TOOLS_INSTALL_PATH}/${TOOL_NAME}-tmp"
TOOL_DOWNLOAD_DIR="${TOOLS_INSTALL_PATH}/${TOOL_NAME}-installer"

# CLEAN UP
trap clean_up err exit SIGTERM SIGINT
clean_up() { 
  rm -rf "${TOOL_INSTALL_PATH}"
  if [ -d "${TOOL_DOWNLOAD_DIR}" ]; then rm -rf "${TOOL_DOWNLOAD_DIR}"; fi
}

# ––––––––––––––––––––––––––– SCRIPT –––––––––––––––––––––––––––

if $( is_installed "${TOOLS_INSTALL_PATH}/${TOOL_NAME}" ); then
  print_warning "${TOOL_NAME} already installed"
  exit ${SUCCESS_CODE}
fi

force_cd "${TOOL_DOWNLOAD_DIR}"

print ⬇️ "Fetching ${TOOL_NAME}..."
git clone "https://github.com/${TOOL_OWNER}/${TOOL_NAME}.git"
cd "${TOOL_NAME}"

print 🔧 "Switching to specified version..."
git fetch --all --tags
git checkout tags/${TOOL_VERSION} -b local

print 🔨 "Building ${TOOL_NAME}..."
build_swift_product "${TOOL_NAME}"

print ♻️ "Installing ${TOOL_NAME}..."
mkdir_if_needed "${TOOL_INSTALL_PATH}"
install "./.build/release/${TOOL_NAME}" "${TOOL_INSTALL_PATH}"
rm -rf "${TOOL_DOWNLOAD_DIR}"
mv "${TOOL_INSTALL_PATH}/${TOOL_NAME}" "${TOOLS_INSTALL_PATH}"

print_success "${TOOL_NAME} successfully installed"
