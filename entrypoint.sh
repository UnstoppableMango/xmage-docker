#!/bin/env bash

# https://github.com/magefree/mage/blob/master/readme.md#server-options

DEFAULT_CONFIG='/opt/xmage/config/config.xml'

JAVA_BIN="${JAVA_BIN:-$(which java)}"
SERVER_JAR="${SERVER_JAR:-$(find ~+ -name 'mage-server-*.jar')}"
CONFIG_PATH="${CONFIG_PATH:-$DEFAULT_CONFIG}"

declare -a JAVA_ARGS=('-Xmx1024m' "-Dxmage.config.path=$CONFIG_PATH")

cat <<EOF
JAVA_BIN:    $JAVA_BIN
SERVER_JAR:  $SERVER_JAR
CONFIG_PATH: $CONFIG_PATH
JAVA_ARGS:   ${JAVA_ARGS[@]}

EOF

set -x

$JAVA_BIN "${JAVA_ARGS[@]}" -jar "$SERVER_JAR"
