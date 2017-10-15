
down:
	docker-compose down

up: down build
	docker-compose up -d
	docker-compose ps

build:
	docker build -t study:latest -f Dockerfile .

run: build
	docker run study:latest
