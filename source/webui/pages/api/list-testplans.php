<?php

$main   = TPE_Main::instance();
$req    = $main->request();
$auth   = $main->auth();

$messages = array();
$success = null;

$testplanList = array();

try {
    $testplans = TPE_Testplan::all();
    
    foreach ($testplans as $testplan) {
        $testplanListItem = array(
            "created" => $testplan->created,
            "owner" => null,
            "reference" => $testplan->reference,
            "deviceScripts" => array(),
            "executions" => array(),
        );
        
        // Add deviceScripts
        $deviceScripts = TPE_DeviceScript::allForTestplan($testplan);
        $deviceScriptsMap = array();
        foreach ($deviceScripts as $deviceScript) {
            $device = TPE_Device::fromId($deviceScript->device);
            
            $deviceScriptListItem = array(
                "created" => $deviceScript->created,
                "device" => array(
                    "hostname" => $device->hostname
                ),
                "script" => $deviceScript->script,
            );
            
            $deviceScriptsMap[$deviceScript->id] = $deviceScriptListItem;
            $testplanListItem["deviceScripts"][] = $deviceScriptListItem;
        }
        
        // Add executions
        $executions = TPE_Execution::allForTestplan($testplan);
        foreach ($executions as $execution) {
            $executionListItem = array(
                'created' => $execution->created,
                'started' => $execution->started,
                'completed' => $execution->completed,
                'owner' => null,
                'executionType' => $execution->executionType,
                'deviceResults' => array(),
            );
            
            // Add deviceResults
            $deviceResults = TPE_DeviceResults::allForExecution($execution);
            foreach ($deviceResults as $deviceResult) {
                $executionListItem['deviceResults'][] = array(
                    'created' => $deviceResult->created,
                    'started' => $deviceResult->started,
                    'completed' => $deviceResult->completed,
                    'owner' => null,
                    'deviceScript' => $deviceScriptsMap[$deviceResult->deviceScript],
                    'results' => $deviceResult->results,
                );
            }
            
            $testplanListItem['executions'][] = $executionListItem;
        }
        
        $testplanList[] = $testplanListItem;
    }
    
    $success = true;
    
} catch (SihnonFramework_Exception_DatabaseException $e) {
    $messages[] = "Database error " . $e->getMessage();
    $success = false;
}

$this->smarty->assign('messages', $messages);
$this->smarty->assign('success', $success);
$this->smarty->assign('testplans', $testplanList);

?>