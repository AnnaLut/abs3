angular.module("BarsWeb.Areas").controller("CreditUi.dataMaturityCtrl", ["$scope", "$http", "$rootScope", function ($scope, $http, $rootScope) {
    var url = bars.config.urlContent("/creditui/newcredit/");
    $scope.onChangeNumber = function (id) { $rootScope.credit[id] = Math.round($rootScope.credit[id]); };

    $scope.ddlRangOptions = {
        autoBind: false,
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: url + "getRang",
                    data: { vidd: function () { return $rootScope.credit.viddValue.VIDD; } },
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "RANG",
        dataBound: function (e) {
            if($rootScope.credit.rangValue == null)
            {
                this.select(0);
                $rootScope.credit.rangValue = { RANG: this.value() };
            }
        },
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
            { ID: "2", NAME: "Альтернативний день" }
        ],
        dataTextField: "NAME",
        dataValueField: "ID"
    };

    $scope.dpDateFormatOptions = {
        format: "dd/MM/yyyy"
    };

    $scope.ddlListHolidays = {
        dataSource: [
            { ID: "0", NAME: "З канікулами" },
            { ID: "1", NAME: "Без канікул" },
            { ID: "9", NAME: "Відміна канікул" }
        ],
        dataTextField: "NAME",
        dataValueField: "ID"
    };

    $scope.ddlDayNP = {
        dataSource: {
            transport: {
                read: {
                    url: url + "getDaynpList",
                    dataType: "json"
                }
            }
        },
        dataTextField: "Value",
        dataValueField: "Key"
    };

    $rootScope.LoadRangs = function () {
        $scope.ddlRang.dataSource.read();
    }
}]);