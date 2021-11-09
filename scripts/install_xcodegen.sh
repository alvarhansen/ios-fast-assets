#!/bin/sh
set -e

OUTPUT_DIR=".tools/xcodegen"

recursive_directory_hash () {
  # For all files in output directory, calculate their hash and finally hash all these together into single hash
  find "$OUTPUT_DIR" -type f -not -name '.DS_Store' -print0 2> /dev/null | xargs -0 shasum | shasum | awk '{print $1}'
}

CURRENT_HASH=`recursive_directory_hash`
EXPECTED_HASH="6b8e5babc3ecf26a01efd32d15e28fd1a206ccdf"

if [[ $CURRENT_HASH != $EXPECTED_HASH ]]; then
  if [ -d "$OUTPUT_DIR" ]; then rm -r "$OUTPUT_DIR"; fi
  mkdir -p "$OUTPUT_DIR"
  curl -L "https://github.com/yonaskolb/XcodeGen/releases/download/2.21.0/xcodegen.zip" -o ".tools/xcodegen.zip"
  unzip ".tools/xcodegen.zip" -d ".tools/"
  rm ".tools/xcodegen.zip"

  INSTALLED_HASH=`recursive_directory_hash`
  echo "Installed XcodeGen with final hash $INSTALLED_HASH"
  if [[ $INSTALLED_HASH != $EXPECTED_HASH ]]; then
    echo "Error, installed tool hash does not match expected hash."
    exit 1
  else
    "$OUTPUT_DIR/bin/xcodegen" --version
  fi
else
  echo "No XcodeGen install needed"
fi
