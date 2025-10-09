_ != mkdir -p bin
PROJECT := xmage-docker

DOCKER ?= docker
DPRINT ?= dprint

PLATFORM ?= linux/amd64

docker: bin/image.tar

run: docker
	$(DOCKER) run --rm -it \
	-v ./hack/db:/opt/xmage/db \
	-v ./hack/saved:/opt/xmage/saved \
	-p 17171:17171 -p 17179:17179 \
	--add-host localhost:0.0.0.0 \
	-e XMAGE_SERVER_ADDRESS=localhost \
	-e XMAGE_SECONDARY_BIND_PORT=17179 \
	${PROJECT}:dev

test:
	$(DOCKER) buildx build ${CURDIR} \
	--file Dockerfile --target test

compose:
	$(DOCKER) compose build

bin/image.tar: Dockerfile entrypoint.sh
	$(DOCKER) buildx build ${CURDIR} \
	--output type=tar,dest=$@ \
	--platform ${PLATFORM} \
	--tag ${PROJECT}:dev \
	--file $< \
	--load

format fmt:
	$(DPRINT) fmt
