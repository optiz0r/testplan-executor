<?php

class TPE_DeviceHandler_PluginFactory extends TPE_PluginFactory {
    
    protected static $plugin_prefix    = 'TPE_DeviceHandler_Plugin_';
    protected static $plugin_interface = 'TPE_DeviceHandler_IPlugin';
    protected static $plugin_dir       = array(
        TPE_Lib  => 'TPE/DeviceHandler/Plugin/',
    );
    
    public static function init() {
        
    }
    
}

?>