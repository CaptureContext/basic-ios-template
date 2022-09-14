# !/bin/bash

set -e

# –––––––––––––––––––––––– ENABLE TO DEBUG ––––––––––––––––––––––––

# set -x

# –––––––––––––––––––––––––– DECLARATIONS –––––––––––––––––––––––––

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BOLD="\033[1m"
PURPLE="\033[95m"
RESET="\033[0m"

ERROR_CODE=1
SUCCESS_CODE=0

# ––––––––––––––––––––––––––– ASSERTIONS –––––––––––––––––––––––––

if [ "${BASH_SOURCE[0]}" -ef "$0" ]; then 
  echo -e "\n❌ ${RED}This script can only be used for sourcing${RESET}"
  exit ${ERROR_CODE}
fi

# ––––––––––––––––––––––––––– FUNCTIONS –––––––––––––––––––––––––––

function print() {
  if [ -z "$2" ]; then 
    local text="$1"
    echo -e "\n${text}\n" 
    return $SUCCESS_CODE
  fi
  local emoji="$1"
  local text="$2"
  echo -e "\n${emoji}  ${text}\n"
}

function print_info() {
  echo -e "\nℹ️  ${BOLD}${PURPLE}${1}${RESET}\n"
}

function print_success() {
  echo -e "\n✅ ${BOLD}${GREEN}${1}${RESET}\n" 
}

function print_warning() {
  echo -e "\n⚠️  ${BOLD}${YELLOW}${1}${RESET}\n"
}

function print_error() {
  echo -e "\n❌ ${BOLD}${RED}${1}${RESET}\n"
}

function _print_info() {
  echo -e "ℹ️  ${BOLD}${PURPLE}${1}${RESET}"
}

function _print_success() {
  echo -e "✅ ${BOLD}${GREEN}${1}${RESET}"
}

function _print_warning() {
  echo -e "⚠️  ${BOLD}${YELLOW}${1}${RESET}"
}

function _print_error() {
  echo -e "❌ ${BOLD}${RED}${1}${RESET}"
}

function is_installed() {
  [ `command -v "$1"` 2>/dev/null ] && echo true || echo false
}

function install_brew_if_needed() {
  if $( is_installed "brew" ); then return 0; fi
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function build_swift_product() {
  local product_name="$1"
  if [ -z "$product_name" ]; then
    print_error "PRODUCT NAME SHOULD BE PASSED"
    return $ERROR_CODE
  fi
  swift build --product=$product_name -c release --disable-sandbox --build-path '.build'
}

function force_cd() {
  if [ -z "$1" ]; then
    print_error "DIRECTORY NAME SHOULD BE PASSED"
    return $ERROR_CODE
  fi
  local directory="$1"
  cd $directory 2>/dev/null || mkdir -p $directory && cd $directory
}

function mkdir_if_needed() {
  if [ -z "$1" ]; then
    print_error "DIRECTORY NAME SHOULD BE PASSED"
    return $ERROR_CODE
  fi
  local directory="$1"
  if [ -d "$directory" ]; then return $SUCCESS_CODE; fi
  mkdir "$directory"
}
