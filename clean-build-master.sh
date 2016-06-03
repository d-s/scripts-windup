#!/bin/sh
#
# Clones all Windup projects from the latest master and does a clean build.
#
# Usage [from empty parent directory of projects to be created]:
# clean-build-windup.sh OUTPUT_PATH

if [[ -z $1 ]]; then
  echo "error: output path is required"
  exit 1
fi
readonly OUTPUT_PATH=$1

readonly SCRIPT_DIR="$(dirname $(realpath $0))"

$SCRIPT_DIR/clone-windup.sh windup || exit 1  # Clone upstream windup master.
$SCRIPT_DIR/build-windup.sh $OUTPUT_PATH || exit 1

