<?php

class TPE_Testplan extends TPE_DatabaseObject {
    
    protected static $table = 'testplan';
    
    protected $_db_id;
    protected $_db_created;
    protected $_db_owner;
    protected $_db_reference;
    
    protected $executions = null;
    protected $deviceScripts = null;
    
    public static function createForUser($owner, $reference) {
        $newTestplan = new self();
        $newTestplan->created = time();
        $newTestplan->owner = $owner->id;
        $newTestplan->reference = $reference;
        $newTestplan->create();
        
        return $newTestplan;
    }
    
    public function addDeviceScript(TPE_Device $device, $script) {
        $deviceScript = TPE_DeviceScript::createForTestplan($this, $device, $script);
    }
    
    public function executions() {
        if ($this->executions === null) {
            $this->exeuctions = TPE_Execution::allForTestplan($this);
        }
        
        return $this->executions;
    }
    
    public function deviceScripts() {
        if ($this->deviceScripts === null) {
            $this->deviceScripts = TPE_DeviceScript::allForTestplan($this);
        }
        
        return $this->deviceScripts;
    }
}

?>