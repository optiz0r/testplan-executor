angular.module('tpeDirectives', []).directive('ngTimeago', function(dateFilter) {
    return function(scope, element, attrs) {
        scope.$watch(attrs.ngModel, function(value) {
            var time = 'unknown';
            if (value) {
                time = dateFilter(value * 1000, 'yyyy-MM-ddTHH:mm:ssZ');
            }
            element.attr('datetime', time).attr('title', time).text(time);
        });
    }
});