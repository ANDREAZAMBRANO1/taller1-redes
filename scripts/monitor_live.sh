#!/bin/bash

# Colores para la interfaz
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuración
LOG_FILE="../data/metrics_$(date +%Y%m%d_%H%M%S).csv"
UPDATE_INTERVAL=3

echo -e "${CYAN}
╔══════════════════════════════════════════════╗
║           SISTEMA DE MONITOREO LIVE          ║
║         Taller 1 - Redes Computadores        ║
╚══════════════════════════════════════════════╝
${NC}"

echo -e "📊 Archivo de datos: ${GREEN}$LOG_FILE${NC}"
echo -e "⏱️  Intervalo: ${YELLOW}$UPDATE_INTERVAL segundos${NC}"
echo -e "🛑 Presiona ${RED}Ctrl+C${NC} para detener el monitoreo\n"

# Crear encabezado CSV
echo "timestamp,cpu_percent,mem_percent,response_ms,apache_procs,connections,load_avg" > $LOG_FILE

# Función para mostrar barra de progreso
print_progress_bar() {
    local value=$1
    local max=100
    local bar_length=20
    local filled=$((value * bar_length / max))
    local empty=$((bar_length - filled))
    
    printf "["
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "] %3d%%" $value
}

monitor_loop() {
    while true; do
        # Obtener métricas
        TIMESTAMP=$(date '+%H:%M:%S')
        
        # CPU
        CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
        CPU_INT=${CPU%.*}
        
        # Memoria
        MEM=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100}')
        MEM_INT=${MEM%.*}
        
        # Tiempo de respuesta
        START_TIME=$(date +%s%N)
        curl -s --connect-timeout 2 http://localhost/ > /dev/null
        END_TIME=$(date +%s%N)
        RESPONSE_TIME=$(( (END_TIME - START_TIME) / 1000000 ))
        
        # Procesos Apache
        APACHE_PROCS=$(ps aux | grep apache2 | grep -v grep | wc -l)
        
        # Conexiones
        CONNECTIONS=$(ss -t sport = :80 | grep ESTAB | wc -l)
        
        # Load average
        LOAD_AVG=$(cat /proc/loadavg | awk '{print $1}')
        
        # Guardar en CSV
        echo "$(date '+%Y-%m-%d %H:%M:%S'),$CPU,$MEM,$RESPONSE_TIME,$APACHE_PROCS,$CONNECTIONS,$LOAD_AVG" >> $LOG_FILE
        
        # Mostrar interfaz
        clear
        echo -e "${CYAN}╔══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║           MONITOREO EN TIEMPO REAL           ║${NC}"
        echo -e "${CYAN}║                $(date)              ║${NC}"
        echo -e "${CYAN}╚══════════════════════════════════════════════╝${NC}\n"
        
        echo -e "🖥️  ${BLUE}USO DE CPU:${NC}    $(print_progress_bar $CPU_INT) ${YELLOW}$CPU%${NC}"
        echo -e "💾 ${BLUE}USO DE MEMORIA:${NC} $(print_progress_bar $MEM_INT) ${YELLOW}$MEM%${NC}"
        echo
        
        # Tiempo de respuesta con color según performance
        if [ $RESPONSE_TIME -lt 50 ]; then
            COLOR=$GREEN
            EMOJI="🚀"
        elif [ $RESPONSE_TIME -lt 200 ]; then
            COLOR=$YELLOW
            EMOJI="⚡"
        else
            COLOR=$RED
            EMOJI="🐌"
        fi
        echo -e "🌐 ${BLUE}TIEMPO RESPUESTA:${NC} $EMOJI ${COLOR}$RESPONSE_TIME ms${NC}"
        
        echo -e "🔧 ${BLUE}PROCESOS APACHE:${NC} ${PURPLE}$APACHE_PROCS${NC}"
        echo -e "🔗 ${BLUE}CONEXIONES HTTP:${NC} ${PURPLE}$CONNECTIONS${NC}"
        echo -e "📈 ${BLUE}LOAD AVERAGE:${NC}    ${PURPLE}$LOAD_AVG${NC}"
        
        echo -e "\n${CYAN}╔══════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║ ${GREEN}✓${NC} Datos guardados en: ${GREEN}$LOG_FILE${NC} ${CYAN}           ║${NC}"
        echo -e "${CYAN}║ ${RED}✗${NC} Presiona ${RED}Ctrl+C${NC} para detener ${CYAN}              ║${NC}"
        echo -e "${CYAN}╚══════════════════════════════════════════════╝${NC}"
        
        sleep $UPDATE_INTERVAL
    done
}

# Manejar interrupción Ctrl+C
trap 'echo -e "\n${GREEN}✅ Monitoreo detenido. Datos guardados en: $LOG_FILE${NC}"; exit 0' INT

# Iniciar monitoreo
monitor_loop
