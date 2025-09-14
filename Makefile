_ != mkdir -p bin
PROJECT := xmage-docker

DOCKER ?= docker
DPRINT ?= dprint

docker: bin/image.tar
compose:
	$(DOCKER) compose build .

bin/image.tar: Dockerfile
	$(DOCKER) buildx build ${CURDIR} \
	--file $< \
	--output type=tar,dest=$@ \
	--output type=image,name=${PROJECT}

format fmt:
	$(DPRINT) fmt
