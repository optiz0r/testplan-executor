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
    
    if ($req->exists('refresh')) {
        if ( ! isset($data->testplanId)) {
            throw new TPE_Exception_InvalidParameters('data.testplanId');
        }
        if ( ! isset($data->executionType)) {
            throw new TPE_Exception_InvalidParameters('data.executionType');
        }
        
        $testplan = TPE_Testplan::fromId($data->testplanId);
        $execution = TPE_Execution::createForTestplan($testplan, $user, $data->executionType);
        
        $success = true;
    
    } else {
        if ( ! isset($data->devices)) {
            throw new TPE_Exception_InvalidParameters('data.devices');
        }
        if ( ! isset($data->reference)) {
            throw new TPE_Exception_InvalidParameters('data.reference');
        }
        if ( ! isset($data->executionType)) {
            throw new TPE_Exception_InvalidParameters('data.executionType');
        }
        
        $testplan = TPE_Testplan::createForUser($user, $data->reference);
        
        foreach ($data->devices as $details) {
            $device = TPE_Device::createFromHostname($details->hostname);
            $testplan->addDeviceScript($device, implode("\n", $details->script));
        }
        
        $execution = TPE_Execution::createForTestplan($testplan, $user, $data->executionType);
        
        $success = true;
    }
} catch (TPE_Exception_InvalidParameters $e) {
    $failureMessage = "The request contained invalid data.";
    $success = false;
} catch (TPE_Exception_NotAuthorised $e) {
    $failureMessage = "You must be logged in to perform this action.";
    $success = false;
} catch (SihnonFramework_Exception_DatabaseException $e) {
    $failureMessage = "A database error occurred: " . $e->getMessage();
    $success = false;
}

$this->smarty->assign('failureMessage', $failureMessage);
$this->smarty->assign('messages', $messages);
$this->smarty->assign('success', $success);

?>