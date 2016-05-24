#!/bin/sh
#
# Minimal steps to make windup-eclipse-plugin master build.
# This is meant more as documentation of required steps rather than as a script
# to automate setup, but you should be able to run this. Read before you run.
#
# There may be a way to avoid building the jbosstools projects. I just haven't
# found it yet.

SCRIPT_DIR="$(dirname $(realpath $0))"

MVN_COMMAND="mvn clean install"
MVN_COMMAND_SKIPTESTS="$MVN_COMMAND -DskipTests"

# EXECUTION STARTS HERE

git clone git@github.com:d-s/windup-eclipse-plugin.git
# If we try to build this now it won't work, so let's take a detour...

# Needs a copy of org.jboss.tools core components and parent POM.
git clone https://github.com/jbosstools/jbosstools-base
cd jbosstools-base
$MVN_COMMAND_SKIPTESTS || exit 1
cd ..

# Seems to need some things from Forge that it doesn't know how to get from a
# repo. Dependencies are managed with Tycho specifying a version range and the
# latest master is compatible. Build it with Java 8.
git clone https://github.com/jbosstools/jbosstools-forge
cd jbosstools-forge
$MVN_COMMAND_SKIPTESTS || exit 1
cd ..

# Needs a copy of latest Windup.
$SCRIPT_DIR/clone-windup.sh
$SCRIPT_DIR/build-windup.sh

# Should be able to build now.
cd windup-eclipse-plugin
$MVN_COMMAND || exit 1
