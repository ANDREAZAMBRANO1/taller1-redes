<?php
declare(strict_types=1);
header('Content-Type: application/json; charset=utf-8');

// Configuración de rutas
$baseDir = '/var/www/html/project_tmp';
$jobDir = $baseDir . '/project_tmp/jobs';
$queuedDir = $jobDir . '/queued';
$runningDir = $jobDir . '/running';
$doneDir = $jobDir . '/done';

// Asegurar directorios
foreach ([$queuedDir, $runningDir, $doneDir] as $d) {
    if (!is_dir($d)) {
        if (!mkdir($d, 0750, true) && !is_dir($d)) {
            http_response_code(500);
            echo json_encode(['ok' => false, 'error' => 'cannot_create_dirs']);
            exit;
        }
    }
}

// Generar job id seguro
$jobId = 'job_' . bin2hex(random_bytes(8));
$jobFile = $queuedDir . '/' . $jobId . '.job';

// Metadata mínima del job
$meta = [
    'job_id' => $jobId,
    'created_at' => gmdate('c'),
    'status' => 'queued'
];

// Escribir job en cola de forma atómica
$tmp = $jobFile . '.tmp';
if (file_put_contents($tmp, json_encode($meta, JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE)) === false) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'write_failed']);
    exit;
}
if (!rename($tmp, $jobFile)) {
    unlink($tmp);
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'enqueue_failed']);
    exit;
}

// Responder con job_id y endpoint sugerido para consultar estado
http_response_code(202);
echo json_encode([
    'ok' => true,
    'job_id' => $jobId,
    'status' => 'queued',
    'status_endpoint' => '/tmp/jobs/status.php?job_id=' . $jobId
]);


