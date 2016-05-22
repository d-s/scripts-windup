#!/bin/sh
#
# Minimal steps to make windup-eclipse-plugin master build as of 20160521.
# This is meant more as documentation of required steps rather than as a script
# to automate setup, but you should be able to run this without hurting
# anything. Read the whole thing before you run.
#
# If I omit building any of these things it doesn't work. No doubt there's a way
# to build less of these projects and get the artifacts we need, but I'm not a
# Maven maven.


# CONFIG

# Replace these paths with something that exists on your own system.
JAVA_7="/home/dansmit/lib/jvm/jdk1.7.0_79"
JAVA_8="/home/dansmit/lib/jvm/jdk1.8.0_77"

MVN_COMMAND="mvn clean install -DskipTests"

# EXECUTION STARTS HERE

git clone git@github.com:d-s/windup-eclipse-plugin.git
# If we try to build this now it won't work, so let's take a detour...

# Needs a 4.3.0.Alpha2-SNAPSHOT copy of org.jboss.tools parent POM.
git clone https://github.com/jbosstools/jbosstools-base
cd jbosstools-base
git checkout jbosstools-4.3.0.Alpha2
$MVN_COMMAND || exit 1
cd ..

# Seems to need some things from Forge that it doesn't know how to get from a
# repo. Dependencies are managed with Tycho specifying a version range and the
# latest master is compatible. Build it with Java 8.
git clone https://github.com/jbosstools/jbosstools-forge
cd jbosstools-forge
JAVA_HOME=$JAVA_8
$MVN_COMMAND || exit 1
cd ..

# Also needs a 2.3.1-SNAPSHOT build of windup core. Use Java 7, 8 won't work.
git clone git@github.com:d-s/windup.git
cd windup
git checkout 9642fc8  # First SHA at 2.3.1-SNAPSHOT.
# Build can't seem to find 6.0.WINDUP version of maven-indexer, fetch manually.
mkdir -p ~/.m2/repository/org/apache/maven/indexer/indexer-core/6.0.WINDUP
wget -O ~/.m2/repository/org/apache/maven/indexer/indexer-core/6.0.WINDUP/indexer-core-6.0.WINDUP.jar https://repository.jboss.org/nexus/content/repositories/root_repository/org/apache/maven/indexer/indexer-core/6.0.WINDUP/indexer-core-6.0.WINDUP.jar || exit 1
JAVA_HOME=$JAVA_7
$MVN_COMMAND || exit 1
cd ..

git clone git@github.com:d-s/windup-rulesets.git
cd windup-rulesets
git checkout 7270a10  # First SHA at 2.3.1-SNAPSHOT.
JAVA_HOME=$JAVA_7
$MVN_COMMAND || exit 1
cd ..

git clone git@github.com:d-s/windup-distribution.git
cd windup-distribution
git checkout b72c88e  # First SHA at 2.3.1-SNAPSHOT.
JAVA_HOME=$JAVA_7
$MVN_COMMAND || exit 1
cd ..
# Note to self -- put this 2.3.1-SNAPSHOT distribution somewhere so someone can
# yank it if they like rather than building their own to make the plugin work?

# Now we should be able to build.
cd windup-eclipse-plugin
$MVN_COMMAND || exit 1

# I get failures if I try to run the tests. I'll look into that later after I
# try installing the thing in Eclipse.

