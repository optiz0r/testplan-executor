<?php

class TPE_AccessMethod extends TPE_DatabaseObject {
    
    protected static $table = 'accessmethod';
    
    protected $_db_id;
    
    protected $_db_name;
    protected $_db_description;
    protected $_db_plugin;
    protected $_db_options;
    
    public static function fromName($name) {
        return static::from('name', $name);
    }

}

?>