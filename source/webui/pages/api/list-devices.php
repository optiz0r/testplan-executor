<?php

$main   = TPE_Main::instance();
$req    = $main->request();

$messages = array();
$success = null;

$deviceList = array();

try {
    $devices = TPE_Device::all();
    
    foreach ($devices as $device) {
        $deviceList[] = array(
            'hostname' => $device->hostname,
        );
    }
    
    $success = true;
    
} catch (SihnonFramework_Exception_DatabaseException $e) {
    $messages[] = "Database error " . $e->getMessage();
    $success = false;
}

$this->smarty->assign('messages', $messages);
$this->smarty->assign('success', $success);
$this->smarty->assign('devices', $deviceList);

?>