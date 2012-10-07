<?php

define('TPE_File', 'executor');

require '_inc.php';

try {
    $main = TPE_Main::instance();
    TPE_LogEntry::setLocalProgname('executor');
    
    $data = json_decode(file_get_contents('php://stdin'));
    TPE_Main::issetelse($data->execution, 'TPE_Exception_InvalidParameters');
    
    $execution = TPE_Execution::fromId($data->execution);
    $execution->run();
    
} catch (SihnonFramework_Exception $e) {
    die("Uncaught Exception: " . $e->getMessage());
}

?>