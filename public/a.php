<?php

define('TPE_File', 'ajax');

require '_inc.php';

try {
    $main = TPE_Main::instance();
    TPE_LogEntry::setLocalProgname('webui');         
    $smarty = $main->smarty();
    
    $page = new TPE_Page($smarty, $main->request());
    if ($page->evaluate()) {
        //header('Content-Type: text/json');
        $smarty->display('ajax.tpl');
    }
    
} catch (SihnonFramework_Exception $e) {
    die("Uncaught Exception: " . $e->getMessage());
}

?>
