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
    
    public function deviceResults() {
        if ($this->deviceResults === null) {
            $this->deviceResults = TPE_DeviceResults::allForExecution($this);
        }
        
        return $this->deviceResults;
    }
    
    public function run() {
        $this->started = time();
        
        $deviceResultsSet = $this->deviceResults();
        foreach ($deviceResultsSet as $deviceResults) {
            $deviceScript = TPE_DeviceScript::fromId($deviceResults->deviceScript);
            $device = TPE_Device::fromId($deviceScript->device);
            $accessMethod = TPE_AccessMethod::fromId($device->accessMethod);
            
            $plugin = TPE_DeviceHandler_PluginFactory::create($accessMethod->plugin, json_decode($accessMethod->options));
            
            $deviceResults->started = time();
            $plugin->execute($device, $deviceScript, $deviceResults);
            $deviceResults->completed = time();
            $deviceResults->save();
        }
        
        $this->completed = time();
        $this->save();
    }
}

?>