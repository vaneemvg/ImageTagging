# syntax = edrevo/dockerfile-plus
INCLUDE+ .Dockerfile.base

# Instalar los programas necesarios


# Configuracion de la aplicación
ENV TERM=xterm
ENV COLORTERM=24bit
COPY ["src/", "/app/"]
COPY ["imagenes/", "/app/imagenes/"]
WORKDIR /app
ENTRYPOINT ["/app/main.sh"]
