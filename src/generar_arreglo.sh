#!/bin/bash

# Ruta de salida
OUTPUT_DIR="/home/andrea/PROYECTS/taller1-redes/src/output"

# 2. Crear si no existe
sudo mkdir -p "$OUTPUT_DIR"

# 3. Asignar propiedad a www-data (para que pueda escribir)
sudo chown -R www-data:www-data "$OUTPUT_DIR"

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