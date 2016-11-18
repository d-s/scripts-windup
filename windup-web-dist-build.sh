# Run from the directory you want to create git repos in.

readonly GH_ACCOUNT="windup"
readonly MVN_COMMAND="mvn clean install -DskipTests -X"

git clone https://github.com/$GH_ACCOUNT/windup-web.git
git clone https://github.com/$GH_ACCOUNT/windup-keycloak-tool.git
git clone https://github.com/$GH_ACCOUNT/windup-web-distribution.git

cd windup-web
$MVN_COMMAND || exit 1
cd ..

cd windup-keycloak-tool
$MVN_COMMAND || exit 1
cd ..

cd windup-web-distribution
$MVN_COMMAND || exit 1
cd ..

