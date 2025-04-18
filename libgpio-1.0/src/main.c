#include <gpio.h>
#include <stdio.h>
#include <unistd.h>

int main() {
    int outputPin1 = 13; // GPIO 13
    int outputPin2 = 6; // GPIO 6
    int inputPin = 22;   // GPIO 22
    int readValue;

    // Configura el pin 17 como salida
    pinMode(outputPin1, 1);
    // Configura el pin 6 como salida
    pinMode(outputPin2, 1);
    // Configura el pin 22 como entrada
    pinMode(inputPin, 0);

    // Escribe valores binarios en el pin 13
    printf("Escribiendo valor 1 en el pin %d\n", outputPin1);
    digitalWrite(outputPin1, 1);
    sleep(2); // Espera 1 segundo

    printf("Escribiendo valor 0 en el pin %d\n", outputPin1);
    digitalWrite(outputPin1, 0);
    sleep(2); // Espera 1 segundo

    // Establece un parpadeo en el pin 6 con una duración total de 5 segundos
    printf("Haciendo parpadear el pin %d durante 5 segundos\n", outputPin2);
    blink(outputPin2, 500, 10); // 500 ms de encendido/apagado, 10 veces (5 segundos)

    // Lee el valor del pin 22 y lo muestra en pantalla
    readValue = digitalRead(inputPin);
    printf("El valor leído del pin %d es: %d\n", inputPin, readValue);

    // Libera los pines utilizados
    unexportPin(outputPin1);
    unexportPin(outputPin2);
    unexportPin(inputPin);

    return 0;
}