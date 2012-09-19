<?php

class TPE_DeviceResults extends TPE_DatabaseObject {
    
    protected static $table = 'deviceResults';
    
    protected $_db_id;
    
    protected $_db_created;
    protected $_db_started;
    protected $_db_completed;
    protected $_db_owner;
    
    protected $_db_execution;
    protected $_db_deviceScript;
    
    protected $_db_results;
}

?>
