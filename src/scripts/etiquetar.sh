#!/bin/bash

# Este script trabaja sobre archivos de la carpeta actual que terminan en .jpg,
# clasificándolos usando YOLO:
#
# Debe crearse un archivo con el mismo nombre que la imagen, pero extensión .tag
# donde se guardan las etiquetas. Por ejemplo, un archivo .tag podría tener:
# 2 persons, 1 potted plant, 1 laptop, 2 books
#
# Asegúrese de devolver un valor de salida acorde a la situación.

#Si ls *.jpg devuelve algo continua con el proceso, sino imprime 'No se encontraron imágenes'
if ls *.jpg 1>/dev/null 2>&1; then
	for archivo in `ls *.jpg`; do #Para cada archivo .jpg reemplaza esa extensión por .tag y guarda el nombre en una variable
		echo Procesando imagen...
		nuevo_nombre="${archivo%.jpg}.tag"
		yolo predict source=$archivo > temporal #Direcciona la salida de yolo a un arhivo temporal
		grep 'image 1/1' temporal | cut -d : -f 2 | rev | cut -d ',' -f 2- | rev | cut -d ' ' -f 3- > $nuevo_nombre
		rm temporal #Filtra las detecciones que se encuentran en el archivo temporal, las dirige a un nuevo archivo .tag
		echo Detecciones: `cat "$nuevo_nombre"` #Imprime en pantalla las detecciones
	done
else
	echo No se encontraron imágenes
fi

