#!/bin/bash

SOURCEDIR=$(readlink -f $(dirname $0))
IMAGESDIR=$(readlink -f $SOURCEDIR/imagenes)
COOLDOWN=5
export SOURCEDIR IMAGESDIR COOLDOWN
