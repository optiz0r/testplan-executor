function testplanGenerator($scope, $http) {
    
    $scope.commands = {};
    $scope.testplans = [];

    $http.get(base_uri + 'js/commands.json').success(function(data) {
        $scope.commands = data;
    });
    
    $http.get(base_uri + 'js/testplans.json').success(function(data) {
        $scope.testplans = data;
    });

    $scope.displayCommand = function(command) {
        var output = '<div class="code">';
        
        var additions = this.commands[command.execute];

        if (additions) {
            for (var addition in additions) {
                if (matches = additions[addition].match(/^%(\d+|[a-zA-Z_]+)(-)?$/)) {
                    var parameter_name = matches[1];
                    var parameter_negate_exclude = (matches[2] == '-')

                    if ($.isArray(command.values)) {
                        if (command.values.length > parameter_name) {
                            output += command.values[parameter_name] + ' ';
                        } else {
                            console.log("Missing parameter " + parameter_name + " for command " + command);
                        }
                    } else if (Object.prototype.toString.call(command.values) === '[object Object]') {
                        output += command.values[parameter_name] +  ' ';
                    } else {
                        output += command.value + ' ';
                        break; // Only one addition can be substituted
                    }
                } else {
                    output += additions[addition] + ' ';
                }
            } 
        }
        
        output += '</div>';
        
        return output;
    }
    
    $scope.nothidden = function(input) {
        return ! (input && input.hidden);
    }

}

