#!/bin/sh
#
# Syncs local repos and GH fork repos for core Windup projects with latest
# upstream master.
#
# Usage [from parent directory of projects to sync]: sync-forks.sh

readonly FORK_REMOTE_NAME="origin"
readonly UPSTREAM_REMOTE_NAME="upstream"
readonly PROJECTS_ORDERED="windup windup-rulesets windup-distribution"

for project in $PROJECTS_ORDERED; do
  cd $project
  git checkout master
  git pull $UPSTREAM_REMOTE_NAME master
  git push $FORK_REMOTE_NAME
  cd ..
done

