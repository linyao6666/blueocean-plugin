#!/bin/bash

SCRIPT_DIR=$(dirname $0)
$SCRIPT_DIR/stop-selenium.sh

echo ""
echo " Starting Selenium Docker container..."
echo ""
docker run -d --name blueo-selenium -p 15900:5900 -p 4444:4444 -e no_proxy=localhost selenium/standalone-chrome-debug:3.6.0-bromine > /dev/null

# Output the containers bridge network IP to file
SELENIUM_IP=`docker inspect -f '{{ .NetworkSettings.IPAddress }}' blueo-selenium`
mkdir -p ./target
echo $SELENIUM_IP > ./target/.selenium_ip

echo ""
echo "**************************************************************"
echo "**** Docker container with Selenium, browser and VNC running."
echo "****   Selenium server listening on $SELENIUM_IP:4444"
echo "****   "
echo "****   To connect and view with VNC, run:"
echo "****   $ open vnc://:secret@localhost:15900"
echo "**************************************************************"
