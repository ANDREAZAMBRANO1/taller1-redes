#!/bin/bash

echo "🔄 Configurando servidor para Taller 1 - Redes"

# Instalar Apache si no está instalado
if ! command -v apache2 &> /dev/null; then
    echo "📦 Instalando Apache..."
    sudo apt update
    sudo apt install apache2 -y
fi

# Copiar archivos al servidor
echo "📁 Copiando archivos al servidor..."
sudo cp src/index.html /var/www/html/

# Dar permisos a los scripts
chmod +x scripts/*.sh

echo "✅ Configuración completada"
echo "🌐 Servidor disponible en: http://localhost"
