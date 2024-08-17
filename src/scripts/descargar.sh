#!/bin/bash

# Este script debe descargar una sola imagen desde internet en la carpeta actual.
# Puede recibir un argumento opcional indicando la clase de la imagen.
# El nombre del archivo deberá ser su suma de verificación y debe terminar en .jpg
# Asegúrese de devolver un valor de salida acorde a la situación.

function url_unsplash {

    # Solicitud a Unplash
    ACCESS_KEY="xxx"
    URL="https://api.unsplash.com/photos/random?client_id=${ACCESS_KEY}"

    if [ -n "$1" ];then
        URL="$URL&query=$1"
    fi

    RESPONSE=$(curl -s $URL)

    if [ $? -ne 0 ]; then
        echo "Error al hacer la solicitud a Unsplash API."
        exit 1
    fi

    # jq extrae la URL del json de respuesta
    IMAGE_URL=$(echo $RESPONSE | jq -r '.urls.full')

    if [ -z "$IMAGE_URL" ]; then
        echo "Error al extraer la URL de la imagen."
        exit 1
    fi

    echo $IMAGE_URL
}

CLASE=$1

if [ $(echo -n "$CLASE" | wc -m) -gt 2 ]; then
    #Si recibimos parametro de filtrado usamos al proveedor de imagenes Unplash
    RANDOM_NUMBER=1
else
    RANDOM_NUMBER=$(shuf -i 1-5 -n 1)
    CLASE=""
fi

# Utilizo alguno de los 5 proveedores de descarga
case $RANDOM_NUMBER in 
1)
    PROVIDER="Unplash"
    url_unsplash "$CLASE"
    IMAGE_URL= url_unsplash "$CLASE"
;;
2)
    PROVIDER="Picsum"
    IMAGE_URL="https://picsum.photos/512"
;;
3)
    PROVIDER="Loremflickr"
    IMAGE_URL="https://loremflickr.com/512/512"
;;
4)
    PROVIDER="Pepebigotes"
    IMAGE_URL="https://random-image-pepebigotes.vercel.app/api/random-image"
;;
*)
    PROVIDER="Pollinations"
    IMAGE_URL="https://image.pollinations.ai/prompt/a%20photo%20of%20a%20person?seed=1"
;;
esac

# Descargar imagen
PATH_IMAGE=$SOURCEDIR/imagenes/temp_image.jpg
curl -o $PATH_IMAGE "$IMAGE_URL" 

IMAGE_TITLE=$(sha256sum "$PATH_IMAGE" | awk '{print $1}')
# Nombre del archivo deberá ser su suma de verificación
RENAMED_IMAGE="$SOURCEDIR/imagenes/$IMAGE_TITLE.jpg"

mv "$PATH_IMAGE" "$RENAMED_IMAGE"

if [ $? -eq 0 ]; then
    echo "Imagen descargada de $PROVIDER como "$IMAGE_TITLE
else
    echo "Error al descargar la imagen de $PROVIDER."
fi