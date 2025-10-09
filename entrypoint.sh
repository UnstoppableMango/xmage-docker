#!/bin/env bash

JAVA_BIN="${JAVA_BIN:-$(which java)}"
SERVER_JAR="${SERVER_JAR:-$(find ~+ -name 'mage-server-*.jar')}"

# https://github.com/magefree/mage/blob/master/readme.md#server-options
DEFAULT_CONFIG='/opt/xmage/config/config.xml'
XMAGE_CONFIG_PATH="${XMAGE_CONFIG_PATH:-$DEFAULT_CONFIG}"

if [ "$XMAGE_CONFIG_PATH" == "$DEFAULT_CONFIG" ] && [ -f "$XMAGE_CONFIG_PATH" ]; then
  # https://github.com/magefree/mage/blob/master/Mage.Server/release/config/config.xml
  XMAGE_SERVER_ADDRESS="${XMAGE_SERVER_ADDRESS:-0.0.0.0}"
  XMAGE_SERVER_NAME="${XMAGE_SERVER_NAME:-mage-server}"
  XMAGE_PORT="${XMAGE_PORT:-17171}"
  XMAGE_SECONDARY_BIND_PORT="${XMAGE_SECONDARY_BIND_PORT:--1}"
  XMAGE_BACKLOG_SIZE="${XMAGE_BACKLOG_SIZE:-200}"
  XMAGE_NUM_ACCEPT_THREADS="${XMAGE_NUM_ACCEPT_THREADS:-2}"
  XMAGE_MAX_POOL_SIZE="${XMAGE_MAX_POOL_SIZE:-300}"
  XMAGE_LEASE_PERIOD="${XMAGE_LEASE_PERIOD:-5000}"
  XMAGE_SOCKET_WRITE_TIMEOUT="${XMAGE_SOCKET_WRITE_TIMEOUT:-10000}"
  XMAGE_MAX_GAME_THREADS="${XMAGE_MAX_GAME_THREADS:-10}"
  XMAGE_MAX_SECONDS_IDLE="${XMAGE_MAX_SECONDS_IDLE:-600}"
  XMAGE_MIN_USER_NAME_LENGTH="${XMAGE_MIN_USER_NAME_LENGTH:-3}"
  XMAGE_MAX_USER_NAME_LENGTH="${XMAGE_MAX_USER_NAME_LENGTH:-14}"
  XMAGE_INVALID_USER_NAME_PATTERN="${XMAGE_INVALID_USER_NAME_PATTERN:-[^a-z0-9_]}"
  XMAGE_MIN_PASSWORD_LENGTH="${XMAGE_MIN_PASSWORD_LENGTH:-8}"
  XMAGE_MAX_PASSWORD_LENGTH="${XMAGE_MAX_PASSWORD_LENGTH:-100}"
  XMAGE_MAX_AI_OPPONENTS="${XMAGE_MAX_AI_OPPONENTS:-15}"
  XMAGE_SAVE_GAME_ACTIVATED="${XMAGE_SAVE_GAME_ACTIVATED:-false}"
  XMAGE_AUTHENTICATION_ACTIVATED="${XMAGE_AUTHENTICATION_ACTIVATED:-false}"
  XMAGE_GOOGLE_ACCOUNT="${XMAGE_GOOGLE_ACCOUNT:-}"
  XMAGE_MAILGUN_API_KEY="${XMAGE_MAILGUN_API_KEY:-}"
  XMAGE_MAILGUN_DOMAIN="${XMAGE_MAILGUN_DOMAIN:-}"
  XMAGE_MAIL_SMTP_HOST="${XMAGE_MAIL_SMTP_HOST:-}"
  XMAGE_MAIL_SMTP_PORT="${XMAGE_MAIL_SMTP_PORT:-}"
  XMAGE_MAIL_USER="${XMAGE_MAIL_USER:-}"
  XMAGE_MAIL_PASSWORD="${XMAGE_MAIL_PASSWORD:-}"
  XMAGE_MAIL_FROM_ADDRESS="${XMAGE_MAIL_FROM_ADDRESS:-}"

  echo "Applying configuration to ${XMAGE_CONFIG_PATH} from environment variables..."
  sed -i -e "s#\(serverAddress=\)[\"].*[\"]#\1\"$XMAGE_SERVER_ADDRESS\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(serverName=\)[\"].*[\"]#\1\"$XMAGE_SERVER_NAME\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(port=\)[\"].*[\"]#\1\"$XMAGE_PORT\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(secondaryBindPort=\)[\"].*[\"]#\1\"$XMAGE_SECONDARY_BIND_PORT\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(backlogSize=\)[\"].*[\"]#\1\"$XMAGE_BACKLOG_SIZE\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(numAcceptThreads=\)[\"].*[\"]#\1\"$XMAGE_NUM_ACCEPT_THREADS\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(maxPoolSize=\)[\"].*[\"]#\1\"$XMAGE_MAX_POOL_SIZE\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(leasePeriod=\)[\"].*[\"]#\1\"$XMAGE_LEASE_PERIOD\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(socketWriteTimeout=\)[\"].*[\"]#\1\"$XMAGE_SOCKET_WRITE_TIMEOUT\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(maxGameThreads=\)[\"].*[\"]#\1\"$XMAGE_MAX_GAME_THREADS\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(maxSecondsIdle=\)[\"].*[\"]#\1\"$XMAGE_MAX_SECONDS_IDLE\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(minUserNameLength=\)[\"].*[\"]#\1\"$XMAGE_MIN_USER_NAME_LENGTH\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(maxUserNameLength=\)[\"].*[\"]#\1\"$XMAGE_MAX_USER_NAME_LENGTH\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(invalidUserNamePattern=\)[\"].*[\"]#\1\"$XMAGE_INVALID_USER_NAME_PATTERN\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(minPasswordLength=\)[\"].*[\"]#\1\"$XMAGE_MIN_PASSWORD_LENGTH\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(maxPasswordLength=\)[\"].*[\"]#\1\"$XMAGE_MAX_PASSWORD_LENGTH\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(maxAiOpponents=\)[\"].*[\"]#\1\"$XMAGE_MAX_AI_OPPONENTS\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(saveGameActivated=\)[\"].*[\"]#\1\"$XMAGE_SAVE_GAME_ACTIVATED\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(authenticationActivated=\)[\"].*[\"]#\1\"$XMAGE_AUTHENTICATION_ACTIVATED\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(googleAccount=\)[\"].*[\"]#\1\"$XMAGE_GOOGLE_ACCOUNT\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(mailgunApiKey=\)[\"].*[\"]#\1\"$XMAGE_MAILGUN_API_KEY\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(mailgunDomain=\)[\"].*[\"]#\1\"$XMAGE_MAILGUN_DOMAIN\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(mailSmtpHost=\)[\"].*[\"]#\1\"$XMAGE_MAIL_SMTP_HOST\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(mailSmtpPort=\)[\"].*[\"]#\1\"$XMAGE_MAIL_SMTP_PORT\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(mailUser=\)[\"].*[\"]#\1\"$XMAGE_MAIL_USER\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(mailPassword=\)[\"].*[\"]#\1\"$XMAGE_MAIL_PASSWORD\"#g" "${XMAGE_CONFIG_PATH}"
  sed -i -e "s#\(mailFromAddress=\)[\"].*[\"]#\1\"$XMAGE_MAIL_FROM_ADDRESS\"#g" "${XMAGE_CONFIG_PATH}"
fi

declare -a JAVA_ARGS=(
  "-Xmx${MAX_MEMORY:-1024m}"
  "-Dxmage.config.path=$XMAGE_CONFIG_PATH"
  "-Djava.net.preferIPv4Stack=true"
)

if [ -n "$MIN_MEMORY" ]; then
  JAVA_ARGS+=("-Xms$MIN_MEMORY")
fi

cat <<EOF
JAVA_BIN:   $JAVA_BIN
SERVER_JAR: $SERVER_JAR
JAVA_ARGS:  ${JAVA_ARGS[@]}
EOF

set -x

$JAVA_BIN "${JAVA_ARGS[@]}" -jar "$SERVER_JAR"
