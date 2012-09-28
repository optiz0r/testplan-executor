<h1 class="header">Past Testplans</h1>

<div class="container" ng-controller="testplanHistory">
    <div class="row">
        <div class="span6">
            <form class="form-horizontal">
                <fieldset>
                    <legend>Testplans</legend>
                    
                    <div class="control-group">
                        <label class="control-label">Filter</label>
                        <div class="controls">
                            <input type="text" value="" placeholder="Reference" ng-model="testplanQuery.reference" class="search-query" />
                            <input type="text" value="" placeholder="User" ng-model="testplanQuery.owner" class="search-query" />
                        </div>
                    </div>
                    
                    <div class="control-group">
                        <label class="control-label">References</label>
                        <div class="controls">
                            <select size="6" ng-model="selectedTestplan" ng-options="testplan as testplan.reference for testplan in testplans | filter:testplanQuery" ng-click="refreshExecutions()"></select>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
        <div class="span6">
            <h2>Details</h2>
            
            <dl class="dl-horizontal">
                <dt>Created</dt>
                <dd><time ng-timeago class="timeago" ng-model="selectedTestplan.created" /></dd>
                
                <dt>Created By</dt>
                <dd>TBC</dd>
            </dl>

            <form class="form-horizontal">
                <fieldset>
                    <legend>Re-run Testplan</legend>
                    <div class="control-group">
                        <label class="control-label">Execution Type</label>
                        <div class="controls">
                            <label class="radio" ng-repeat="type in executionTypes">
                                <input type="radio" name="executionType" value="{literal}{{type.value}}{/literal}" ng-model="selectedExecutionType" ng-checked="type.value == selectedExecutionType">
                                {literal}{{type.label}}{/literal}
                            </label>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"></label>
                        <div class="controls">
                            <button class="btn btn-primary" ng-click="rerunTestplan(selectedTestplan)">
                                <i class="icon-refresh"></i>
                                Execute Testplan
                            </button> 
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
    
    <div class="row">
        <div class="span6">
            <form class="form-horizontal">
                <fieldset>
                    <legend>Executions</legend>
                    
                    <div class="control-group">
                        <label class="control-label">Filter</label>
                        <div class="controls">
                            <input type="text" value="" placeholder="Created" ng-model="executionQuery.owner" class="search-query" />
                        </div>
                    </div>
                    
                    <div class="control-group">
                        <label class="control-label">Created</label>
                        <div class="controls">
                            <select size="6" ng-model="selectedTestplan.selectedExecution" ng-options="execution as execution.created for execution in selectedTestplan.executions | filter:executionQuery" ng-change="refreshDevices()"></select>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
        <div class="span6">
            <h2>Details</h2>
            
            <dl class="dl-horizontal">
                <dt>Started</dt>
                <dd><time ng-timeago class="timeago" ng-model="selectedTestplan.selectedExecution.started" /></dd>
                
                <dt>Completed</dt>
                <dd><time ng-timeago class="timeago" ng-model="selectedTestplan.selectedExecution.completed" /></dd>
                
                <dt>User</dt>
                <dd>TBC</dd>
                
                <dt>Type</dt>
                <dd>TBC</dd>
            </dl>

            <form class="form-horizontal">
                <fieldset>
                    <legend>Download all results</legend>
                    
                    <div class="control-group">
                        <label class="control-label"></label>
                        <div class="controls">
                            <button class="btn btn-secondary" ng-click="downloadExecutionResults(selectedTestplan.selectedExecution)">
                                <i class="icon-download-alt"></i>
                                Download as zip file
                            </button>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="span6">
            <form class="form-horizontal">
                <fieldset>
                    <legend>Devices</legend>
                    
                    <div class="control-group">
                        <label class="control-label">Filter</label>
                        <div class="controls">
                            <input type="text" value="" placeholder="Name" ng-model="deviceResultsQuery.owner" class="search-query" />
                        </div>
                    </div>
                    
                    <div class="control-group">
                        <label class="control-label">Hostnames</label>
                        <div class="controls">
                            <select size="6" ng-model="selectedTestplan.selectedExecution.selectedDeviceResults" ng-options="deviceResults as deviceResults.deviceScript.device.hostname for deviceResults in selectedTestplan.selectedExecution.deviceResults | filter:deviceResultsQuery" ></select>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
        <div class="span6">
            <h2>Results</h2>
            
            <div class="well">
                <div class="code">{literal}{{selectedTestplan.selectedExecution.selectedDeviceResults.results}}{/literal}</div>
            </div>

            <form class="form-horizontal">
                <fieldset>
                    <legend>Download device results</legend>
                    
                    <div class="control-group">
                        <label class="control-label"></label>
                        <div class="controls">
                            <button class="btn btn-secondary" ng-click="downloadDeviceResults(selectedTestplan.selectedExecution.selectedDeviceResults)">
                                <i class="icon-download-alt"></i>
                                Download as text file
                            </button>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>
