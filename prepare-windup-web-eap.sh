# To be run from windup-web base directory.

readonly EAP_BASE_DIR="/home/dansmit/eap/jboss-eap-7.0-b"
readonly EAP_SETUP_SCRIPT="./scripts/eap-setup.cli"

$EAP_BASE_DIR/bin/jboss-cli.sh --connect "run-batch --file=$EAP_SETUP_SCRIPT"

