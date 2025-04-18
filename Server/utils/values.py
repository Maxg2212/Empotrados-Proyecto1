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

pins = { "rooms": { "Sala": 2, "Cuarto 1": 3, "Cuarto 2": 4, "Cocina": 17, "Comedor": 27 }, 
            "doors": { "Front_door": 23, "Back_door": 24, "3": 20, "4": 21 } }


# Setting status values constants
low = 0
high = 1

# Library path
ourLib = "/lib/libgpioman.so.0"

# Setting input and output modes to read and send info
iMode = 0
oMode = 1

# If the command was completed correctly
error = -1
complete = 0