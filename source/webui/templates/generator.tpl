<h1 class="header">Prepare new testplan</h1>

<div class="container" ng-controller="testplanGenerator">
    <div class="row">
        <div class="span6">
            <div class="row">
                <form class="form-horizontal">
                    <fieldset>
                        <legend>Details</legend>
                        <div class="control-group">
                            <label class="control-label">Reference</label>
                            <div class="controls">
                                <input type="text" value="" placeholder="" ng-model="reference"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Execution Type</label>
                            <div class="controls">
                                <label class="radio" ng-repeat="type in executionTypes">
                                    <input type="radio" name="executionType" value="{literal}{{type.value}}{/literal}" ng-model="selectedExecutionType" ng-checked="type.value == selectedExecutionType">
                                    {literal}{{type.label}}{/literal}
                                </label>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
            <div class="row">
                <form class="form-horizontal">
                    <fieldset>
                        <legend>Add new template</legend>
                        <div class="control-group">
                            <label class="control-label">Name</label>
                            <div class="controls">
                            <input type="text" value="" placeholder="Filter:" ng-model="query.name" class="search-query span1" />
                                <select ng-model="selectedTemplate" ng-options="plan as plan.name for plan in templates  | filter:query"></select>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <button class="btn btn-secondary" ng-click="addTemplate(selectedTemplate)">
                                    <i class="icon-plus"></i>
                                    Add
                                </button>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
            <div class="row">
                <form class="form-horizontal">
                    <fieldset ng-repeat="testplan in testplans">
                        <legend class="testplan">
                            {literal}{{testplan.name}}{/literal}
                            <button class="btn btn-danger btn-small pull-right" ng-click="remove(testplans, $index);">
                                <i class="icon-trash"></i>
                                Remove
                            </button>
                        </legend>
                        
                        <div class="control-group">
                            <label class="control-label">Device Type</label>
                            <div class="controls">
                                <input type="text" value="" placeholder="Filter:" ng-model="newDeviceTypeQuery.name" class="search-query span1" />
                                <select ng-model="testplan.newDeviceType" ng-options="deviceType as deviceType.name for deviceType in testplan.template.deviceTypes | filter:newDeviceTypeQuery"></select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Hostname</label>
                            <div class="controls">
                                <input type="text" value="" placeholder="Filter:" ng-model="newDeviceHostnameQuery.hostname" class="search-query span1" />
                                <select ng-model="testplan.newHostname" ng-options="device.hostname as device.hostname for device in devices | filter:newDeviceHostnameQuery"></select>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <button class="btn btn-secondary" ng-click="addDevice(testplan);">
                                    <i class="icon-plus"></i>
                                    Add
                                </button>
                            </div>
                        </div>
                        
                        <fieldset ng-repeat="device in testplan.devices">
                            <legend class="device">
                                {literal}{{device.name}}{/literal}
                                <button class="btn btn-danger btn-small pull-right" ng-click="remove(testplan.devices, $index)">
                                    <i class="icon-trash"></i>
                                    Remove
                                </button>
                            </legend>
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
                    <div class="code" ng-bind-html-unsafe="{literal}displayCommand({execute: 'comment'}, '*** ' + testplan.name){/literal}"></div>
                    <div ng-repeat="device in testplan.devices">
                        <div class="code" ng-bind-html-unsafe="{literal}displayCommand({execute: 'comment'}, device.name){/literal}"></div>
                        <div ng-repeat="command in device.commands">
                            <ng-include src="'command_output.tpl'"></ng-include>
                        </div>
                    </div>
                </div>
            </div>
            <button ng-click="executeTestplan()" class="btn btn-primary"><i class="icon-play icon-white"></i> Execute Testplan</button>
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
        <div ng-switch-when="list">
            <div class="control-group">
                <label class="control-label">{literal}{{command.label}}{/literal}</label>
                <ng-include src="'command_input_listitem.tpl'" ng-repeat="listItem in command.listItems"></ng-include>
            </div>
            <div class="control-group">
                <ng-include src="'command_input_newlistitem.tpl'"></ng-include>
            </div>
        </div>
    </ng-switch>
</script>
<script type="text/ng-template" id="command_input_listitem.tpl">
    <ng-switch on="command.listItemUi">
        <div ng-switch-when="text">
            <div class="controls">
                <input type="text" ng-model="listItem.value" />
                <button class="btn btn-danger btn-small" ng-click="removeListItem(command, $index)">
                    <i class="icon-trash"></i>
                    Remove
                </button>
            </div>
        </div>
        <div ng-switch-default>
            Unsupported UI
        </div>
    </ng-switch>
</script>
<script type="text/ng-template" id="command_input_newlistitem.tpl">
    <ng-switch on="command.listItemUi">
        <div ng-switch-when="text">
            <div class="controls">
                <input type="text" ng-model="command.newListItemValue" placeholder="{literal}{{command.listItemPlaceholder}}{/literal}" />
            </div>
            <div class="controls">
                <button class="btn btn-secondary" ng-click="addListItem(command)">
                    <i class="icon-plus"></i>
                    Add
                </button>
            </div>
        </div>
        <div ng-switch-default>
            <div class="controls">
                Unsupported UI
            </div>
        </div>
    </ng-switch>
</script>
<script type="text/ng-template" id="command_output.tpl">
    <ng-switch on="command.ui">
        <div ng-switch-when="list">
            <ng-include src="'command_output_listitem.tpl'" ng-repeat="listItem in command.listItems"></ng-include>
        </div>
        <div ng-switch-default>
            <div class="code" ng-bind-html-unsafe="displayCommand(command, commandValue(command.ui, command))" />
        </div>
    </ng-switch>
</script>
<script type="text/ng-template" id="command_output_listitem.tpl">
    <ng-switch on="command.ui">
        <div ng-switch-default>
            <div class="code" ng-bind-html-unsafe="displayCommand(command, commandValue(command.listItemUi, listItem))" />
        </div>
    </ng-switch>
</script>