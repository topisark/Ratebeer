var app = angular.module('beerApp', ['ngRoute', 'templates'])
    .config(function ($routeProvider, $locationProvider) {
        $routeProvider
            .when('/beers', {
                templateUrl: 'beers/index.html',
                controller: 'BeersController'
            });
        $locationProvider.html5Mode(true);
    });
