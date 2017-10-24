angular.module("BarsWeb.Areas").controller("Credit.commitionLimitCtrl", ["$scope", "$http", "$rootScope", function ($scope, $http, $rootScope) {
    var url = bars.config.urlContent("/credit/newcredit/");

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

    $scope.ddlListUnsedOptions = {
        dataSource: [{
            id: "0",
            name: "Відновлюваний"
        },
        {
            id: "1",
            name: "Невідновлюваний"
        }],
        dataTextField: "name",
        dataValueField: "id"
    };
}]);