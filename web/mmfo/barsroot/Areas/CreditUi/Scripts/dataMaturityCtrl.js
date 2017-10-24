angular.module("BarsWeb.Areas").controller("CreditUi.dataMaturityCtrl", ["$scope", "$http", "$rootScope", function ($scope, $http, $rootScope) {
    var url = bars.config.urlContent("/creditui/newcredit/");

    $scope.onChangeNumber = function (id) { $rootScope.credit[id] = Math.round($rootScope.credit[id]); };

    $scope.ddlRangOptions = {
        dataSource: {
            transport: {
                read: {
                    url: url + "getRang",
                    data: { rnk: function () { return $rootScope.custtype; } },
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
        format: "dd/MM/yyyy"
    };

    $scope.diffDaysChange = function () {
        /*console.log($rootScope.credit.diffDaysValue);
        console.log($scope.tbDayPayDiff);
        /*if ($rootScope.credit.diffDaysValue) {
            $scope.tbDayPayDiff.removeAttr("disabled");
        }*/
    };
}]);