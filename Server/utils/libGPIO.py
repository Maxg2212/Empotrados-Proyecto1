from ctypes import *
import utils.values as values

gpioman_lib = CDLL(values.ourLib)

# int digitalWrite(int pin, int value);
def digital_write(pin: int, direction: int) -> int:
    _digital_write = gpioman_lib.digitalWrite
    _digital_write.restype = c_int
    #print(f"[DEBUG] digital_write llamado con pin={pin}, valor={direction}")
    return _digital_write(c_int(pin), c_int(direction))

# int digitalRead(int pin);
def digital_read(pin: int) -> int:
    _digital_read = gpioman_lib.digitalRead
    _digital_read.restype = c_int
    #print(f"[DEBUG] digital_read llamado con pin={pin}")
    # Simula lectura: por ejemplo, return 1 si pin impar, 0 si par
    return _digital_read(c_int(pin))

# int export_command(int PIN);
def export_command(pin: int) -> int:
    _export_command = gpioman_lib.exportPin
    _export_command.restype = c_int

    return _export_command(c_int(pin))

# int pinMode(int PIN, int DIRECTION);
def pin_mode(pin: int, direction: int) -> int:
    _pin_mode = gpioman_lib.pinMode
    _pin_mode.restype = c_int

    return _pin_mode(c_int(pin), c_int(direction))

# int blink(int pin, float freq, double duration);
def blink(pin: int, freq: float, duration: float) -> int:
    _blink = gpioman_lib.blink
    _blink.restype = c_int
    
    return _blink(c_int(pin), c_float(freq), c_double(duration))

# int unexport_command(int PIN);
def unexport_command(pin: int) -> int:
    _unexport_command = gpioman_lib.unexportPin
    _unexport_command.restype = c_int

    return _unexport_command(c_int(pin))
