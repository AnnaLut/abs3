angular.module("BarsWeb.Areas").controller("Credit.creditParamsCtrl", ["$scope", "$http", "$rootScope", function ($scope, $http, $rootScope) {
    var url = bars.config.urlContent("/credit/newcredit/");

    angular.element(document).ready(function () {
        var url = '/api/kernel/Params/GetParam/?id=MFO';
        $http.get(bars.config.urlContent(url)).then(function (request) {
            $rootScope.credit.mfoValue = request.data.Value;
        });
        url = '/api/kernel/Params/GetParam/?id=NAME';
        $http.get(bars.config.urlContent(url)).then(function (request) {
            $rootScope.credit.branchNameValue = request.data.Value;
        });
    });

    var checkRisk = function () {
        if ($rootScope.credit.finValue != null && $rootScope.credit.obsValue != null) {
            var url = '/credit/newcredit/getCRisk/?fin=' + $rootScope.credit.finValue.FIN + "&obs=" + $rootScope.credit.obsValue.OBS;
            $http.get(bars.config.urlContent(url)).then(function (request) {
                if (request.data.length > 0) {
                    $rootScope.credit.sIdValue = request.data[0].CRISK;
                    $rootScope.credit.sCatValue = request.data[0].NAME;
                }
            });
        }
    }
    $scope.ddlCurOptions = {
        dataSource: {
            cache: false,
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
    $scope.ddlFinOptions = {
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: url + "getStanFin",
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "FIN",
        change: checkRisk,
        dataBound: checkRisk
    };
    $scope.ddlObsOptions = {
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: url + "getStanObs",
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "OBS",
        change: checkRisk,
        dataBound: checkRisk
    };
    $scope.ddlViddOptions = {
        //autoBind: false,
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: url + "getVidd",
                    data: { rnk: function () { return $rootScope.credit.rnkValue; } },
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "VIDD"
    };
    $scope.ddlSourOptions = {
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: url + "getSour",
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "SOUR"
    };
    $scope.ddlAimOptions = {
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: url + "getAim",
                    data: {
                        rnk: function () {
                            return $rootScope.credit.rnkValue;
                        },
                        dealDate: function () {
                            var date = kendo.toString(kendo.parseDate($rootScope.credit.startValue), 'dd.MM.yyyy');
                            return date;
                        }
                    },
                    dataType: "json"
                }
            }
        },
        //autoBind: false,
        dataTextField: "NAME",
        dataValueField: "AIM"
    };
    $scope.ddlBaseyOptions = {
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: url + "getBasey",
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "BASEY"
    };
    $scope.dpConslOptions = {
        format: "{0:dd.MM.yyyy}",
        mask: "00.00.0000"
    };
    $scope.showReferBranch = function (tabName, showFields, whereClause) {
        bars.ui.handBook(tabName, function (data) {
            $rootScope.credit.branchValue = data[0].BRANCH;
            $scope.$apply();
        },
        {
            multiSelect: false,
            clause: whereClause,
            columns: showFields
        });
    }
    $scope.showReferCust = function (tabName, showFields, whereClause) {
        bars.ui.handBook(tabName, function (data) {
            $rootScope.credit.custValue = data[0].OKPO;
            $rootScope.credit.rnkValue = data[0].RNK;
            $rootScope.credit.nmkValue = data[0].NMK;
            $rootScope.$apply();
            $scope.ddlVidd.dataSource.read();
        },
        {
            multiSelect: false,
            clause: $rootScope.whereForCust,
            columns: showFields
        });
    }
    $scope.showReferProd = function (tabName, showFields) {
        var date = kendo.toString(kendo.parseDate($rootScope.credit.startValue), 'dd.MM.yyyy');
        var whereClause = "where substr(id, 0, 4) in " +
                          "      (select (case " +
                          "                 when (select custtype from customer where rnk = " + $rootScope.credit.rnkValue + ") = 3 then " +
                          "                  nbsf " +
                          "        else " +
                          "                  nbs " +
                          "               end) " +
                          "         from cc_aim " +
                          "        where aim = " + $rootScope.credit.aimValue.AIM + ") " +
                          "   or substr(id, 0, 4) in " +
                          "      (select (case " +
                          "                 when (select custtype from customer where rnk = " + $rootScope.credit.rnkValue + ") = 3 then " +
                          "                  nbsf2" +
                          "        else " +
                          "                  nbs2 " +
                          "               end) " +
                          "        from cc_aim " +
                          "       where aim = " + $rootScope.credit.aimValue.AIM + ")";
        bars.ui.handBook(tabName, function (data) {
            $rootScope.credit.prodValue = data[0].ID;
            $rootScope.credit.prodNameValue = data[0].NAME;
            $scope.$apply();
        },
        {
            multiSelect: false,
            clause: whereClause,
            columns: showFields
        });
    }
    $scope.showReferBRate = function (tabName, showFields, whereClause) {
        bars.ui.handBook(tabName, function (data) {
            $rootScope.credit.baseRateValue = data[0].BR_ID;
            $rootScope.credit.baseRateNameValue = data[0].NAME;
            $scope.$apply();
        },
        {
            multiSelect: false,
            clause: whereClause,
            columns: showFields
        });
    }
    $scope.showReferBanks = function (tabName, showFields, whereClause) {
        bars.ui.handBook(tabName, function (data) {
            $rootScope.credit.mfoValue = data[0].MFO;
            $rootScope.credit.branchNameValue = data[0].NB;
            $scope.$apply();
        },
        {
            multiSelect: false,
            clause: whereClause,
            columns: showFields
        });
    }
}]);