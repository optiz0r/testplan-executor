<?php

class TPE_Template_Command extends TPE_DatabaseObject {
    
    protected static $table = 'template_command';
    
    protected $_db_id;
    protected $_db_command;
    protected $_db_hidden;
    protected $_db_ui;
    protected $_db_label;
    protected $_db_listItemUi;
    
    public static function allForDeviceType(TPE_Template_DeviceType $deviceType) {
        return static::allFor('template_deviceType', $deviceType->id, null, null, null, 'order', TPE_DatabaseObject::ORDER_ASC);
    }
}

?>