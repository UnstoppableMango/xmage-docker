_ != mkdir -p bin
PROJECT := xmage-docker

DOCKER ?= docker
DPRINT ?= dprint

docker: bin/image.tar
compose:
	$(DOCKER) compose build .

bin/image.tar: Dockerfile
	$(DOCKER) buildx build ${CURDIR} \
	--output type=tar,dest=$@ \
	--file $< \
	--load \
	--tag ${PROJECT}:dev

format fmt:
	$(DPRINT) fmt
