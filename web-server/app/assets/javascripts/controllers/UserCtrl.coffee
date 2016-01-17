controllers = angular.module('controllers')
controllers.controller("UserCtrl", ($location, $scope,$modal,$routeParams,GroupService,UserService)->
  # Fetch Groups data when users page is opened
  GroupService.list().success((data) ->
    $scope.groups = data
    )
  # Fetch Users data when users page is opened
  UserService.list().success((data) ->
    $scope.users = data
    )

  # Modal shows up when clicking on the 'Edit Group Members' buttons
  $scope.groupModal = () ->
    $scope.modalInstance = $modal.open({
      templateUrl: 'editgroup.html',
      scope: $scope
    });

  # Modal shows up when clicking on the 'Logout' buttons
  $scope.logout = () ->
    console.log "Logout"
    $location.url('/')

)

