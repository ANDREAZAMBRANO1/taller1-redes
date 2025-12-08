<?php
// Ejecuta el script y captura la salida
$output = [];
exec("/var/www/html/generar_arreglo_renata.sh", $output);

// Busca la línea que contiene el nombre del archivo
foreach ($output as $line) {
    if (strpos($line, 'ordenado_') !== false) {
        echo trim($line); // Devuelve solo el nombre del archivo
        break;
    }
}
?>
