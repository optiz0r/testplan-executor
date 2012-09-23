<?php

class TPE_DeviceResults extends TPE_DatabaseObject {
    
    protected static $table = 'deviceresults';
    
    protected $_db_id;
    
    protected $_db_created;
    protected $_db_started;
    protected $_db_completed;
    protected $_db_owner;
    
    protected $_db_execution;
    protected $_db_deviceScript;
    protected $_db_results;
    
    public static function createForExecution(TPE_Execution $execution, TPE_DeviceScript $deviceScript, $owner) {
        $newDeviceResults = new self();
        $newDeviceResults->created = time();
        $newDeviceResults->owner = $owner->id;
        $newDeviceResults->execution = $execution->id;
        $newDeviceResults->deviceScript = $deviceScript->id;
        $newDeviceResults->create();
        
        return $newDeviceResults;
    }
    
    public static function allForExecution(TPE_Execution $execution) {
        return static::allFor('execution', $execution->id);
    }
}

?>