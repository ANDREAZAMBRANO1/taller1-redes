#!/bin/bash

echo "🧪 GENERADOR DE CARGA AUTOMÁTICO"
echo "================================"

# URL base del servidor
SERVER_URL="http://localhost"

# Función para mostrar uso
show_usage() {
    echo "Uso: $0 [tipo_carga]"
    echo ""
    echo "Tipos de carga disponibles:"
    echo "  ligera    		- 100 peticiones, 5 concurrentes"
    echo "  media     		- 500 peticiones, 10 concurrentes" 
    echo "  pesada    		- 1000 peticiones, 20 concurrentes"
    echo "  extrema   		- 5000 peticiones, 50 concurrentes"
    echo "  ultra     		- 10000 peticiones, 100 concurrentes"
    echo "  apocalipsis   	- 20000 peticiones, 200 concurrentes"
    echo ""
    echo "Ejemplo: $0 media"
}

# Verificar parámetros
if [ $# -eq 0 ]; then
    show_usage
    exit 1
fi

case $1 in
    "ligera")
        REQUESTS=100
        CONCURRENT=5
        ;;
    "media")
        REQUESTS=500
        CONCURRENT=10
        ;;
    "pesada")
        REQUESTS=1000
        CONCURRENT=20
        ;;
    "extrema")
        REQUESTS=5000
        CONCURRENT=50
        ;;
    "ultra")
        REQUESTS=10000
        CONCURRENT=100
        ;;
    "apocalipsis")
        REQUESTS=20000
        CONCURRENT=200
        ;;
    *)
        echo "❌ Tipo de carga no válido: $1"
        show_usage
        exit 1
        ;;
esac

echo "🚀 Iniciando prueba de carga: $1"
echo "📊 Peticiones: $REQUESTS"
echo "👥 Concurrentes: $CONCURRENT"
echo "⏳ Iniciando en 3 segundos..."

sleep 3

# Ejecutar Apache Benchmark
echo "🧪 Ejecutando prueba..."
ab -n $REQUESTS -c $CONCURRENT $SERVER_URL/ > "../data/load_test_$1_$(date +%H%M%S).log"

echo "✅ Prueba completada!"
echo "📄 Resultados guardados en: ../data/load_test_$1_*.log"
