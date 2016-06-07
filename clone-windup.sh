#!/bin/sh
#
# Clones all projects needed to work on core Windup and adds upstream remotes.
#
# Usage [from parent directory of projects to be created]:
# clone-windup.sh ORIGIN_ACCOUNT
#
# Scripts that want to do something with the latest master can pass "windup" for
# ORIGIN_ACCOUNT.

if [[ -z $1 ]]; then
  echo "error: github origin account is required"
  exit 1
fi

readonly ORIGIN_ACCOUNT=$1
readonly UPSTREAM_ACCOUNT="windup"
readonly PROJECTS_ORDERED="windup windup-rulesets windup-distribution"

for project in $PROJECTS_ORDERED; do
  # Use https:// path for remotes pointing to the upstream repo so it's not so
  # easy to accidentally push to it (since you'll be prompted for a password.)
  origin_remote_path="https://github.com/$ORIGIN_ACCOUNT/${project}.git"
  if [[ $ORIGIN_ACCOUNT != $UPSTREAM_ACCOUNT ]]; then
    origin_remote_path="git@github.com:$ORIGIN_ACCOUNT/${project}.git"
  fi

  git clone $origin_remote_path
  cd $project
  git remote add upstream https://github.com/$UPSTREAM_ACCOUNT/${project}.git
  cd ..
done

