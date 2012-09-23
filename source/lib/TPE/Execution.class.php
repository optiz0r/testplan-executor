<?php

class TPE_Execution extends TPE_DatabaseObject {
    
    protected static $table = 'execution';
    
    protected $_db_id;
    
    protected $_db_created;
    protected $_db_started;
    protected $_db_completed;
    
    protected $_db_testplan;
    protected $_db_owner;
    protected $_db_executionType;
    
    protected $deviceResults = null;
    
    public static function createForTestplan(TPE_Testplan $testplan, $owner, $executionType) {
        $newExecution = new self();
        $newExecution->created = time();
        $newExecution->testplan = $testplan->id;
        $newExecution->owner = $owner->id;
        $newExecution->executionType = $executionType;
        $newExecution->create();
        
        $newExecution->deviceResults = array();
        foreach ($testplan->deviceScripts() as $deviceScript) {
            $newExecution->deviceResults[] = TPE_DeviceResults::createForExecution($newExecution, $deviceScript, $owner);
        }
        
        return $newExecution;
    }
    
    public static function allForTestplan(TPE_Testplan $testplan) {
        return static::allFor('testplan', $testplan->id);
    }
    
}

?>