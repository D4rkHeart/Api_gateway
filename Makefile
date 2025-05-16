
.PHONY: up build down logs clean clean-volumes install test

init:
	docker build -t i321/commandes_service ./services/commande/i321
	docker build -t i321/catalogue_service ./services/catalogue

up:
	docker stack -c docker-compose.yml

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
