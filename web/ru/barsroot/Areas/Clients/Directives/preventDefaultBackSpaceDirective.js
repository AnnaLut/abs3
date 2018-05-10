angular.module('BarsWeb.Controllers').directive('preventdefaultbackspace', function () {
    return {
        restrict: 'E',
        scope: true,
        link: function postLink(scope, iElement) {
            jQuery(document).on('keydown', function (e) {
                scope.$apply(scope.preventDefaultBackSpace(e, iElement));
            });
        }
    };
});
