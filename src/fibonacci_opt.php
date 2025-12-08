<?php
// fibonacci_opt.php - Versión optimizada (Iterativa)

function fibonacci_optimizado($n) {
    if ($n <= 1) {
        return $n;
    }
    
    $a = 0;
    $b = 1;
    
    for ($i = 2; $i <= $n; $i++) {
        $temp = $a + $b;
        $a = $b;
        $b = $temp;
    }
    
    return $b;
}

// Mantenemos el mismo n=40 para que la comparativa sea justa
$n = 40; 
$start_time = microtime(true);
$result = fibonacci_optimizado($n);
$end_time = microtime(true);

$tiempo_ms = round(($end_time - $start_time) * 1000, 4);

// Imprimir el resultado
echo "Fib(" . $n . ") = " . $result . " calculado en " . $tiempo_ms . " ms.\n";
?>
