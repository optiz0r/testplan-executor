<?php

define('TPE_File', 'index');

require '_inc.php';

try {
    $main = TPE_Main::instance();
    TPE_LogEntry::setLocalProgname('webui');
    $smarty = $main->smarty();
    
    $page = new TPE_Page($smarty, $main->request());
    if ($page->evaluate()) {
        $smarty->display('index.tpl');
    }
    
} catch (SihnonFramework_Exception $e) {
    die("Uncaught Exception: " . $e->getMessage());
}

?>