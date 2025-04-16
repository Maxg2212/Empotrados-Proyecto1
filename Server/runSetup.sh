#!/bin/bash

# runSetup.sh - Script para configurar, ejecutar y resetear entorno Flask

case "$1" in
  setup)
    echo "Configuración inicial del entorno..."

    # Crear entorno virtual si no existe
    if [ ! -d "venv" ]; then
        echo "Creando entorno virtual..."
        python3 -m venv venv
    fi

    echo "Activando entorno virtual..."
    source venv/bin/activate

    # Instalar dependencias
    if [ -f "requirements.txt" ]; then
        echo "Instalando dependencias desde requirements.txt..."
        pip install -r requirements.txt
    else
        echo "Instalando Flask (no se encontró requirements.txt)..."
        pip install Flask
    fi
    ;;

  run)
    echo "Ejecutando servidor Flask..."
    source venv/bin/activate
    export FLASK_APP=main.py
    flask run --host=0.0.0.0
    ;;

  reset)
    echo "Eliminando entorno virtual..."
    rm -rf venv
    echo "Reiniciando configuración..."
    "$0" setup
    ;;

  *)
    echo "Uso: $0 {setup|run|reset}"
    exit 1
esac
