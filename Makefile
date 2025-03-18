include .env

PHONY: run
run:
	go build -o ./bin/app .
	./bin/app

PHONY: docker-build
docker-build:
	docker build --tag go-app .

PHONY: docker-build-multistage
docker-build-multistage:
	docker build -t go-app:multistage -f Dockerfile.multistage .

PHONY: docker-run
docker-run:
	docker run --publish ${PORT}:${PORT} --name rest-server go-app

PHONY: ls
ls:
	docker image ls

PHONY: ps
ps:
	docker ps

PHONY: retag
retag:
	docker image tag go-app:latest go-app:v2.0

PHONY: db
db:
	docker run -d \
  --name roach \
  --hostname db \
  --network mynet \
  -p 26257:26257 \
  -p ${PORT}:${PORT} \
  -v roach:/cockroach/cockroach-data \
  cockroachdb/cockroach:latest-v24.3 start-single-node \
  --insecure

# ... output omitted ...

PHONY: up
up:
	COMPOSE_BAKE=true docker compose up --build

PHONY: down
down:
	docker compose down

PHONY: test
test:
	docker build -f Dockerfile.multistage -t go-app-test --progress plain --no-cache --target run-test-stage .

DEFAULT_GOAL := docker-run