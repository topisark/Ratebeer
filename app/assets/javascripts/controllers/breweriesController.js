app.controller("BreweriesController", ['$scope', '$http', '$filter', function($scope, $http, $filter) {

    var orderBy = $filter('orderBy');

    $http.get('breweries.json').success( function(data, status, headers, config) {
        $scope.breweries = data;
    });

    $scope.orderClick = function (order){
        $scope.breweries = orderBy($scope.breweries, order)
    }

}]);
