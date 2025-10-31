<?php
$output = [];
exec("/var/www/html/generar_primos.sh", $output);
foreach ($output as $line) {
    if (strpos($line, 'primos_') !== false) {
        echo trim($line);
        break;
    }
}
?>
