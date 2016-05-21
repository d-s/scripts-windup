#!/bin/sh
#
# Prints all directories under $1 and the number of Windup XML rules in each.
#
# Usage: count_rules.sh $WINDUP_HOME/rules
#
# Directories will be printed in the order find returns them, formatted such that you
# can pipe to sort -n or sort -nr to get an ascending/descending numerical sort. 

readonly ROOT_DIR=$1

for subdir in $(find $ROOT_DIR -type d); do
  num=$(find $subdir -name *.windup.xml | xargs grep "<rule " | wc -l)
  echo $num $subdir
done

# Original one-liner (for posterity):
# tf=$(mktemp) && echo "num_rules=\$(find \$1 -name *.windup.xml | xargs grep \"<rule \" | wc -l); echo \$num_rules \$1" > $tf && chmod +x $tf && find . -type d | xargs -n 1 $tf | sort -n # from WINDUP_HOME/rules

