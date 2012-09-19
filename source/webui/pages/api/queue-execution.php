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
    
    $testplan = TPE_Testplan::createForUser($user);
    
    foreach ($data->devices as $details) {
        $device = TPE_Device::createFromHostname($details->hostname);
        $testplan->addDeviceScript($device, $details->script);
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
    $success = false;
}

$this->smarty->assign('messages', $messages);
$this->smarty->assign('success', $success);

?>