<?php

class TPE_DeviceHandler_Plugin_CiscoTelnet extends TPE_PluginBase implements TPE_DeviceHandler_IPlugin {
    
    /**
     * Name of this plugin
     * @var string
     */
    const PLUGIN_NAME = 'CiscoTelnet';
    
    public static function init() {
        
    }
    
    public static function create($options) {
        return new self($options);
    }
    
    public function execute() {
        
    }
    
    public function teardown() {
        
    }
    
}

?>