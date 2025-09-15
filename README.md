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

## Development

### Pre-requisites

- [docker](https://docs.docker.com/engine/install/)
- [make](https://www.gnu.org/software/make/)
- [dprint](https://github.com/dprint/dprint)

The default `make` target is `docker` which will build the server and tag it as `xmage-docker:dev`.
Additionally, it will write a tarball to [bin/image.tar](./bin/image.tar).

`make test` will run the [xmage test suite](https://github.com/magefree/mage/blob/master/.travis.yml#L11).

`make format` or `make fmt` will run [dprint](https://github.com/dprint/dprint) to format source code.

`make compose` will run the build specified by [docker-compose.yml](./docker-compose.yml) using `docker compose`.

## References

<https://github.com/goesta/docker-xmage>

## TODO

<https://github.com/magefree/mage#performance-tweaks>
