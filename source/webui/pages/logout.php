<?php

$auth = TPE_Main::instance()->auth();
$auth->deauthenticate();

TPE_Page::redirect('home');

?>