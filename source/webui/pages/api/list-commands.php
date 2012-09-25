<?php

$main   = TPE_Main::instance();
$req    = $main->request();

$messages = array();
$success = null;

$commandList = array();

try {
    $commands = TPE_Command::all();
    
    foreach ($commands as $command) {
        $commandList[$command->name] = explode("\n", $command->parameters);
    }
    
    $success = true;
    
} catch (SihnonFramework_Exception_DatabaseException $e) {
    $messages[] = "Database error " . $e->getMessage();
    $success = false;
}

$this->smarty->assign('messages', $messages);
$this->smarty->assign('success', $success);
$this->smarty->assign('commands', $commandList);

?>