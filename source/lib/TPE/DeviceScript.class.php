<?php

class TPE_DeviceScript extends TPE_DatabaseObject {
    
    protected static $table = 'devicescript';
    
    protected $_db_id;
    protected $_db_created;
    
    protected $_db_testplan;
    protected $_db_device;
    protected $_db_script;
    
    public static function createForTestplan(TPE_Testplan $testplan, TPE_Device $device, $script) {
        $newDeviceScript = new self();
        $newDeviceScript->created = time();
        $newDeviceScript->testplan = $testplan->id;
        $newDeviceScript->device = $device->id;
        $newDeviceScript->script = $script;
        $newDeviceScript->create();
        
        return $newDeviceScript;
    }

}

?>