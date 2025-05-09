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

echo " Tous les tests ont été exécutés avec succès."
