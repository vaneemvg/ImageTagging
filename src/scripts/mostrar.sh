#!/bin/bash

# Este script es un programa interactivo que no recibe argumentos.
# Debe preguntarle al usuario que etiqueta desea buscar y mostrar por
# pantalla todas las imágenes que tengan esa etiqueta.

# Preguntar sobre las etiquetas a buscar
read -p "Introducir etiqueta: " etiqueta

echo "Buscando imagenes con $etiqueta..."

# Buscar etiquetas en los archivos ".tag"
contador=0

for archivo_tag in "$IMAGESDIR"/*.tag; do
	
	if [ -f $archivo_tag ]; then
		contiene_etiqueta=$(grep -i "$etiqueta" "$archivo_tag")
		
		#Se encuentra los archivos tag con la etiqueta y se muestras las imagenes relacionadas.
	       	if [ -n "$contiene_etiqueta" ]; then 
				contador=$((contador + 1))
				nombre="${archivo_tag%.tag}.jpg"
				echo $nombre
				jp2a $nombre 
		
		fi
	fi
done

#Si el no hay archivos .tag con esa etiqueta, no se muestran las imagenes e indica el error.
if [ $contador == 0 ]; then
	echo "No se encontraron imagenes con $etiqueta"
	exit 1
fi
exit 0
