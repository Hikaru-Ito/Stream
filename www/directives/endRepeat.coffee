#
# ng-repeatの終了をemitするDirective
#
angular.module('stream.directives.endrepeat', [])
.directive 'endRepeat', ['$timeout', ($timeout) ->
  {
    restrict: 'A',
    link: (scope, element, attr) ->
      if scope.$last is true
        $timeout ->
          scope.$emit 'ngRepeatFinished'
  }
]
