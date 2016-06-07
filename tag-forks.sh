#!/bin/sh
#
# Adds a tag to core Windup projects and pushes it to GH fork repo.
#
# Usage [from parent directory of projects]: tag-forks.sh TAG_NAME

readonly FORK_REMOTE_NAME="origin"
readonly PROJECTS_ORDERED="windup windup-rulesets windup-distribution"

if [[ -z $1 ]]; then
  echo "error: tag name is required"
  exit 1
fi

for project in $PROJECTS_ORDERED; do
  cd $project
  git checkout master
  git tag -a $1 -m $1
  git push $FORK_REMOTE_NAME $1
  cd ..
done

