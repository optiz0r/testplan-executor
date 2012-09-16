<h1 class="header">Prepare new testplan</h1>

<div class="container" ng-controller="testplanGenerator">
    <div class="row">
        
    </div>

    <div class="row">
        <div class="span6">
            <div class="row">
                <h2>Device Types</h2>
                <form class="form-horizontal">
                    <fieldset ng-repeat="testplan in testplans">
                        <legend class="testplan">{literal}{{testplan.name}}{/literal}</legend>
                        
                        <fieldset ng-repeat="device in testplan.devices">
                            <legend class="device">{literal}{{device.name}}{/literal}</legend>
                                <div ng-repeat="command in device.commands | filter:nothidden">
                                    <ng-include src="'command_input.tpl'"></ng-include>
                                </div>
                        </fieldset>
                    </fieldset>
                </form>
            </div>
            <div class="row">
                <form id="form" class="form-horizontal">
                </form>
            </div>
        </div>
        <div class="span6">
            <h2>Generated Testplan</h2>
            <div class="well">
                <div ng-repeat="testplan in testplans">
                    <div ng-repeat="device in testplan.devices">
                        <div ng-repeat="command in device.commands">
                            <ng-include src="'command_output.tpl'"></ng-include>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/ng-template" id="command_input.tpl">
    <ng-switch on="command.ui">
        <div ng-switch-when="text">
            <div class="control-group">
                <label class="control-label">{literal}{{command.label}}{/literal}</label>
                <div class="controls">
                    <input type="text" ng-model="command.value" />
                </div>
            </div>
        </div>
    </ng-switch>
</script>
<script type="text/ng-template" id="command_output.tpl">
    <ng-switch on="command.ui">
        <div ng-switch-when="text">
            <div class="code" ng-bind-html-unsafe="displayCommand(command)" />
        </div>
        <div ng-switch-default>
            <div class="code" ng-bind-html-unsafe="displayCommand(command)" />
        </div>
    </ng-switch>
</script>