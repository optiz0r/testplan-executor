function testplanGenerator($scope, $http) {
    
    $scope.commands = {};
    
    $scope.templates = [];
    $scope.selectedTemplate = undefined;
    
    $scope.testplans = [];

    $http.get(base_uri + 'js/commands.json').success(function(data) {
        $scope.commands = data;
    });
    
    $http.get(base_uri + 'js/templates.json').success(function(data) {
        $scope.templates = data;
        if ($scope.templates.length > 0) {
            $scope.selectedTemplate = $scope.templates[0];
        }
    });

    $scope.displayCommand = function(command, parameters) {
        var output = '<div class="code">';
        output += $scope.generateCommand(command, parameters);
        output += '</div>';
        
        return output;
    }
    
    $scope.generateCommand = function(command, parameters) {
        var output = '';
        
        var additions = this.commands[command.execute];
        if (additions) {
            for (var addition in additions) {
                if (matches = additions[addition].match(/^%(\d+|[a-zA-Z_]+)(-)?$/)) {
                    var parameter_name = matches[1];

                    if ($.isArray(parameters)) {
                        if (command.values.length > parameter_name) {
                            output += parameters[parameter_name] + ' ';
                        } else {
                            console.log("Missing parameter " + parameter_name + " for command " + command);
                        }
                    } else if (Object.prototype.toString.call(parameters) === '[object Object]') {
                        output += parameters[parameter_name] +  ' ';
                    } else {
                        output += parameters + ' ';
                        break; // Only one addition can be substituted
                    }
                } else {
                    output += additions[addition] + ' ';
                }
            } 
        }
        
        return output;
    }
    
    $scope.executeTestplan = function() {
        var devices = [];
        if ($scope.testplans.length > 0) {
            for (var i = 0, testplan = $scope.testplans[0]; i < $scope.testplans.length; ++i, testplan = $scope.testplans[i]) {
                if (testplan.devices.length > 0) {
                    for (var j = 0, device = testplan.devices[0]; j < testplan.devices.length; ++j, device = testplan.devices[j]) {
                        commands = [];
                        if (device.commands.length > 0) {
                            for (var k = 0, command = device.commands[0]; k < device.commands.length; ++k, command = device.commands[k]) {
                                commands.push($scope.generateCommand(command, command.value));
                            }
                        }
                        if (commands.length > 0) {
                            devices.push({
                                hostname: device,
                                script: commands
                            });
                        }
                    }
                }
            }
        }
        
        $http.post(base_uri + 'ajax/api/queue-execution/', {
            devices: devices
        }).success(function(data, status, headers, config) {
            console.log(status, data);
        }).error(function(data, status, headers, config) {
            console.log(status, data);
        });
    }
    
    $scope.nothidden = function(input) {
        return ! (input && input.hidden);
    }
    
    $scope.addTemplate = function(template) {
        var newDeviceType;
        if (template.deviceTypes.length > 0) {
            newDeviceType = template.deviceTypes[0];
        }
        
        $scope.testplans.push({
            "name": template.name,
            "devices": [],
            "template": template,
            "newDeviceType": newDeviceType
        });
    }
    
    $scope.remove = function(list, index) {
        list.splice(index, 1);
    }
    
    $scope.addDevice = function(testplan) {
        testplan.devices.push({
            "name": testplan.newHostname,
            "commands": jQuery.extend(true, [], testplan.newDeviceType.commands)
        });
        testplan.newHostname = '';
    }
    
    $scope.addListItem = function(command) {
        switch (command.listItemUi) {
            default: {
                command.listItems.push({
                    "value": command.newListItemValue
                });
                command.newListItemValue = '';
            } break;
        }
    }
    
    $scope.removeListItem = function(command, index) {
        command.listItems.splice(index, 1);
    }
}

