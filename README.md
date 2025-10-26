# 🖥️ Taller 1 - Redes de Computadores I

**Universidad Simón Bolívar**  
**Departamento de Computación y TI**  
**CI-4835 - Sep-Dic 2025**

## 👥 Integrantes del Equipo
- Andrea Zambrano
- Eleyton Diaz
- Renata Colon

## 📋 Descripción del Proyecto
Implementación de un servidor web Apache con sistema de monitoreo de carga computacional para el Taller 1 de Redes de Computadores.

## 🛠️ Tecnologías Utilizadas
- **Servidor Web**: Apache 2
- **Sistema Operativo**: Ubuntu WSL
- **Monitoreo**: Scripts Bash personalizados
- **Pruebas de Carga**: Apache Benchmark (ab)

## 📁 Estructura del Proyecto

taller1-redes/
├── src/ # Código fuente (HTML, CSS, JS)
├── scripts/ # Scripts de monitoreo y automatización
├── data/ # Datos recolectados (CSV, logs)
├── docs/ # Documentación adicional
└── README.md

## 🚀 Instalación y Configuración

### Prerrequisitos
- WSL 2 con Ubuntu
- Apache 2
- Git

### Pasos de Instalación
1. Clonar el repositorio
2. Copiar los archivos a `/var/www/html/`
3. Ejecutar scripts de monitoreo

## 📊 Scripts de Monitoreo
- `monitor.sh` - Monitoreo básico
- `monitor_avanzado.sh` - Monitoreo completo con métricas

## 📈 Pruebas de Carga
Usar Apache Benchmark:
```bash
ab -n 1000 -c 10 http://localhost/


## 📊 Sistema de Monitoreo

El proyecto incluye scripts avanzados para monitorear el rendimiento del servidor en tiempo real.

### 🚀 Scripts de Monitoreo Disponibles

#### **1. Monitor en Tiempo Real** (`scripts/monitor_live.sh`)
Interfaz visual con colores que muestra métricas en tiempo real:

```bash
cd scripts/
./monitor_live.sh


╔══════════════════════════════════════════════╗
║           MONITOREO EN TIEMPO REAL           ║
║             Sun Oct 26 14:30:15 -04          ║
╚══════════════════════════════════════════════╝

🖥️  USO DE CPU:    [██████████░░░░░░░░░░]  50%
💾 USO DE MEMORIA: [█████░░░░░░░░░░░░░░░]  25%

�� TIEMPO RESPUESTA: ⚡ 45 ms
🔧 PROCESOS APACHE: 3
🔗 CONEXIONES HTTP: 2
📈 LOAD AVERAGE:    0.85


### **2. Generador de Carga** 

# Carga ligera (100 peticiones, 5 concurrentes)
./generador_carga.sh ligera

# Carga media (500 peticiones, 10 concurrentes)
./generador_carga.sh media

# Carga pesada (1000 peticiones, 20 concurrentes)
./generador_carga.sh pesada

# Carga extrema (5000 peticiones, 50 concurrentes)
./generador_carga.sh extrema


### **3. Monitor Básico (scripts/monitor.sh)**

./monitor.sh


### **📈 Métricas Monitoreadas**


Métrica	Descripción	Valor Óptimo

CPU	Uso de procesador	< 80%
Memoria	Uso de RAM	< 85%
Tiempo Respuesta	Latencia del servidor	< 100ms
Procesos Apache	Número de procesos	3-10
Conexiones	Conexiones activas	Depende de carga
Load Average	Promedio de carga del sistema	< Núcleos CPU


### **💾 Almacenamiento de Datos**

Los datos se guardan automáticamente en la carpeta data/:

metrics_YYYYMMDD_HHMMSS.csv - Métricas detalladas

load_test_[tipo]_HHMMSS.log - Resultados de pruebas de carga


### **📊 Análisis de Datos**

Puedes analizar los datos CSV con:

bash
# Ver resumen de métricas
cd data/
awk -F, '{print $1, $4 "ms"}' metrics_*.csv | tail -10

# Estadísticas básicas
awk -F, 'NR>1 {sum+=$4; count++} END {print "Avg response:", sum/count, "ms"}' metrics_*.csv


## 🎯 Ejemplo de Flujo de Trabajo

##Iniciar monitoreo:

bash
./scripts/monitor_live.sh

##Generar carga (en otra terminal):

bash
./scripts/generador_carga.sh media
Observar métricas en tiempo real

##Analizar resultados:

bash
ls -la data/
tail -f data/metrics_*.csv
