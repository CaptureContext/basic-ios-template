#!/bin/bash

SCRIPT_DIR_PATH="$( cd "$(dirname "$0")" && pwd )"

cd "${SCRIPT_DIR_PATH}/.."

WORKSPACE="Project.xcworkspace"
PROJECT="Project.xcodeproj"

DEPENDENCIES="Dependencies"
EXTENSIONS="Extensions"

rm -rf "${WORKSPACE}"
mkdir -p "${WORKSPACE}"

cat > "${WORKSPACE}/contents.xcworkspacedata" <<EOL
<?xml version="1.0" encoding="UTF-8"?>
<Workspace
   version = "1.0">
   <FileRef
      location = "group:${PROJECT}">
   </FileRef>
   <FileRef
      location = "group:${DEPENDENCIES}">
   </FileRef>
   <FileRef
      location = "group:${EXTENSIONS}">
   </FileRef>
   <FileRef
      location = "group:">
   </FileRef>
</Workspace>
EOL
