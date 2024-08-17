#!/bin/bash

clear

echo Etiquetas Disponibles:

#Recorre los .tag y concatena todas las etiquetas eliminando duplicadas
cat *.tag 2> /dev/null | tr -d '0-9' | tr ',' '\n' | tr ' ' '\n' | sort | uniq -u || echo "No hay etiquetas disponibles"
echo