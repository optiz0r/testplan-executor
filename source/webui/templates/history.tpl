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
                            <select size="6" ng-model="selectedTestplan" ng-options="testplan as testplan.reference for testplan in testplans | filter:testplanQuery" ></select>
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
                            <select size="6" ng-model="selectedTestplan.selectedExecution" ng-options="execution as execution.created for execution in selectedTestplan.executions | filter:executionQuery" ></select>
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
        </div>
    </div>
</div>