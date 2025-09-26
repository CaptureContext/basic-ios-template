import os
import shutil
import textwrap
from typing import List

from .. core.utils import Path
from .. core.functions import *

class xcworkspace:
  def __init__(self, name:str, path:Path, groups:List[str]):
    self.name = name + ".xcworkspace"
    self.groups = groups
    self.path = path.appending(self.name)

  @property
  def exists(self):
    return os.path.exists(self.path)

  def generate(self):
    if self.exists:
      shutil.rmtree(self.path)
      print_info("Removed existing xcworkspace")
    os.mkdir(self.path)
    print_info("Created new xcworkspace folder")
    contents_path = self.path.appending("contents.xcworkspacedata")
    with open(contents_path, 'w') as file:
      file.write(self._make_contents())
    print_success("Generated workspace contents")
      
  def _make_contents(self):
    group_decls = ""
    for group in self.groups:
      group_decl = f"""
      <FileRef 
         location = "group:{group}">
      </FileRef>
      """
      group_decls += textwrap.dedent(group_decl).lstrip()

    contents_header = f"""
    <?xml version="1.0" encoding="UTF-8"?>
    <Workspace
       version = "1.0">
    """
    
    indented_decls = indent(group_decls, tab_width=3)

    return textwrap.dedent(contents_header).lstrip() + f"{indented_decls}" + "\n</Workspace>\n"
