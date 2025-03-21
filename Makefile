include .env

PHONY: run
run:
	go build -o ./bin/app .
	./bin/app