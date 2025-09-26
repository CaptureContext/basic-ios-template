# Imports

import shutil
import subprocess
import textwrap

from . constants import Style, ExitCode, Icon
from . utils import Path

# Functions

def pretty_print(
    icon:Icon,
    style:Style,
    *texts:str
):
  message = " ".join(str(text) for text in texts)
  print(f"{icon} {style}{message}{Style.reset}")

def print_info(text):
  pretty_print(Icon.info, Style.bold + Style.purple, text)

def print_success(text):
  pretty_print(Icon.success, Style.bold + Style.green, text)

def print_warning(text):
  pretty_print(Icon.warning, Style.bold + Style.yellow, text)

def print_error(text):
  pretty_print(Icon.error, Style.bold + Style.red, text)

def is_installed(tool, local=True):
  if local:
    return shutil.which(Path.tools.appending(tool).path) is not None
  else:
    try:
      subprocess.run(
        "which " + tool,
        shell=True
      )
      return True
    except:
      return False


def install_brew_if_needed():
  if is_installed("brew"):
    return ExitCode.success
  else:
    try: 
      subprocess.run(
        "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"",
        shell=True
      )
    except:
      print_error("COULDN'T INSTALL HOMEBREW")
      return ExitCode.error
  return ExitCode.success

def build_swift_product(product_name):
  if not product_name:
    print_error("PRODUCT NAME SHOULD BE PASSED")
    return ExitCode.error
  try:
    command = [
      "swift", "build", "--product", product_name,
      "-c", "release", "--disable-sandbox", "--build-path", ".build"
    ]
    subprocess.run(command, check=True)
  except subprocess.CalledProcessError as e:
    print_error("Failed to build the product")
    return ExitCode.error
  return ExitCode.success

def indent(text:str, level:int=1, tab_width:int=2, tab_char:str=" "):
  lines = text.splitlines()
  
  # Add indentation
  indented_lines = [(tab_char * tab_width * level) + line for line in lines]
  
  # Join the lines back into a single string
  return '\n'.join(indented_lines)
