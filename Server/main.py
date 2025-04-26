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

# Change all lights state
@app.route("/light/all/change", methods=["POST"])
def ChangeAllLights():
    data = {"ok": True}
    fail = {"ok": False}

    # Here we collect the received data
    lightInfo = request.json 
    
    # Set the light status for all leds
    status = lightInfo["status"]
    result = queries.ChangeAllLightsState(status)

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
        "living_room": queries.GetLightState("living_room"),
        "bedroom1": queries.GetLightState("bedroom1"),
        "bedroom2": queries.GetLightState("bedroom2"),
        "kitchen": queries.GetLightState("kitchen"),
        "dining_room": queries.GetLightState("dining_room"),
    }
        
    return jsonify(response),200

#Obtain one door state
@app.route("/door/status", methods=["GET"])
def GetDoor():
    #GET params
    door = request.args.get("door")
    
    #Print value
    print(door)
    
    #Generic response
    response = {
        "error": False,
        "data" : None,
        "msg" : None,
        "ok": True
    }
    #Check if pin is valid
    if door in values.pins["doors"]:
        response["data"]= {
            "state": queries.GetDoorState(door),
        }
        
    else:
        response["errjson, or"]=True
        response["data"]="Puerta {door}: No existe"
        
    return jsonify(response),200

#Obtain all doors states
@app.route("/doors/status", methods=["GET"])
def GetDoors():

    response = {
        "error": False,
        "data" : None,
        "msg" : None,
        "ok": True
    }
    
    response["data"]={
        "front_door": queries.GetDoorState("front_door"),
        "back_door": queries.GetDoorState("back_door"),
        "bedroom1_door": queries.GetDoorState("bedroom1_door"),
        "bedroom2_door": queries.GetDoorState("bedroom2_door"),
    }
        
    return jsonify(response),200

#if __name__ == '__main__':
#    queries.StartLights()
#    queries.StartDoors()
#    app.run(host=values.host, port=values.port)
