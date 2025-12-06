#!/bin/bash

# Ruta de salida
OUTPUT_DIR="/var/www/html"

# Genera un sufijo aleatorio.
SUFFIX=$RANDOM

# Nombres de archivo usando la variable CORRECTA
RAW_FILE="$OUTPUT_DIR/arreglo_$SUFFIX.txt"
SORTED_FILE="$OUTPUT_DIR/ordenado_$SUFFIX.txt"

# Generar 10,000 números aleatorios (Escritura 1)
for i in {1..10000}; do echo $((RANDOM % 10000)); done > "$RAW_FILE"

# Ordenar el archivo (Escritura 2)
sort -n "$RAW_FILE" > "$SORTED_FILE"

# Muestra el nombre del archivo para que PHP lo capture
echo "ordenado_$SUFFIX.txt"