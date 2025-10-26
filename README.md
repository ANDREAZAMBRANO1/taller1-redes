# 🖥️ Taller 1 - Redes de Computadores I

**Universidad Simón Bolívar**  
**Departamento de Computación y TI**  
**CI-4835 - Sep-Dic 2025**

## 👥 Integrantes del Equipo
- [Nombre 1]
- [Nombre 2] 
- [Nombre 3]
- Andrea

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


---

## 🔧 **Paso 4: Crear archivo de configuración**

```bash
# Archivo de configuración
nano setup.sh
