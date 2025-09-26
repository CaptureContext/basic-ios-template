from . tools.xcodegen import *
from . core.utils import *

if not xcodegen.is_installed:
  xcodegen.install()
xcodegen.generate_xcodeproj()
