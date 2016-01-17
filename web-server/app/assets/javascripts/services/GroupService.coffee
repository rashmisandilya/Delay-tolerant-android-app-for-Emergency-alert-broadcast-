services = angular.module('services')
services.service('GroupService', ($http) ->  
  list: ->
    $http.get('/groups')

)