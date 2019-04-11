angular.module("BarsWeb.Areas").controller("CreditUi.commitionLimitCtrl", ["$scope", "$http", "$rootScope", function ($scope, $http, $rootScope) {
    var url = bars.config.urlContent("/creditui/newcredit/");

    $scope.ddlCurComAccOptions = {
        dataSource: {
            transport: {
                read: {
                    url: url + "getCurrency",
                    dataType: "json"
                }
            }
        },
        dataTextField: "LCV",
        dataValueField: "KV"
    };
    $scope.ddlMetrOptions = {
        dataSource: {
            transport: {
                read: {
                    url: url + "getMetr",
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "METR",
        optionLabel: " "
    };
}]);