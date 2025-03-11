PHONY: docker-build
docker-build:
	docker build --tag go-app .

PHONY: docker-build-multistage
docker-build-multistage:
	docker build -t go-app:multistage -f Dockerfile.multistage .

PHONY: docker-run
docker-run:
	docker run --publish 8080:8080 --name server go-app

PHONY: ls
ls:
	docker image ls

PHONY: ps
ps:
	docker ps

PHONY: retag
retag:
	docker image tag go-app:latest go-app:v2.0

DEFAULT_GOAL := docker-run