from flask import Flask, jsonify, request, send_file, make_response
from flask_cors import CORS
import bcrypt
import os
import utils.values as values
import utils.queries as queries
 
app = Flask(__name__)
app.config["DEBUG"] = True
cors = CORS(app)
#main.config["CORS_HEADERS"] = "Content-Type"

hashedPassword = bcrypt.hashpw(values.password.encode('utf-8'), bcrypt.gensalt())

@app.route('/login', methods=['POST'])
def login():
    data = request.json

    username = data.get('username')
    password = data.get('password')

    if (username == values.username) & bcrypt.checkpw(password.encode('utf-8'), hashedPassword):
        response = make_response(jsonify({"message": "Login successful"}), 200)

    else:
        response = make_response(jsonify({"message": "Invalid username or password"}), 401)

    response.headers['Content-Type'] = 'application/json; charset=utf-8'
    return response

# Collects the data of an updated light
@app.route("/light/update", methods=["POST"])
def ChangeLedStatus():
    data = {"ok": True}
    fail = {"ok": False}

    # Here we collect the received data
    lightInfo = request.json 
    
    # Set the light area and light status
    area = lightInfo["area"]
    status = lightInfo["status"]

    if (status == values.high):
         result = queries.TurnOnLight(area)
    elif (status == values.low):
         result = queries.TurnOffLight(area)

    # Return response
    response = data if result else fail
    return jsonify(response), 200

#Obtain all light states
@app.route("/light/status", methods=["GET"])
def GetLights():

    response = {
        "error": False,
        "data" : None,
        "msg" : None,
        "ok": True
    }
    
    response["data"]= {
        "Sala": queries.GetLightState("Sala"),
        "Cuarto 1": queries.GetLightState("Cuarto 1"),
        "Cuarto 2": queries.GetLightState("Cuarto 2"),
        "Cocina": queries.GetLightState("Cocina"),
        "Comedor": queries.GetLightState("Comedor"),
    }
        
    return jsonify(response),200

