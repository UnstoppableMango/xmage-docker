#!/bin/bash

# https://github.com/goesta/docker-xmage/blob/master/dockerStartServer.sh
XMAGE_CONFIG=/opt/xmage/server/config/config.xml

sed -i -e "s#\(serverAddress=\)[\"].*[\"]#\1\"$XMAGE_SERVER_ADDRESS\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(serverName=\)[\"].*[\"]#\1\"$XMAGE_SERVER_NAME\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(port=\)[\"].*[\"]#\1\"$XMAGE_PORT\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(secondaryBindPort=\)[\"].*[\"]#\1\"$XMAGE_SECONDARY_BIND_PORT\"#g" ${XMAGE_CONFIG}

exec /opt/xmage/server/startServer.sh
