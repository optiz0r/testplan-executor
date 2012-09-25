<?php

$main   = TPE_Main::instance();
$req    = $main->request();

$messages = array();
$success = null;

$templateList = array();

try {
    $testplans = TPE_Template_Testplan::all(null, null, null, 'order', TPE_Template_Testplan::ORDER_ASC);
    
    foreach ($testplans as $testplan) {
        $templateListItem = array(
            'name' => $testplan->name,
            'deviceTypes' => array(),
        );
        
        $deviceTypes = TPE_Template_DeviceType::allForTestplan($testplan);
        foreach ($deviceTypes as $deviceType) {
            $deviceTypeListItem = array(
                'name' => $deviceType->name,
                'commands' => array(),
            );
            
            $template_commands = TPE_Template_Command::allForDeviceType($deviceType);
            foreach ($template_commands as $template_command) {
                $command = TPE_Command::fromId($template_command->command);
                
                $commandListItem = array(
                    'execute' => $command->name,
                    'hidden' => $template_command->hidden,
                    'ui' => $template_command->ui,
                    'label' => $template_command->label,
                    'listItemUi' => $template_command->listItemUi,
                    'listItems' => array(),
                );
                
                $deviceTypeListItem['commands'][] = $commandListItem;
            }
            
            $templateListItem['deviceTypes'][] = $deviceTypeListItem;
        }
        
        $templateList[] = $templateListItem;
    }
    
    $success = true;
    
} catch (SihnonFramework_Exception_DatabaseException $e) {
    $messages[] = "Database error " . $e->getMessage();
    $success = false;
}

$this->smarty->assign('messages', $messages);
$this->smarty->assign('success', $success);
$this->smarty->assign('templates', $templateList);

?>