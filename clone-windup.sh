#!/bin/sh
#
# Clones all projects needed to work on core Windup and adds upstream remotes.
#
# Usage [from parent directory of projects to be created]: clone-windup.sh

readonly ORIGIN_ACCOUNT="d-s"  # Replace with yourself.
readonly UPSTREAM_ACCOUNT="windup"
readonly PROJECTS_ORDERED="windup windup-rulesets windup-distribution"

for project in $PROJECTS_ORDERED; do
  git clone git@github.com:$ORIGIN_ACCOUNT/${project}.git
  cd $project
  git remote add upstream https://github.com/$UPSTREAM_ACCOUNT/${project}.git
  cd ..
done

