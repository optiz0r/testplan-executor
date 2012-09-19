<?php

class TPE_Device extends TPE_DatabaseObject {
    
    protected static $table = 'device';
    
    protected $_db_id;
    
    protected $_db_hostname;
    protected $_db_accessMethod;
    protected $_db_address;
    
    protected function __construct($hostname, $accessMethod, $address) {
        $this->hostname = $hostname;
        $this->accessMethod = $accessMethod;
        $this->address = $address;
    }
    
    public static function createFromHostname($hostname) {
        return static::from('hostname', $hostname);
    }

}

?>