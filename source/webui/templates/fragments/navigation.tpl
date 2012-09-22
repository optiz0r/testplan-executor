<ul class="nav">
    <li {if $requested_page == "generator"}class="active"{/if}><a href="{$base_uri}generator/"><i class="icon-pencil icon-white"></i> Generator</a></li>
    <li {if $requested_page == "history"}class="active"{/if}><a href="{$base_uri}history/"><i class="icon-list icon-white"></i> History</a></li>
    {if $authenticated && $auth->isAdministrator()}
        <li class="dropdown {if $requested_page == "admin"}active{/if}">
            <a href="{$base_uri}admin/" class="dropdown-toggle" data-toggle="dropdown" data-target="#" title="Admin">
                Admin
                <b class="caret"></b>
            </a>
            <ul class="dropdown-menu" role="menu">
                <li><a href="{$base_uri}admin/testplans/" title="Manage Available Testplans">Testplans</a></li>
                <li><a href="{$base_uri}admin/history/" title="Manage Execution History">Execution History</a></li>
                <li><a href="{$base_uri}admin/settings/" title="Manage Settings"><i class="icon-cog"></i> Settings</a></li>
            </ul>
        </li>
    {/if}
    <li><a href="#"><i class="icon-question-sign icon-white"></i> Help</a></li>
</ul>
<ul class="nav pull-right">
    {if $authenticated}
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-target="#" title="Logged in as: {$user->username|escape}">
                <i class="icon-user icon-white"></i> {$user->username|escape}
                <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
                <li><a href="{$base_uri}usercp/" title="User control Panel"><i class="icon-cog"></i> User Control Panel</a></li>
                <li><a href="{$base_uri}logout/" title="Logout"><i class="icon-off"></i> Logout</a></li>
            </ul>
        </li>
    {else}
        <li><a href="{$base_uri}login/" title="Login"><i class="icon-lock icon-white"></i> Login</a></li>
    {/if}
</ul>
