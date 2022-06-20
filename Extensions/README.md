# Extensions

A package for core dependencies and extensions.

Stuff implemented here should be generic enough to be needed in any module of the project, adding redundant stuff may slightly increase compile time.

- LocalExtensions exports core packages and declares generic UI-independent extensions for the app
- LocalUIExtensions exports generic UI components and LocalExtensions

You can add more targets if needed for more specialized stuff that is complex and generic enough that you plan to extract it to a separate package and maybe open-source it.
