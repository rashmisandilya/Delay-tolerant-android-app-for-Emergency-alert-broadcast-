controllers = angular.module('controllers')
controllers.controller("loginModalCtrl", [ '$scope', '$http', '$location', 'Flash',
 ($scope, $http, $location, Flash) ->
  # HTTP Post to the /login_front API, the user's info will come back after successfully logging in
  $scope.login = () ->
    if $scope.user
      if $scope.user.username and $scope.user.password
        $http.post('/login_front', 
                   {username: $scope.user.username, 
                   password: $scope.user.password})
        .success((data, status, headers, config) ->
          console.log data

          # Login fail
          if angular.isString(data)
            Flash.create('danger', data, 'flashMsg')
          else
            $scope.dismiss()
            # $window.location.href = '/users/' + data.id
            $location.url('/users/' + data.id)
        )
    else
      Flash.create('danger', 'Incomplete Form!', 'flashMsg')



])
