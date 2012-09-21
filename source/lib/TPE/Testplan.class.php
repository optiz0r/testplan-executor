<?php

class TPE_Testplan extends TPE_DatabaseObject {
    
    protected static $table = 'testplan';
    
    protected $_db_id;
    protected $_db_created;
    protected $_db_owner;
    protected $_db_reference;
    protected $_db_executionType;
    
    public static function createForUser($owner, $reference, $executionType) {
        $newTestplan = new self();
        $newTestplan->created = time();
        $newTestplan->owner = $owner->id;
        $newTestplan->reference = $reference;
        $newTestplan->executionType = $executionType;
        $newTestplan->create();
        
        return $newTestplan;
    }
    
    public function addDeviceScript(TPE_Device $device, $script) {
        $deviceScript = TPE_DeviceScript::createForTestplan($this, $device, $script);
    }
}

?>