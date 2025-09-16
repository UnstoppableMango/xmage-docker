# xmage-docker

A Docker container for <https://github.com/magefree/mage>.

Images are tagged as `unstoppablemango/xmage-docker` and pushed to:

- Dockerhub: [unstoppablemango/xmage-docker](https://hub.docker.com/r/unstoppablemango/xmage-docker)
- GitHub Container Registry: [ghcr.io/unstoppablemango/xmage-docker](https://github.com/UnstoppableMango/xmage-docker/pkgs/container/xmage-docker)

Apologies in advance, not a Java guy, bear with me.

## Hosting a server

<https://github.com/magefree/mage/wiki/Hosting-an-XMage-server>

### Configuration

The default configuration can be found [on GitHub](https://github.com/magefree/mage/blob/master/Mage.Server/config/config.xml).
The default configuration path within the container is `/opt/xmage/config/config.xml`.
The configuration file path can be changed by setting `XMAGE_CONFIG_PATH`.
Alternatively, the container can be configured by supplying environment variables.
These will be substituted into the xml configuration file at container start.

> [!NOTE]
> Environment variables will be replaced ONLY when using the default configuration path.
> When a custom configuration path is supplied, the startup script will not modify it.

#### Supported configuration

The values listed below are a quick reference.
For the most up-to-date documentation, refer to the [source config.xml](https://github.com/magefree/mage/blob/master/Mage.Server/release/config/config.xml) and the [startup script](./entrypoint.sh).

- `XMAGE_SERVER_ADDRESS`: ip of the XMage server. Set it to "0.0.0.0" for local host or to the IP the server should use
- `XMAGE_SERVER_NAME`
- `XMAGE_PORT`: the port the primary server socket is bound to
- `XMAGE_SECONDARY_BIND_PORT`: the port to which the secondary server socket is to be bound. if "-1" is set , an arbitrary port is selected.
- `XMAGE_BACKLOG_SIZE`: the preferred number of unaccepted incoming connections allowed at a given time. The actual number may be greater than the specified backlog. When the queue is full, further connection requests are rejected. The JBoss default value is 200
- `XMAGE_NUM_ACCEPT_THREADS`: the number of threads listening on the ServerSocket. The JBoss default value is 1
- `XMAGE_MAX_POOL_SIZE`: the maximum number of ServerThreads that can exist at any given time. The JBoss default value is 300
- `XMAGE_LEASE_PERIOD`: To turn on server side connection failure detection of remoting clients, it is necessary to satisfy two criteria. The first is that the client lease period is set and is a value greater than 0. The value is represented in milliseconds. The client lease period can be set by either the 'clientLeasePeriod' attribute within the Connector configuration or by calling the Connector method
- `XMAGE_SOCKET_WRITE_TIMEOUT`: All write operations will time out if they do not complete within the configured period.
- `XMAGE_MAX_GAME_THREADS`: Number of games that can be started simultanously on the server
- `XMAGE_MAX_SECONDS_IDLE`: Number of seconds after that a game is auto conceded by the player that was idle for such a time
- `XMAGE_MIN_USER_NAME_LENGTH`: minmal allowed length of a user name to connect to the server
- `XMAGE_MAX_USER_NAME_LENGTH`: maximal allowed length of a user name to connect to the server
- `XMAGE_INVALID_USER_NAME_PATTERN`: pattern for user name validity check
- `XMAGE_MIN_PASSWORD_LENGTH`
- `XMAGE_MAX_PASSWORD_LENGTH`
- `XMAGE_MAX_AI_OPPONENTS`: number of allowed workable AI opponents on the server (draft bots are unlimited)
- `XMAGE_SAVE_GAME_ACTIVATED`: allow game save and replay options (not working correctly yet)
- `XMAGE_AUTHENTICATION_ACTIVATED`:  "true" = user have to register to signon "false" = user need not to register
- `XMAGE_GOOGLE_ACCOUNT`: not supported currently
- `XMAGE_MAILGUN_API_KEY`: key from the mailgun domain  e.g. = "key-12121111..."
- `XMAGE_MAILGUN_DOMAIN`: domain for the mailgun message sending
- `XMAGE_MAIL_SMTP_HOST`: hostname to send the mail
- `XMAGE_MAIL_SMTP_PORT`: port to send the mail
- `XMAGE_MAIL_USER`: username used to send the mail
- `XMAGE_MAIL_PASSWORD`: password of the used user to send the mail
- `XMAGE_MAIL_FROM_ADDRESS`: sender address

## Development

### Pre-requisites

- [docker](https://docs.docker.com/engine/install/)
- [make](https://www.gnu.org/software/make/)
- [dprint](https://github.com/dprint/dprint)

### Targets

The default `make` target is `docker` which will build the server and tag it as `xmage-docker:dev`.
Additionally, it will write a tarball to [bin/image.tar](./bin/image.tar).

`make test` will run the [xmage test suite](https://github.com/magefree/mage/blob/master/.travis.yml#L11).

`make format` or `make fmt` will run [dprint](https://github.com/dprint/dprint) to format source code.

`make compose` will run the build specified by [docker-compose.yml](./docker-compose.yml) using `docker compose`.

## References

<https://github.com/goesta/docker-xmage>

## TODO

<https://github.com/magefree/mage#performance-tweaks>
