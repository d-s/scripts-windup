# To be run from windup-web base directory.

EAP_BASE_DIR="/home/dansmit/eap/jboss-eap-7.0-b"
EAP_DEPLOYMENTS_DIR="$EAP_BASE_DIR/standalone/deployments"

WINDUP_WEB_SERVICES_EXPLODED="services/target/windup-web-services"
WINDUP_WEB_EXPLODED="ui/target/windup-web"

cp -r $WINDUP_WEB_SERVICES_EXPLODED $EAP_DEPLOYMENTS_DIR/windup-web-services.war
cp -r $WINDUP_WEB_EXPLODED $EAP_DEPLOYMENTS_DIR/windup-web.war

touch $EAP_DEPLOYMENTS_DIR/windup-web-services.war.dodeploy
touch $EAP_DEPLOYMENTS_DIR/windup-web.war.dodeploy

