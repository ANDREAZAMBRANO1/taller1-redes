<?php
$output = [];
exec("/var/www/html/generar_primos_renata.sh", $output);
foreach ($output as $line) {
    if (strpos($line, 'primos_') !== false) {
        echo trim($line);

        break;
    }
}
?>
