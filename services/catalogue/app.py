from flask import Flask, request, jsonify
import mysql.connector
import time

app = Flask(__name__)

def get_db_connection():
    for _ in range(10):
        try:
            conn = mysql.connector.connect(
                host="mariadb",
                user="root",
                password="rootpass",
                database="ecommerce"
            )
            return conn
        except mysql.connector.Error as e:
            print("En attente de MariaDB...")
            time.sleep(3)
    raise Exception(" Impossible de se connecter à MariaDB")

@app.route("/catalogue", methods=["GET"])
def get_all():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM produits")
    produits = cursor.fetchall()
    conn.close()
    return jsonify(produits)

@app.route("/catalogue/<int:id>", methods=["GET"])
def get_one(id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM produits WHERE id = %s", (id,))
    produit = cursor.fetchone()
    conn.close()
    if produit:
        return jsonify(produit)
    return {"error": "Produit non trouvé"}, 404

@app.route("/catalogue", methods=["POST"])
def create():
    data = request.get_json()
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO produits (nom, description, prix, quantite_en_stock) VALUES (%s, %s, %s, %s)",
        (data["nom"], data.get("description", ""), data["prix"], data["quantite_en_stock"])
    )
    conn.commit()
    conn.close()
    return {"message": "Produit créé"}, 201

@app.route("/catalogue/<int:id>", methods=["PUT"])
def update(id):
    data = request.get_json()
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "UPDATE produits SET nom = %s, description = %s, prix = %s, quantite_en_stock = %s WHERE id = %s",
        (data["nom"], data["description"], data["prix"], data["quantite_en_stock"], id)
    )
    conn.commit()
    conn.close()
    return {"message": "Produit mis à jour"}

@app.route("/catalogue/<int:id>", methods=["PATCH"])
def patch(id):
    data = request.get_json()
    fields = []
    values = []
    for key in data:
        fields.append(f"{key} = %s")
        values.append(data[key])
    values.append(id)
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(f"UPDATE produits SET {', '.join(fields)} WHERE id = %s", values)
    conn.commit()
    conn.close()
    return {"message": "Produit modifié"}

@app.route("/catalogue/<int:id>", methods=["DELETE"])
def delete(id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM produits WHERE id = %s", (id,))
    conn.commit()
    conn.close()
    return {"message": "Produit supprimé"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
