# Setting host and port values
host = "0.0.0.0"
port = 5000

# Username values
username = "admin"
password = "1234"

# Pin values 
"""
    TODO:

        Editar los pines de acuerdo a nuestra raspberry, estos son de ejemplo.

        Cambiarle los nombres a las puertas, no por ids.

        Posiblemente cambiarle nombre a los cuartos.
    
"""

pins = { "rooms": { "living_room": 13, "bedroom1": 6, "bedroom2": 4, "kitchen": 17, "dining_room": 27 }, 
            "doors": { "front_door": 23, "back_door": 24, "bedroom1_door": 20, "bedroom2_door": 21 } }


# Setting status values constants
low = 0
high = 1

# Library path
ourLib = "/usr/lib/libgpio.so.0"

# Setting input and output modes to read and send info
iMode = 0
oMode = 1

# If the command was completed correctly
error = -1
complete = 0
