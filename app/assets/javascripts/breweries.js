BreweriesController = ['$scope', '$http', function($scope, $http) {
    $http.get('breweries.json').success( function(data, status, headers, config) {
        $scope.breweries = data;
    });

    $scope.activeOrder = 'name';

    $scope.orderClick = function (order){
        $scope.activeOrder = order;
    }

}]