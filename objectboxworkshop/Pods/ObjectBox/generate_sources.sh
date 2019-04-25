#!/bin/bash

set -e

sourcery="$PODS_ROOT/ObjectBox/Sourcery.app/Contents/MacOS/Sourcery"

if [ -f "$sourcery" ]; then
  "$sourcery" --xcode-project "${PROJECT_FILE_PATH}" --xcode-target "${TARGETNAME}" --xcode-module "${PRODUCT_MODULE_NAME}"
else
  echo "error: Cannot find Sourcery in the expected location at '$sourcery'"
  exit 1
fi
