#!/bin/bash

# Este script comprime todo el contenido de la carpeta actual y además, genera
# una suma de verificación del archivo resultante en un archivo separado.
# Define la ruta del directorio

# Comprime todos los jpg de la carpeta imagenes
tar  -cf $IMAGESDIR/images.tar *.jpg

# Renombra archivo con suma de verificacion
TITLE=$(sha256sum "$IMAGESDIR/images.tar" | awk '{print $1}')

RENAMED="$IMAGESDIR/$TITLE.tar"

mv "$IMAGESDIR/images.tar" "$RENAMED"

echo "Archivo renombrado y guardado como: $RENAMED"