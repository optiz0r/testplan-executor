<?php

class TPE_Testplan extends TPE_DatabaseObject {
    
    protected static $table = 'testplan';
    
    protected $_db_id;
    protected $_db_created;
    protected $_db_owner;
    
    protected function __contruct($owner) {
        $this->created = time();
        $this->owner   = $owner;
    }
    
    public static function createForUser($owner) {
        $newTestplan = new self($owner);
        $newTestplan->create();
        
        return $newTestplan;
    }
    
    public function addDeviceScript(TPE_Device $device, $script) {
        $deviceScript = TPE_DeviceScript::create($device, $script);
    }
}

?>