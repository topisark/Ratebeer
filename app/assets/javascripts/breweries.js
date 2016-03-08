BreweriesController = ['$scope', '$http', function($scope, $http) {
    $http.get('breweries.json').success( function(data, status, headers, config) {
        $scope.breweries = data;
    });

    $scope.order = 'name';

    $scope.click = function (order){
        $scope.order = order;
        console.log(order);
    }

    $scope.activeOrder = 'name';

    $scope.activeClick = function (order){
        $scope.activeOrder = order;
        console.log(order);
    }

    $scope.searchText = '';
}]