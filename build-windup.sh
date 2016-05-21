#!/bin/sh
#
# Builds all projects needed to create a windup-distribution archive.
#
# Usage [from parent directory of projects]: build-windup.sh [output-dir]
#
# Execution will terminate early if any builds fail.

readonly PROJECTS_ORDERED="windup windup-rulesets windup-distribution"
readonly MVN_COMMAND="mvn install -DskipTests"

readonly WORKING_DIR="$(pwd)"

giveup() {
  cd $WORKING_DIR
  exit $1
}

for project in $PROJECTS_ORDERED; do
  if [[ -z $(ls | grep -x $project) ]]; then
    echo "error: expected project $project is not present"
    giveup 1
  fi
done

for project in $PROJECTS_ORDERED; do
  cd $project
  $MVN_COMMAND || giveup 2
  cd ..
done

if [[ -z $1 ]]; then
  exit 0  # Done: no destination dir provided to copy output archive to.
fi

readonly ORIG_OUTPUT_DIR="$WORKING_DIR/windup-distribution/target"
readonly ORIG_OUTPUT_FILE="windup-distribution-.*-offline.zip"
readonly FILENAME="$(ls $ORIG_OUTPUT_DIR | grep -x $ORIG_OUTPUT_FILE)"
readonly NUM_MATCHES="$(echo $FILENAME | wc -l)"
if [[ $NUM_MATCHES -ne 1 ]]; then
  echo "error: expected exactly one file matching $ORIG_OUTPUT_FILE"
  echo "error: found $NUM_MATCHES: $(echo $FILENAME | tr "\n" " ")"
  giveup 3
fi

echo "copying output archive to $1/$FILENAME"
cp $ORIG_OUTPUT_DIR/$FILENAME $1

