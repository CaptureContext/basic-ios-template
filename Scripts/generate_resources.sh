#!/bin/bash

# IMPORTS
SCRIPT_DIR_PATH="$( cd "$(dirname "$0")" && pwd )"
source "${SCRIPT_DIR_PATH}/.core/functions.sh"
source "${SCRIPT_DIR_PATH}/.core/constants.sh"

# FUNCTIONS
function generate_resources() {
  local target_folder_name="$1"
  if [ -z "$target_folder_name" ]; then
    print_error "PRODUCT NAME SHOULD BE PASSED"
    return $ERROR_CODE
  fi
  ${SCRIPT_DIR_PATH}/generate_target_resources.sh ${target_folder_name}
}

# RESOURCES GENERATION
generate_resources "Resources"
generate_resources "MainFeature"
