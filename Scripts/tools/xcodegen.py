import os
import subprocess

from .. core.functions import *
from .. core.utils import staticproperty, Path

class xcodegen:
  _tool_name = "xcodegen"
  _tool_owner = "yonaskolb"

  @staticproperty
  def is_installed():
    return is_installed(xcodegen._tool_name)

  @staticmethod
  def install():
    if xcodegen.is_installed:
      print_warning(f"{xcodegen._tool_name} is already installed")
      return ExitCode.success
    try:
      # todo: install locally?
      subprocess.run(['brew', 'install', xcodegen._tool_name], check=True)
      print_success(f"{xcodegen._tool_name} installed successfully")
      return ExitCode.success
    except subprocess.CalledProcessError as e:
      print(f"Failed to install {xcodegen._tool_name}: {e}")
      return ExitCode.error
  
  @staticmethod
  def generate_xcodeproj():
    try:
      subprocess.run([xcodegen._tool_name, "generate"], check=True)
      # subprocess.run([Path.tools.appending(xcodegen._tool_name).path, "generate"], check=True)
      print_success("Did generate xcodeproj")
    except subprocess.CalledProcessError as e:
      print_error(f"Failed to generate xcodeproj: {e}")
      return ExitCode.error
    return ExitCode.success

