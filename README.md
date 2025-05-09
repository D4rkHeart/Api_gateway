# Microservices API Gateway — Catalogue E-commerce

Ce projet est une architecture microservices simple pour un système e-commerce, avec :
- Un microservice `catalogue` développé en Flask (Python)
- Une base de données `MariaDB`
- Une passerelle d'API `Traefik` en reverse proxy
- Une interface d’administration `phpMyAdmin`
- Un système de tests REST en `bash`
- Une gestion par `Makefile`

---

## Architecture

```
client ──> Traefik (http://localhost:8088)
            ├── /catalogue     → Flask API
            └── /phpmyadmin    → Interface DB (http://localhost:8888)
```

---

## Lancement rapide

```bash
make build        # Build et démarre les containers
make logs         # Affiche les logs en temps réel
make test         # Exécute tous les tests de l'API
make clean        # Arrête les containers
make clean-volumes # Supprime containers + volumes
```

---

## API Catalogue

Le service catalogue expose les routes suivantes :

| Méthode | Endpoint              | Description                      |
|---------|-----------------------|----------------------------------|
| `GET`   | `/catalogue`          | Liste tous les produits          |
| `GET`   | `/catalogue/<id>`     | Détail d’un produit              |
| `POST`  | `/catalogue`          | Crée un nouveau produit          |
| `PUT`   | `/catalogue/<id>`     | Remplace un produit              |
| `PATCH` | `/catalogue/<id>`     | Modifie partiellement un produit |
| `DELETE`| `/catalogue/<id>`     | Supprime un produit              |

---

## Base de données

Le schéma de la base `ecommerce` inclut trois tables :

- `produits(id, nom, description, prix, quantite_en_stock)`
- `commandes(id, statut, date_commande, total)`
- `commandes_produits(id, commande_id, produit_id, quantite)`

L’initiation est automatisée via `./db/init.sql`.

---

## Installation locale (optionnel)

Si tu veux exécuter le code Flask localement :

```bash
make install
python services/catalogue/app.py
```

---

## Tests API

Un seul script pour tout tester :

```bash
make test
```

Ce script appelle :
- `POST /catalogue`
- `GET /catalogue`
- `GET /catalogue/1`
- `PUT /catalogue/1`
- `PATCH /catalogue/1`
- `DELETE /catalogue/1`

---

## Outils

- [Docker Compose](https://docs.docker.com/compose/)
- [Flask](https://flask.palletsprojects.com/)
- [MariaDB](https://mariadb.org/)
- [Traefik](https://doc.traefik.io/)
- [phpMyAdmin](https://www.phpmyadmin.net/)

---

## Structure du projet

```
.
├── docker-compose.yml
├── Makefile
├── test_catalogue.sh
├── db/
│   └── init.sql
└── services/
    └── catalogue/
        ├── app.py
        ├── Dockerfile
        └── requirements.txt
```

---

## Auteur

@D4rkHeart
@spirits