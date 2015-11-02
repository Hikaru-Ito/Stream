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
.directive 'htmlData', ($compile, $parse) ->
  {
    restrict: 'C'
    link: (scope, element, attr) ->
      scope.$watch attr.content, ->
        element.html $parse(attr.content)(scope)
        $compile(element.contents()) scope
      , true
  }
