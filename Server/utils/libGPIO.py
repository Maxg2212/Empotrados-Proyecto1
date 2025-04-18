from ctypes import *
import utils.values as values

"""
    TODO:

        Acoplar libreria con la raspberry.
    
"""

# int digitalWrite(int pin, int value);
def digital_write(pin: int, direction: int) -> int:
    #_digital_write = gpioman_lib.digitalWrite
    #_digital_write.restype = c_int
    print(f"[DEBUG] digital_write llamado con pin={pin}, valor={direction}")
    return 0
