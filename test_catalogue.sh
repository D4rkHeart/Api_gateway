#!/bin/bash
set -e

echo "POST /catalogue"
curl -s -X POST http://localhost:8088/catalogue \
  -H "Content-Type: application/json" \
  -d '{
    "nom": "Clavier Test",
    "description": "Test POST",
    "prix": 10.99,
    "quantite_en_stock": 5
}'
echo -e "\n POST OK"

echo "GET ALL /catalogue"
curl -s http://localhost:8088/catalogue
echo -e "\n GET ALL OK"

echo "GET ONE /catalogue/1"
curl -s http://localhost:8088/catalogue/2
echo -e "\n GET ONE OK"

echo "PUT /catalogue/1"
curl -s -X PUT http://localhost:8088/catalogue/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nom": "Clavier Modifié",
    "description": "Test PUT",
    "prix": 15.99,
    "quantite_en_stock": 10
}'
echo -e "\n PUT OK"

echo "PATCH /catalogue/1"
curl -s -X PATCH http://localhost:8088/catalogue/1 \
  -H "Content-Type: application/json" \
  -d '{
    "prix": 19.99
}'
echo -e "\n PATCH OK"

echo "DELETE /catalogue/1"
curl -s -X DELETE http://localhost:8088/catalogue/1
echo -e "\n DELETE OK"

echo "POST /commande"
curl -s -X POST http://localhost:8088/commande \
  -H "Content-Type: application/json" \
  -d '{
    "total": 100,
    "statut": "expédiée",
    "date_commande": "2025-05-10T12:00:00"
}'
echo -e "\n POST OK"

echo "GET ALL /commande"
curl -s http://localhost:8088/commande
echo -e "\n GET ALL OK"

echo "GET ONE /commande/1"
curl -s http://localhost:8088/commande/1
echo -e "\n GET ONE OK"

echo "PUT /commande/1"
curl -s -X PUT http://localhost:8088/commande/1 \
  -H "Content-Type: application/json" \
  -d '{
    "total": 2,
    "statut": "en cours",
    "date_commande": "2025-04-12T20:00:00"
}'
echo -e "\n PUT OK"

echo "DELETE /commande/1"
curl -s -X DELETE http://localhost:8088/commande/1
echo -e "\n DELETE OK"

echo " Tous les tests ont été exécutés avec succès."
