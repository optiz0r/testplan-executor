<?php

$main   = TPE_Main::instance();
$req    = $main->request();

$messages = array();

$testplans = null;

try {
    $testplans = file_get_contents('php://input');

} catch (TPE_Exception_InvalidParameters $e) {
    $messages[] = get_class($e) . ':' . $e->getMessage();
}

$this->smarty->assign('testplans', $testplans);
$this->smarty->assign('messages', $messages);

?>