var tpe = angular.module('tpe', ['tpeDirectives'])

tpe.value('base_uri', base_uri);
tpe.value('base_url', base_url);

tpe.value('executionTypes', [
    {
        value: 0,
        label: "Generic"
    },
    {
        value: 1,
        label: "Build-time"
    }, 
    {
        value: 2,
        label: "Pre-change"
    },
    {
        value: 3,
        label: "Post-change"
    }
]);

tpe.value('ui', {
    list: 0,
    text: 1,
    number: 2
});