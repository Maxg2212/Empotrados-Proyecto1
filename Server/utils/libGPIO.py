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


"""
    TODO:

        Una vez implementado el HW, retornar el valor correcto.
        "return _digital_read(c_int(pin))"
    
"""
# int digitalRead(int pin);
def digital_read(pin: int) -> int:
    # _digital_read = gpioman_lib.digitalRead
    # _digital_read.restype = c_int
    print(f"[DEBUG] digital_read llamado con pin={pin}")
    # Simula lectura: por ejemplo, return 1 si pin impar, 0 si par
    return pin % 2