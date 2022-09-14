#!/bin/bash

# ––––––––––––––––––––––––––– ASSERTIONS –––––––––––––––––––––––––

if [ "${BASH_SOURCE[0]}" -ef "$0" ]; then 
  echo -e "\n❌ ${RED}This script can only be used for sourcing${RESET}"
  exit $ERROR_CODE 
fi

# ––––––––––––––––––––––––––– CONSTANTS –––––––––––––––––––––––––

TOOLS_INSTALL_PATH="$( cd "$(dirname "$0")" && pwd )/.bin"
INSTALLERS_PATH="${TOOLS_INSTALL_PATH}/.installers"
