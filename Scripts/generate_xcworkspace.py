from . tools.xcworkspace import *
from . core.utils import *

xcworkspace(
  name="Project",
  path=Path.root,
  groups=[
    "Project.xcodeproj",
    "Dependencies",
    "Extensions",
    "."
  ]
).generate()
