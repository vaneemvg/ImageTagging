#!/bin/bash

clear
source $(dirname $0)/menu/configuracion.sh
$SOURCEDIR/menu/checks.sh

COLUMNS=1
PS3="Elija una opción: "
select OPCION in "Descargar imágenes."      \
                 "Etiquetar imágenes."      \
                 "Mostrar imágenes."        \
                 "Comprimir imágenes."      \
                 "Listar imágenes."         \
                 "Listar etiquetas."        \
                 "Informacion del sistema." \
                 "Salir."
do
    case $REPLY in
        1) (cd $IMAGESDIR && $SOURCEDIR/menu/descargar.sh) ;;
        2) (cd $IMAGESDIR && $SOURCEDIR/scripts/etiquetar.sh) ;;
        3) (cd $IMAGESDIR && $SOURCEDIR/scripts/mostrar.sh) ;;
        4) (cd $IMAGESDIR && $SOURCEDIR/scripts/comprimir.sh) ;;
        5) (cd $IMAGESDIR && $SOURCEDIR/menu/listar.sh) ;;
        6) (cd $IMAGESDIR && $SOURCEDIR/scripts/extra.sh) ;;
        7) $SOURCEDIR/menu/info.sh ;;
        8) exit 0 ;;
        *) echo Opción incorrecta.
    esac

    read -p "Presione enter para continuar..."
    clear
    $SOURCEDIR/menu/checks.sh
    COLUMNS=1
done
