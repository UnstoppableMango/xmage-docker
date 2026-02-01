#!/usr/bin/env bash

JAVA_BIN="${JAVA_BIN:-$(which java)}"
SERVER_JAR="${SERVER_JAR:-$(find ~+ -name 'mage-server-*.jar')}"

# https://github.com/magefree/mage/blob/master/readme.md#server-options
DEFAULT_CONFIG='/opt/xmage/config/config.xml'
XMAGE_CONFIG_PATH="${XMAGE_CONFIG_PATH:-$DEFAULT_CONFIG}"

function apply_config () {
    local KEY="$1"
    local VALUE="$2"

    echo "Setting $KEY to ${VALUE:-<empty>}"
    sed -i -e "s#\($KEY=\)[\"].*[\"]#\1\"$VALUE\"#g" "${XMAGE_CONFIG_PATH}"
}

if [ "$XMAGE_CONFIG_PATH" == "$DEFAULT_CONFIG" ] && [ -f "$XMAGE_CONFIG_PATH" ]; then
  # https://github.com/magefree/mage/blob/master/Mage.Server/release/config/config.xml
  echo "Applying configuration from environment variables to ${XMAGE_CONFIG_PATH}"
  apply_config "serverAddress" "${XMAGE_SERVER_ADDRESS:-0.0.0.0}"
  apply_config "serverName" "${XMAGE_SERVER_NAME:-mage-server}"
  apply_config "port" "${XMAGE_PORT:-17171}"
  apply_config "secondaryBindPort" "${XMAGE_SECONDARY_BIND_PORT:--1}"
  apply_config "backlogSize" "${XMAGE_BACKLOG_SIZE:-200}"
  apply_config "numAcceptThreads" "${XMAGE_NUM_ACCEPT_THREADS:-2}"
  apply_config "maxPoolSize" "${XMAGE_MAX_POOL_SIZE:-300}"
  apply_config "leasePeriod" "${XMAGE_LEASE_PERIOD:-5000}"
  apply_config "socketWriteTimeout" "${XMAGE_SOCKET_WRITE_TIMEOUT:-10000}"
  apply_config "maxGameThreads" "${XMAGE_MAX_GAME_THREADS:-10}"
  apply_config "maxSecondsIdle" "${XMAGE_MAX_SECONDS_IDLE:-600}"
  apply_config "minUserNameLength" "${XMAGE_MIN_USER_NAME_LENGTH:-3}"
  apply_config "maxUserNameLength" "${XMAGE_MAX_USER_NAME_LENGTH:-14}"
  apply_config "invalidUserNamePattern" "${XMAGE_INVALID_USER_NAME_PATTERN:-[^a-z0-9_]}"
  apply_config "minPasswordLength" "${XMAGE_MIN_PASSWORD_LENGTH:-8}"
  apply_config "maxPasswordLength" "${XMAGE_MAX_PASSWORD_LENGTH:-100}"
  apply_config "maxAiOpponents" "${XMAGE_MAX_AI_OPPONENTS:-15}"
  apply_config "saveGameActivated" "${XMAGE_SAVE_GAME_ACTIVATED:-false}"
  apply_config "authenticationActivated" "${XMAGE_AUTHENTICATION_ACTIVATED:-false}"
  apply_config "googleAccount" "${XMAGE_GOOGLE_ACCOUNT:-}"
  apply_config "mailgunApiKey" "${XMAGE_MAILGUN_API_KEY:-}"
  apply_config "mailgunDomain" "${XMAGE_MAILGUN_DOMAIN:-}"
  apply_config "mailSmtpHost" "${XMAGE_MAIL_SMTP_HOST:-}"
  apply_config "mailSmtpPort" "${XMAGE_MAIL_SMTP_PORT:-}"
  apply_config "mailUser" "${XMAGE_MAIL_USER:-}"
  apply_config "mailPassword" "${XMAGE_MAIL_PASSWORD:-}"
  apply_config "mailFromAddress" "${XMAGE_MAIL_FROM_ADDRESS:-}"
fi

# Backwards compatibility
JAVA_MAX_MEMORY=${JAVA_MAX_MEMORY:-$MAX_MEMORY}
JAVA_MIN_MEMORY=${JAVA_MIN_MEMORY:-$MIN_MEMORY}

declare -a JAVA_ARGS=(
  "-Xmx${JAVA_MAX_MEMORY:-1024m}"
  "-Dxmage.config.path=$XMAGE_CONFIG_PATH"
  "-Djava.net.preferIPv4Stack=true"
)

if [ -n "$JAVA_MIN_MEMORY" ]; then
  JAVA_ARGS+=("-Xms$JAVA_MIN_MEMORY")
fi

if [ -n "$JAVA_EXTRA_ARGS" ]; then
  # Split JAVA_EXTRA_ARGS into separate arguments and append them to JAVA_ARGS
  read -r -a EXTRA_ARGS <<< "$JAVA_EXTRA_ARGS"
  JAVA_ARGS+=("${EXTRA_ARGS[@]}")
fi

cat <<EOF
JAVA_BIN:   $JAVA_BIN
SERVER_JAR: $SERVER_JAR
JAVA_ARGS:  ${JAVA_ARGS[@]}
EOF

set -x

$JAVA_BIN "${JAVA_ARGS[@]}" -jar "$SERVER_JAR"
