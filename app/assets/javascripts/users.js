app.controller('UsersController', function($scope, $http) {

    $http.get('users.json').success(function(data) {
        $scope.users = data;
    });

});
