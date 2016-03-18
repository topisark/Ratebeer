var BeersController = ['$scope', '$http', function($scope, $http) {

    $http.get('beers.json').success( function(data, status, headers, config) {
        $scope.beers = data;
    });

    $scope.order = 'name';

    $scope.click = function (order){
        $scope.order = order;
        console.log(order);
    }

}];