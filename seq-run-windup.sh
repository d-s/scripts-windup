#!/bin/sh
#
# Usage:
#   Update params below to what you want, then:
#   ls -d1 dir-containing-apps | seq-run-windup.sh 

readonly WINDUP_BIN="./bin/windup"
readonly OUTPUT_BASE="/home/dansmit/wrep/3.0.0-master-0131/target-eap6"
readonly EXTRA_ARGS="--target eap:6 --batchMode"

set -x

while read input_path
do
  time ${WINDUP_BIN} --input ${input_path} \
      --output ${OUTPUT_BASE}/$(basename ${input_path}) ${EXTRA_ARGS}
done < "${1:-/dev/stdin}"

