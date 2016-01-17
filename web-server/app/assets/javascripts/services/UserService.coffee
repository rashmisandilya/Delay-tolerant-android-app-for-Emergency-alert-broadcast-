services = angular.module('services')
services.service('UserService', ($http) ->  
  list: ()->
    $http.get('/users')

  get: (id)->
    $http.get('/users/'+id)

)