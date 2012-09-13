<?php

if (isset($_SERVER['TPE_CONFIG']) && 
    file_exists($_SERVER['TPE_CONFIG']) &&
    is_readable($_SERVER['TPE_CONFIG'])) {
    require_once($_SERVER['TPE_CONFIG']);
} else {
    require_once '/etc/testplan-executor/config.php';
}

require_once SihnonFramework_Lib . 'SihnonFramework/Main.class.php';

SihnonFramework_Main::registerAutoloadClasses('SihnonFramework', SihnonFramework_Lib,
                                              'TPE', StatusBoard_Lib);

?>
