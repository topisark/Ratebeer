app.controller("UsersController", ['$scope', '$http', function($scope, $http) {

    $http.get('users.json').success(function (data) {
        $scope.users = data;
    });

}]);


