<?php
// fibonacci.php

// Función recursiva para el cálculo de Fibonacci
// Advertencia: esto es computacionalmente caro.
function fibonacci($n) {
    if ($n <= 1) {
        return $n;
    }
    return fibonacci($n - 1) + fibonacci($n - 2);
}

// Elige un número que consuma mucho CPU (ej. 40)
$n = 40; 
$start_time = microtime(true);
$result = fibonacci($n);
$end_time = microtime(true);

// Imprimir el tiempo de ejecución para el log de JMeter
echo "Fib(" . $n . ") = " . $result . " calculado en " . round(($end_time - $start_time) * 1000, 2) . " ms.\n";
?>