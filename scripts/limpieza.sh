#!/bin/bash

# Borra archivos .txt con más de 5 minutos de antigüedad
find /var/www/html -name "*.txt" -mmin +5 -type f -delete

