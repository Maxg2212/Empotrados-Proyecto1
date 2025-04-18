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