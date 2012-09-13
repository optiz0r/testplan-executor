<ul class="nav">
    <li {if $requested_page == "generator"}class="active"{/if}><a href="{$base_uri}generator/">Generator</a></li>
    <li {if $requested_page == "history"}class="active"{/if}><a href="{$base_uri}history/">History</a></li>
    {if $authenticated && $auth->isAdministrator()}
        <li class="dropdown {if $requested_page == "admin"}active{/if}">
            <a href="{$base_uri}admin/" class="dropdown-toggle" data-toggle="dropdown" data-target="#" title="Admin">
                Admin
                <b class="caret"></b>
            </a>
            <ul class="dropdown-menu" role="menu">
                <li><a href="{$base_uri}admin/testplans/" title="Manage Available Testplans">Testplans</a></li>
                <li><a href="{$base_uri}admin/history/" title="Manage Execution History">Execution History</a></li>
                <li><a href="{$base_uri}admin/settings/" title="Manage Settings">Settings</a></li>
            </ul>
        </li>
    {/if}
    <li><a href="#">Help</a></li>
</ul>
<ul class="nav pull-right">
    {if $authenticated}
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-target="#" title="Logged in as: {$user->username|escape}">
                {$user->username|escape}
                <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
                <li><a href="{$base_uri}usercp/" title="User control Panel">User Control Panel</a></li>
                <li><a href="{$base_uri}logout/" title="Logout">Logout</a></li>
            </ul>
        </li>
    {else}
        <li><a href="{$base_uri}login/" title="Login">Login</a></li>
    {/if}
</ul>
