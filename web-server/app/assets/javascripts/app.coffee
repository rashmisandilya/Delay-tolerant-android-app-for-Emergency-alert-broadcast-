MPApp = angular.module('MPApp',[
  'templates',
  'ngRoute',
  'controllers',
  'directives',
  'services',
  'ui.bootstrap',
  'flash'
])

MPApp.config(['$routeProvider', 
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'MainPageCtrl'
      )
      .when('/users/:id',
        templateUrl: "show.html"
        controller: 'UserCtrl'
      )
])

controllers = angular.module('controllers',[])
directives = angular.module('directives', [])
services = angular.module('services', [])
