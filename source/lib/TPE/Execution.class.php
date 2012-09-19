<?php

class TPE_Execution extends TPE_DatabaseObject {
    
    protected static $table = 'execution';
    
    protected $_db_id;
    
    protected $_db_created;
    protected $_db_started;
    protected $_db_completed;
    protected $_db_owner;
    
}

?>