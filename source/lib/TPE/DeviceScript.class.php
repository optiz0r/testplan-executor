<?php

class TPE_DeviceScript extends TPE_DatabaseObject {
    
    protected static $table = 'deviceScript';
    
    protected $_db_id;
    protected $_db_created;
    
    protected $_db_testplan;
    protected $_db_device;
    protected $_db_script;
    
    protected function __construct(TPE_Testplan $testplan, TPE_Device $device, $script) {
        $this->created = time();
        
        $this->testplan = $testplan->id;
        $this->device = $device->id;
        $this->script = $script;
    }
    
    public static function createForTestplan(TPE_Testplan $testplan, TPE_Device $device, $script) {
        $newDeviceScript = new self($testplan, $device, $script);
        $newDeviceScript->create();
        
        return $newDeviceScript;
    }

}

?>