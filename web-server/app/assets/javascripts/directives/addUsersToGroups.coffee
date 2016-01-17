directives = angular.module('directives')

directives.directive 'adduserstogroups', () ->
  restrict: 'E'    
  templateUrl: 'doubleList.html'
  controller: ($scope, $http, GroupService, Flash) ->
    $scope.selection = []
    # Everytime the user change the groups, get group members of current group
    $scope.update = () ->
      $scope.selection = []
      for group in $scope.groups
        if group.id == $scope.selectedGroup.id
          $http.get('/groups/'+group.id+'/get_members').success((data) ->
            # console.log data
            for user in data
              $scope.selection.push user.id
            )
          break
    # Everytime the user click on the checkbox, group info will be updated
    $scope.toggleSelection = (id) ->
      idx = $scope.selection.indexOf id
      # If the action is to unselect
      if idx > -1
        $scope.selection.splice(idx, 1)
        $http.post('/users/'+id+'/leave_group', {'group_id': $scope.selectedGroup.id})
      else
        $scope.selection.push id
        $http.post('/users/'+id+'/join_group', {'group_id': $scope.selectedGroup.id})

    
