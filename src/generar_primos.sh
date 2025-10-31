#!/bin/bash

OUT_DIR="/var/www/html"


while true; do
    # Generar un número aleatorio como sufijo
    SUFFIX=$RANDOM
    # Nombre de archivo con sufijo
    PRIME_FILE="$OUT_DIR/primos_$SUFFIX.txt"

    # Si no existe ninguno de los dos archivos, sal del bucle
    if [[ ! -e "$PRIME_FILE" ]]; then
        break
    fi
done

count=0
num=2
while [ $count -lt 1000 ]; do
    is_prime=1
    for ((i=2; i*i<=num; i++)); do
        if ((num % i == 0)); then
            is_prime=0
            break
        fi
    done
    if ((is_prime)); then
        echo $num >> "$PRIME_FILE"
        ((count++))
    fi
    ((num++))
done

echo "primos_$SUFFIX.txt"
