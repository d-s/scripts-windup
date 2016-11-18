# Assumes you're running RH Linux. Should give you an idea of what you need to
# run though.


# Let's see what we already have installed.
set -x
cat /etc/redhat-release
which javac
mvn --version | head -1
node --version
npm --version
bower --version
set +x


# Install stuff, maybe.
echo "install stuff? (y/n)"
read install_stuff
if [[ $install_stuff == "y" ]]; then
  # Add EPEL (RHEL only.)
  rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm

  # OK, let's install stuff. (You probably need to be running as root.)
  yum install nodejs
  yum install npm
  npm install -g npm
  npm install -g bower
fi


# You should have what you need to go ahead and build now.
# If you run into errors building, it's probably related to the version of
# something...
