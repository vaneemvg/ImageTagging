#!/bin/bash

# Este script simplemente debe chequear que haya conexión a internet.
# Asegúrese de retornar un valor de salida acorde a la situación.
# Puede que necesite modificar el archivo Dockerfile.

ping -c 1 google.com.ar > /dev/null 2>&1 ||  { echo "Sin internet."; exit 1; }