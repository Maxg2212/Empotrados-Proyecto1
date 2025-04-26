# mock_libGPIO.py - Simulación local de GPIO sin necesidad de librerías en C

# Estos valores pueden ser simulados con un diccionario para controlar estados
import utils.values as values

# Diccionario para simular estado de cada pin
pin_states = {}
pin_modes = {}

def digital_write(pin: int, direction: int) -> int:
    pin_states[pin] = direction
    print(f"[MOCK] digital_write: pin={pin}, value={direction}")
    return 0  # 0 como si fuera exitoso

def digital_read(pin: int) -> int:
    # Devuelve el estado actual simulado (1 por defecto si no existe)
    value = pin_states.get(pin, 1)
    print(f"[MOCK] digital_read: pin={pin}, returning {value}")
    return value

def export_command(pin: int) -> int:
    print(f"[MOCK] export_command: pin={pin}")
    pin_states[pin] = 0  # Inicializa en 0
    return 0

def pin_mode(pin: int, direction: int) -> int:
    print(f"[MOCK] pin_mode: pin={pin}, direction={direction}")
    pin_modes[pin] = direction
    return 0

def blink(pin: int, freq: float, duration: float) -> int:
    print(f"[MOCK] blink: pin={pin}, freq={freq}, duration={duration}")
    return 0

def unexport_command(pin: int) -> int:
    print(f"[MOCK] unexport_command: pin={pin}")
    pin_states.pop(pin, None)
    pin_modes.pop(pin, None)
    return 0
