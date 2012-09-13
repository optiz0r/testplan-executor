<?php

$authenticated = false;
$user = null;

$auth = TPE_Main::instance()->auth();
if ($auth->isAuthenticated()) {
    $authenticated = true;
    $user = $auth->authenticatedUser();
}

$this->smarty->assign('authenticated', $authenticated);
$this->smarty->assign('auth', $auth);
$this->smarty->assign('user', $user);
?>