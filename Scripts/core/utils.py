import os

class staticproperty:
  def __init__(self, method):
    self.method = method

  def __get__(self, obj, cls=None):
    if cls is None:
      cls = type(obj)
    # Call the method without any arguments
    return self.method()
    
class Path:
  def __init__(self, path:str):
    self.path = path

  def __fspath__(self):
    return self.path
  
  def __str__(self):
    return self.path

  def parent(self):
    return Path(path=os.path.dirname(self.path))

  def appending(self, path:str):
    return Path(path=os.path.join(self.path, path))

  @staticproperty
  def root():
    return Path.scripts.parent()

  @staticproperty
  def tools_installers():
    return Path.tools.appending(".installers")
  
  @staticproperty
  def tools():
    return Path.scripts.appending(".bin")

  @staticproperty
  def scripts():
    script_path = os.path.abspath(__file__)
    script_directory = os.path.dirname(script_path)
    scripts_directory = os.path.dirname(script_directory)
    return Path(scripts_directory)
