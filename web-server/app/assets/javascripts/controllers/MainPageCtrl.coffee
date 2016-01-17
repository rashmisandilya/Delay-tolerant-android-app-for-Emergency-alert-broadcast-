controllers = angular.module('controllers')
controllers.controller("MainPageCtrl", [ '$scope', '$modal', ($scope, $modal)->
    $scope.degreeSelection = ['Undergraduate', 'Graduate']
    $scope.departmentSelection = ['CSC', 'ECE']
    
    $scope.modalInstance = undefined
    # Show login modal when the 'Login' button is pressed
    $scope.loginModal = () ->
      $scope.modalInstance = $modal.open({
        templateUrl: 'loginmodal.html',
        controller: 'loginModalCtrl',
        scope: $scope
      });
    # Show signup modal when the 'Signup' button is pressed
    $scope.signupModal = () ->
      $scope.modalInstance = $modal.open({
        templateUrl: 'signupmodal.html',
        controller: 'signupModalCtrl',
        scope: $scope
      });
    # When clicking the area outside the modal, the modal disappears
    $scope.dismiss = () ->
      $scope.modalInstance.dismiss("cancel")


])