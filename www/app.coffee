angular.module 'stream', [
  'ionic'
  'stream.services.values'
  'stream.controllers.main'
  'stream.directives.endrepeat'
  'stream.models.feed'
]
#
# 起動時に実行するスクリプト
#
.run ($ionicPlatform) ->
  $ionicPlatform.ready ->
    if window.cordova and window.corova.plugins.Keyboard
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar true

    if window.StatusBar
      StatusBar.styleDefault()

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state('main',
      url: '/'
      templateUrl: 'templates/main.html'
      controller: 'MainCtrl'
    )
  $urlRouterProvider.otherwise '/'
