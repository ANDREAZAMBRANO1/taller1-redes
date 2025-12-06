#!/bin/bash

echo "🔄 Configurando servidor para Taller 1 - Redes"

# Instalar Apache si no está instalado
if ! command -v apache2 &> /dev/null; then
    echo "📦 Instalando Apache..."
    sudo apt update
    sudo apt install apache2 -y
fi

# Instalar PHP y el módulo de Apache para PHP (Requerido para archivos .php)
if ! command -v php &> /dev/null; then
    echo "📦 Instalando PHP y módulo Apache..."
    sudo apt install php libapache2-mod-php -y
fi

# Copiar archivos al servidor (Usando cp -r para copiar todo el contenido de src/)
echo "📁 Copiando archivos al servidor..."
sudo cp -r src/. /var/www/html/ # Copia todo el contenido de src/ a /var/www/html/

# Dar permisos a los scripts
sudo chown -R www-data:www-data /var/www/html

# Reiniciar Apache para cargar el nuevo módulo PHP
echo "🔄 Reiniciando Apache..."
sudo systemctl restart apache2

echo "✅ Configuración completada"
echo "🌐 Servidor disponible en: http://localhost"