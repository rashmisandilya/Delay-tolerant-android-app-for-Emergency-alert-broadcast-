controllers = angular.module('controllers')
controllers.controller("signupModalCtrl", [ '$scope', '$http', '$location', 'Flash',
 ($scope, $http, $location, Flash) ->
  # HTTP Post to /signup API
  $scope.signup = () ->
    if $scope.user
      if $scope.user.username and $scope.user.password and $scope.user.degreeType and $scope.user.degreeType
        if $scope.user.password == $scope.user.confirmation
          console.log $scope.user
          $http.post('/signup', 
                     {username: $scope.user.username, 
                     password: $scope.user.password,
                     degreeType: $scope.user.degreeType,
                     department: $scope.user.department})
          .success((data, status, headers, config) ->
            # Login fail
            if angular.isString(data)
              Flash.create('danger', data, 'flashMsg')
            else
              $scope.dismiss()
              Flash.create('success', "Successfully Signing Up! Please wait for permission from other admins.", 'flashMsg')
          )
        else
          Flash.create('danger', 'Unmatched Password!', 'flashMsg')
    else
      Flash.create('danger', 'Incomplete Form!', 'flashMsg')



])
