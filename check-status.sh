#!/bin/sh
#
# Runs "git status" for all core Windup projects.
#
# Usage [from parent directory of projects]: check-status.sh

readonly PROJECTS_ORDERED="windup windup-rulesets windup-distribution"

for project in $PROJECTS_ORDERED; do
  cd $project
  echo "repo: $project"
  git status
  cd ..
done

