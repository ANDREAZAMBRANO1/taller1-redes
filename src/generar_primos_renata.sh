#!/bin/bash

OUT_DIR="/var/www/html"

PRIME_FILE="$(mktemp "$OUT_DIR/primos_XXXXXX.txt")"

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

basename "$PRIME_FILE"

