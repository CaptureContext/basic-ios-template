from . utils import staticproperty

__all__ = [
  "ExitCode",
  "Paths"
]

class Style:
  def __init__(self, raw_value):
    self.raw_value = raw_value

  def __str__(self):
    return self.raw_value

  def __add__(self, other):
    if isinstance(other, Style):
      return Style(self.raw_value + other.raw_value)
    return NotImplemented

  @staticproperty
  def bold():
    return Style("\033[1m")
  
  @staticproperty
  def red():
    return Style("\033[31m")
  
  @staticproperty
  def green():
    return Style("\033[32m")
  
  @staticproperty
  def yellow():
    return Style("\033[33m")
  
  @staticproperty
  def purple():
    return Style("\033[95m")
  
  @staticproperty
  def reset():
    return Style("\033[0m")

class ExitCode:
  success = 0
  error = 1

class Icon: 
  info = "ℹ️ "
  success = "✅"
  error = "❌"
  warning = "⚠️"
