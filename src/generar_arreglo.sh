#!/bin/bash

# Ruta de salida
OUT_DIR="/var/www/html"

while true; do
    # Generar un número aleatorio como sufijo
    SUFFIX=$RANDOM
    # Nombres de archivo con sufijo
    RAW_FILE="$OUT_DIR/arreglo_$SUFFIX.txt"
    SORTED_FILE="$OUT_DIR/ordenado_$SUFFIX.txt"

    # Si no existe ninguno de los dos archivos, sal del bucle
    if [[ ! -e "$RAW_FILE" && ! -e "$SORTED_FILE" ]]; then
        break
    fi
done

# Generar 10,000 números aleatorios
for i in {1..10000}; do echo $((RANDOM % 10000)); done > "$RAW_FILE"

# Ordenar el archivo
sort -n "$RAW_FILE" > "$SORTED_FILE"


echo "ordenado_$SUFFIX.txt"

