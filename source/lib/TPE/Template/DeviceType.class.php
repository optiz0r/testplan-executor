<?php

class TPE_Template_DeviceType extends TPE_DatabaseObject {
    
    protected static $table = 'template_devicetype';
    
    protected $_db_id;
    protected $_db_template_testplan;
    protected $_db_name;
    
    public static function allForTestplan(TPE_Template_Testplan $testplan) {
        return static::allFor('template_testplan', $testplan->id, null, null, null, 'order', TPE_DatabaseObject::ORDER_ASC);
    }
}

?>