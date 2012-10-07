<?php

class TPE_DeviceHandler_Plugin_AlliedTelesisTelnet extends TPE_PluginBase implements TPE_DeviceHandler_IPlugin {
    
    /**
     * Name of this plugin
     * @var string
     */
    const PLUGIN_NAME = 'AlliedTelesysTelnet';
    
    protected $username;
    protected $password;
    
    protected function __construct($options) {
        $this->username = TPE_Main::issetelse($options->username, 'manager');
        $this->password = TPE_Main::issetelse($options->password, 'password');
    }
    
    public static function init() {
    
    }
    
    public static function create($options) {
        return new self($options);
    }
    
    public function execute(TPE_Device $device, TPE_DeviceScript $deviceScript, TPE_DeviceResults $deviceResults) {
        $errno = null;
        $errstr = null;
        
        $s = fsockopen($device->address, 23, $errno, $errstr);
        if ($s === false) {
            throw new TPE_Exception_DeviceConnectionFailed($errstr);
        }
        
        fwrite($s, $this->username . "\n");
        fwrite($s, $this->password . "\n");
        fwrite($s, "disable clipaging\n");
        fwrite($s, $deviceScript->script . "\n");
        fwrite($s, "logout\n");
        
        $deviceResults->results = '';
        while ( ! feof($s)) {
            $buffer = fread($s, 8192);
            $deviceResults->results .= $buffer;
        }
        
        fclose($s);
    }
    
    public function teardown() {
        
    }
    
}

?>