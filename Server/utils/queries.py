import os
import datetime
from utils.libGPIO import *
import utils.values as values


def TurnOnLight(room: str):
    pin = values.pins["rooms"][room]
    if digital_write(pin, values.high) == values.error:
        return False
    return True

def TurnOffLight(room: str):
    pin = values.pins["rooms"][room]
    if digital_write(pin, values.low) == values.error:
        return False
    return True

def GetLightState(room: str):
    pin = values.pins["rooms"][room]
    result = digital_read(pin)

    if (result == values.error):
        print("Light Error: {room} in pin {pin} is not available.")
    
    return result

def ChangeAllLightsState(status):
    roomValues = ["living_room", "bedroom1", "bedroom2", "kitchen", "dining_room"]
    responses = []
    if(status == 1):
        for roomName in roomValues:
            responses.append(TurnOnLight(roomName))
    else:
        for roomName in roomValues:
            responses.append(TurnOffLight(roomName))
            
    for value in responses:
        if(value != True):
            return False
    return True

def GetDoorState(room: str):
    pin = values.pins["doors"][room]
    result = digital_read(pin)

    if (result == values.error):
        print("Door Error: {room} in pin {pin} is not available.")
    
    return result