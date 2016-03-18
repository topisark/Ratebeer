var app = angular.module('beerApp', ['ngRoute', 'templates'])
    .config(function ($routeProvider, $locationProvider) {
        $routeProvider
            .when('/beers', {
                templateUrl: 'beers/index.html',
                controller: 'BeersController'
            })
            .when('/breweries', {
                templateUrl: 'breweries/index.html',
                controller: 'BreweriesController'
            })
            .when('/users', {
                templateUrl: 'users/index.html',
                controller: 'UsersController'
            });
        $locationProvider.html5Mode(true);
    });
