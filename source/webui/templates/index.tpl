<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html ng-app="tpe">
    <head>
        <title>Testplan Executor</title>

        <!-- JQuery //-->
        <script src="{$base_uri}lib/jquery/js/jquery-1.8.1.min.js"></script>

        <!-- Bootstrap //-->
        <link rel="stylesheet" type="text/css" href="{$base_uri}lib/bootstrap/css/bootstrap.min.css" />
        <script type="text/javascript" src="{$base_uri}lib/bootstrap/js/bootstrap.min.js"></script>

        <!-- Angular JS //-->
        <script src="{$base_uri}lib/angular/js/angular-1.0.2.min.js"></script>

        <link rel="stylesheet" type="text/css" href="{$base_uri}css/styles.css" />
        <script src="{$base_uri}lib/sihnon/sihnon-framework.js"></script>
        <script src="{$base_uri}js/directives.js"></script>
        <script src="{$base_uri}js/filters.js"></script>
        <script src="{$base_uri}js/controllers.js"></script>
        <script src="{$base_uri}js/app.js"></script>
    </head>
    <body>
        <div class="navbar navbar-fixed-top navbar-inverse no-print">
            <div class="navbar-inner">
                <div class="container">
                    <a class="brand" href="#">TPE</a>
                    {$page->include_template('fragments/navigation')}
                </div>
            </div>
        </div>
        
        <div class="container" id="content">
            <div class="row">
                {if ! $messages}
                    {$session = TPE_Main::instance()->session()}
                    {$messages = $session->get('messages')}
                    {$session->delete('messages')}
                {/if}
                {if $messages}
                    <div class="row">
                        <div class="span12" id="messages">
                            {foreach from=$messages item=message}
                                {if is_array($message)}
                                    {$severity=$message['severity']}
                                    <div class="alert alert-{$severity}">
                                        <a class="close" data-dismiss="alert">&times;</a>
                                        {$message['content']|escape:html}
                                    </div>
                                {else}
                                    <div class="alert alert-info">
                                        <a class="close" data-dismiss="alert">&times;</a>
                                        {$message|escape:html}
                                    </div>
                                {/if}
                            {/foreach}
                        </div><!-- /messages -->
                    </div>
                {/if}

                <article id="content">
                    {$page_content}
                </article>
            </div>
            <div class="row">
                <footer class="span12">
                    <p>
                        Powered by
                        <a href="https://github.com/optiz0r/testplan-exector/" title="Testplan Executor">Testplan Executor</a>
                        <a href="https://github.com/optiz0r/testplan-exector/{$version}" title="Testplan Executor {$version}">{$version}</a>
                        written by <a xmlns:cc="http://creativecommons.org/ns#" href="http://benroberts.net" property="cc:attributionName" rel="cc:attributionURL">Ben Roberts</a>.
                        <br />
                        This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.
                        <br />
                        <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">
                            <img alt="Creative Commons Licence" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" />
                        </a>
                    </p>
                </footer>
            </div>
        </div>
    </body>
</html>

