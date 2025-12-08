#!/bin/bash

# Ruta de salida
OUT_DIR="/var/www/html"

RAW_FILE="$(mktemp "$OUT_DIR/arreglo_XXXXXX.txt")"
SORTED_FILE="$(mktemp "$OUT_DIR/ordenado_XXXXXX.txt")"

# Generar 10,000 números aleatorios [0, 9999] y guardar en RAW
i=0
while (( i < 10000 )); do
  printf "%d\n" $((RANDOM % 10000))
  ((i++))
done > "$RAW_FILE"


# Ordenar el archivo
sort -n "$RAW_FILE" > "$SORTED_FILE"

basename "$SORTED_FILE"


