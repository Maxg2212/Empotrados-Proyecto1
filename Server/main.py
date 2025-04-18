from flask import Flask, jsonify, request, send_file, make_response
from flask_cors import CORS
import bcrypt
import os
 
app = Flask(__name__)
app.config["DEBUG"] = True
cors = CORS(app)
#main.config["CORS_HEADERS"] = "Content-Type"

storedUsername = "admin"
storedPassword = "1234"

hashedPassword = bcrypt.hashpw(storedPassword.encode('utf-8'), bcrypt.gensalt())

@app.route('/login', methods=['POST'])
def login():
    data = request.json

    username = data.get('username')
    password = data.get('password')

    if (username == storedUsername) & bcrypt.checkpw(password.encode('utf-8'), hashedPassword):
        response = make_response(jsonify({"message": "Login successful"}), 200)

    else:
        response = make_response(jsonify({"message": "Invalid username or password"}), 401)

    response.headers['Content-Type'] = 'application/json; charset=utf-8'
    return response

