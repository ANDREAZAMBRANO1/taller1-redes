<?php
function fibonacci_optimizado($n) {
    if ($n <= 1) return $n;
    $a = 0; $b = 1;
    for ($i = 2; $i <= $n; $i++) {
        $temp = $a + $b;
        $a = $b;
        $b = $temp;
    }
    return $b;
}

// Número fijo
$n = 40;
$result = fibonacci_optimizado($n);

echo $result; 
?>
