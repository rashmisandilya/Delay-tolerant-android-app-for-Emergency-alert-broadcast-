directives = angular.module('directives')

directives.directive 'chatpanel', () ->
  restrict: 'E'    
  scope: {
    grps: '='
    users: '='
  }
  templateUrl: 'chat.html'
  controller: ($scope, $routeParams, $http, $location, $modal, GroupService, Flash) ->
    $scope.messages = []
    $scope.selected = ''
    $scope.continue = 0
    $http.post('/messages/get_messages', {'user_id': $routeParams.id})
    .success((data) ->
      $scope.messages = data.slice(-4)
      )
    # When groups are fetched, update corresponding variables in the controller
    $scope.$watch('grps', (value) ->
      if value
        $scope.selected = value[0]
        $scope.groupList = value
      )
    # When users are fetched, update corresponding variables in the controller
    $scope.$watch('users', (value) ->
      if value
        $scope.userList = value
      )
    # Actions after clicking on the sending mesasge button
    $scope.sendMsg = () ->
      console.log $scope.msg
      console.log $scope.selected
      $scope.reg_ids = []

      if $scope.selected == '_GPSGroup'
        for u in $scope.userList
          if u.longitude and u.latitude
            if u.reg_id
              $scope.reg_ids.push u.reg_id
        $scope.continue = 1
      else
        $http.get('/groups/'+$scope.selected.id+'/get_members').success((data) ->
          for user in data
            if user.reg_id and user.reg_id not in $scope.reg_ids
              $scope.reg_ids.push user.reg_id

          $scope.continue = 1
          )

      $scope.$watch('continue', (value) ->
        if value == 1
          console.log $scope.reg_ids
          to_send_msg = {'user_id': $routeParams.id, 'heading': $scope.msg.title, 'content': $scope.msg.content}
          to_gcm_msg = {'heading': $scope.msg.title, 'content': $scope.msg.content, 'reg_ids': $scope.reg_ids}
          $http.post('/messages', to_send_msg)
          .success((data) ->
            if $scope.messages.length >= 4
              $scope.messages.shift()
            $scope.messages.push(data)
            )
          $http.post('/users/'+$routeParams.id+'/sendGCM', {'data': to_gcm_msg}).success((response) ->
            console.log response
            )
          $scope.msg.title = ''
          $scope.msg.content = ''
          $scope.continue = 0
        )

    $scope.select = (arg) ->
      $scope.selected = arg
      if arg == '_default'
        $scope.selected = $scope.groupList[0]

    $scope.submit = () ->
      if ($scope.groupName)
        $http.post('/groups', {'group_name': $scope.groupName}).success((data) ->
          console.log data
          $scope.groupName = ''
          GroupService.list().success((data) ->
            Flash.create('success', 'New Group Created!', 'flashMsg')
            $scope.groupList = data
            )
          )


    
