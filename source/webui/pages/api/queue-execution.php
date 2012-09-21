<?php

$main   = TPE_Main::instance();
$req    = $main->request();
$auth   = $main->auth();

$messages = array();
$success = null;

$testplans = null;

try {
    if ( ! $auth->isAuthenticated()) {
        throw new TPE_Exception_NotAuthorised();
    }
    
    $user = $auth->authenticatedUser();
    $data = json_decode(file_get_contents('php://input'));
    
    if (is_null($data)) {
        throw new TPE_Exception_InvalidParameters("data");
    }
    if ( ! isset($data->devices)) {
        throw new TPE_Exception_InvalidParameters('data.devices');
    }
    if ( ! isset($data->reference)) {
        throw new TPE_Exception_InvalidParameters('data.reference');
    }
    if ( ! isset($data->executionType)) {
        throw new TPE_Exception_InvalidParameters('data.executionType');
    }
    
    $testplan = TPE_Testplan::createForUser($user, $data->reference, $data->executionType);
    
    foreach ($data->devices as $details) {
        $device = TPE_Device::createFromHostname($details->hostname);
        $testplan->addDeviceScript($device, implode("\n", $details->script));
    }
    
    $success = true;

} catch (TPE_Exception_InvalidParameters $e) {
    $messages[] = "Invalid parameters";
    $success = false;
} catch (TPE_Exception_NotAuthorised $e) {
    $messages[] = "Not authorised";
    $success = false;
} catch (SihnonFramework_Exception_DatabaseException $e) {
    $messages[] = "Database error " . $e->getMessage();
    var_dump($e);
    $success = false;
}

$this->smarty->assign('messages', $messages);
$this->smarty->assign('success', $success);

?>