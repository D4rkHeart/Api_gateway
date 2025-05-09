
.PHONY: up build down logs clean clean-volumes install test

up:
	docker compose up -d

build:
	docker compose up --build -d

down:
	docker compose down

logs:
	docker compose logs -f

clean:
	docker compose down

clean-volumes:
	docker compose down -v

install:
	pip install -r services/catalogue/requirements.txt || true

test:
	bash test_catalogue.sh
