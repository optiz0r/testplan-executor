<?php

class TPE_Testplan extends TPE_DatabaseObject {
    
    protected static $table = 'testplan';
    
    protected $_db_id;
    protected $_db_created;
    protected $_db_owner;
    protected $_db_reference;
    
    protected function __contruct($owner, $reference) {
        $this->created = time();
        $this->owner = $owner;
        $this->reference = $reference;
    }
    
    public static function createForUser($owner, $reference) {
        $newTestplan = new self($owner, $reference);
        $newTestplan->create();
        
        return $newTestplan;
    }
    
    public function addDeviceScript(TPE_Device $device, $script) {
        $deviceScript = TPE_DeviceScript::createForTestplan($this, $device, $script);
    }
}

?>