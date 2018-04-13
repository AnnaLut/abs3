angular.module(globalSettings.modulesAreas)
    .directive('numericOnly',
    function () {
        return {
            require: 'ngModel',
            link: function (scope, element, attr, ngModelCtrl) {
                function fromUser(text) {
                    if (text) {
                        var transformedInput = text.replace(/[^0-9]/g, '');

                        if (transformedInput !== text) {
                            ngModelCtrl.$setViewValue(transformedInput);
                            ngModelCtrl.$render();
                        }
                        return transformedInput;
                    }
                    return undefined;
                }
                ngModelCtrl.$parsers.push(fromUser);
            }
        };
        //return {
        //    require: 'ngModel',
        //    link: function(scope, element, attrs, modelCtrl) {

        //        modelCtrl.$parsers.push(function(inputValue) {

        //            var transformedInput = inputValue ? inputValue.replace(/[^\d]/g, '') : null;

        //            if (transformedInput !== inputValue) {
        //                modelCtrl.$setViewValue(transformedInput);
        //                modelCtrl.$render();
        //            }

        //            return transformedInput;
        //        });
        //    }
        //};
    });