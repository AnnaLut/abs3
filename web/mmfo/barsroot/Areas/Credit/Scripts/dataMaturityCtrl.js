angular.module("BarsWeb.Areas").controller("Credit.dataMaturityCtrl", ["$scope", "$http", "$rootScope", function ($scope, $http, $rootScope) {
    var url = bars.config.urlContent("/credit/newcredit/");
    $scope.ddlRangOptions = {
        dataSource: {
            transport: {
                read: {
                    url: url + "getRang",
                    data: { rnk: function () { return $rootScope.credit.rnkValue; } },
                    dataType: "json"
                }
            }
        },
        //autoBind: false,
        dataTextField: "NAME",
        dataValueField: "RANG"
    };
    $scope.ddlFreqOptions = {
        dataSource: {
            transport: {
                read: {
                    url: url + "getFreq",
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "FREQ"
    };
    $scope.ddlFreqIntOptions = {
        dataSource: {
            transport: {
                read: {
                    url: url + "getFreq",
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "FREQ"
    };
    $scope.ddlPreviousOptions = {
        dataSource: [
            { ID: "0", NAME: "День" },
            { ID: "1", NAME: "Місяць" },
            { ID: "2", NAME: "Інше" }
        ],
        dataTextField: "NAME",
        dataValueField: "ID"
    };
    $scope.dpDateFormatOptions = {
        format: "{0:dd.MM.yyyy}",
        mask: "00.00.0000"
    };

    $scope.diffDaysChange = function () {
        console.log($rootScope.credit.diffDaysValue);
        console.log($scope.tbDayPayDiff);
        /*if ($rootScope.credit.diffDaysValue) {
            $scope.tbDayPayDiff.removeAttr("disabled");
        }*/
    };
}]);