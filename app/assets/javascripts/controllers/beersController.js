app.controller('BeersController', function ($scope, $http) {
    $http.get('beers.json').success( function(data, status, headers, config) {
        $scope.beers = data;
    });
});