#!/bin/sh
#
# Usage:
# source unzip-windup.sh
# wuz some-windup.zip

function wuz() {
  name=${1/\.zip/}

  unzip $1
  mv windup-distribution-3.0.0-SNAPSHOT $name
  cd $name
  WINDUP_HOME=$(pwd)

  unset name
}

