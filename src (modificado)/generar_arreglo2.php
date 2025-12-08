#!/usr/bin/env bash
set -euo pipefail

# Configuración
BASE_DIR="/var/www/html"
OUT_DIR="$BASE_DIR/project_tmp"
JOB_DIR="$OUT_DIR/jobs"
QUEUED_DIR="$JOB_DIR/queued"
RUNNING_DIR="$JOB_DIR/running"
DONE_DIR="$JOB_DIR/done"
SEM_DIR="$OUT_DIR/semaphore"
MAX_SLOTS=6
SLEEP_EMPTY=1

# Crear directorios necesarios
mkdir -p "$QUEUED_DIR" "$RUNNING_DIR" "$DONE_DIR" "$SEM_DIR"
umask 027

# Función para tomar un slot; devuelve el número de slot en SLOT var o vacío si no hay
take_slot() {
  SLOT=""
  for i in $(seq 1 $MAX_SLOTS); do
    if mkdir "$SEM_DIR/slot.$i" 2>/dev/null; then
      SLOT=$i
      break
    fi
  done
  echo "$SLOT"
}

# Función para liberar slot
release_slot() {
  local s="$1"
  [ -n "$s" ] && rmdir "$SEM_DIR/slot.$s" 2>/dev/null || true
}

# Procesar un job dado (ruta completa al archivo .job en queued)
process_job() {
  local queued_file="$1"
  local jobbase
  jobbase="$(basename "$queued_file" .job)"
  local running_file="$RUNNING_DIR/$jobbase.job"

  # Mover job a running de forma atómica
  if ! mv "$queued_file" "$running_file"; then
    echo "error: cannot move job $queued_file to running" >&2
    return 1
  fi

  # Intentar tomar slot; si no hay, devolver job a queued y salir con código 2
  local slot
  slot="$(take_slot)"
  if [ -z "$slot" ]; then
    # devolver a cola (mv atómico)
    mv "$running_file" "$queued_file"
    echo "busy" >&2
    return 2
  fi

  # Preparar archivos de salida
  local raw_file
  raw_file="$(mktemp "$OUT_DIR/arreglo_${jobbase}_XXXXXX.txt")"
  local sorted_file="${raw_file/arreglo_/ordenado_}"
  local sorted_basename
  sorted_basename="$(basename "$sorted_file")"

  # Marcar inicio en un archivo de control
  echo "$(date -u +%s)" > "$RUNNING_DIR/$jobbase.started"

  # Generar números aleatorios eficientemente
  LC_ALL=C shuf -i 0-9999 -n 10000 > "$raw_file"

  # Ordenar con prioridad baja y limitando memoria
  CORES="$(nproc 2>/dev/null || echo 1)"
  # Si ionice no existe, se ejecuta sin él
  if command -v ionice >/dev/null 2>&1; then
    nice -n 10 ionice -c2 -n7 sort -n --parallel="$CORES" -S 128M -o "$sorted_file" "$raw_file"
  else
    nice -n 10 sort -n --parallel="$CORES" -S 128M -o "$sorted_file" "$raw_file"
  fi

  # Borrar crudo para ahorrar espacio
  rm -f "$raw_file"

  # Registrar resultado: crear archivo done con nombre del archivo ordenado y timestamp
  {
    echo "job_id=$jobbase"
    echo "filename=$sorted_basename"
    echo "created_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  } > "$DONE_DIR/$jobbase.done"

  # Mover running marker a done (el archivo running_file ya fue movido)
  rm -f "$RUNNING_DIR/$jobbase.job" "$RUNNING_DIR/$jobbase.started" 2>/dev/null || true

  # Liberar slot
  release_slot "$slot"

  # Salida por stdout para logs si se ejecuta manualmente
  echo "$sorted_basename"
  return 0
}

# Loop principal: corre indefinidamente; idealmente ejecutar como servicio systemd
while true; do
  # Buscar el primer job en cola
  shopt -s nullglob
  jobs=( "$QUEUED_DIR"/*.job )
  shopt -u nullglob

  if [ ${#jobs[@]} -eq 0 ]; then
    sleep "$SLEEP_EMPTY"
    continue
  fi

  # Procesar jobs en orden (FIFO por nombre de archivo)
  for q in "${jobs[@]}"; do
    # Intentar procesar; si busy, esperar un poco y seguir con siguiente job
    if ! process_job "$q"; then
      # Si process_job devolvió 2 => busy, esperar y continuar
      sleep 0.2
      continue
    fi
    # Pequeña pausa para evitar bucle agresivo
    sleep 0.1
  done
done


