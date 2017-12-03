angular.module("BarsWeb.Areas").controller("CreditUi.creditParamsCtrl", ["$scope", "$http", "$rootScope", function ($scope, $http, $rootScope) {
    var url = bars.config.urlContent("/creditui/newcredit/");

    var creditKeys = ['currBValue', 'currCValue', 'currDValue', 'currEValue'];

    $scope.showReferKv = function (tabName, showFields, whereClause, creditKey) {
        bars.ui.handBook(tabName, function (data) {
                var kv = data[0].KV;
                for(var i = 0; i < creditKeys.length; i++){
                    var k = creditKeys[i];
                    if(k != creditKey && $rootScope.credit[k] == kv){
                        bars.ui.error({ text: "Виберіть іншу валюту" });
                        return;
                    }
                }
                $rootScope.credit[creditKey] = kv;
                $scope.$apply();
            },
            {
                multiSelect: false,
                clause: whereClause,
                columns: showFields
            });
    };

    $scope.clearReferKv = function (creditKey, rateKey) {
        $rootScope.credit[creditKey] = null;
        $rootScope.credit[rateKey] = null;
    };

    $scope.isPruductBtnVisible = function () { return $rootScope.custtype == 3 || $rootScope.custtype == 2; };
    $scope.isPruductBtnEnabled = function () { return $rootScope.credit.aimValue != null; };
    $scope.isDdlAimEnabled = function () { return $rootScope.credit.custValue != null; };

    angular.element(document).ready(function () {

        if (!$rootScope.nd) {
            var url = '/api/kernel/Params/GetParam/?id=MFO';
            $http.get(bars.config.urlContent(url)).then(function (request) {
                $rootScope.credit.mfoValue = request.data.Value;
            });
            url = '/api/kernel/Params/GetParam/?id=NAME';
            $http.get(bars.config.urlContent(url)).then(function (request) {
                $rootScope.credit.branchNameValue = request.data.Value;
            });
        }
    });

    var checkRisk = function () {
        
        if ($rootScope.credit.finValue != null && $rootScope.credit.obsValue != null) {
            var url = '/creditui/newcredit/getCRisk/?fin=' + $rootScope.credit.finValue.FIN + "&obs=" + $rootScope.credit.obsValue.OBS;
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
        change: function(e) {
            if($rootScope.credit.baseRateValue != null){
                $rootScope.credit.baseRateValue = null;
                $rootScope.credit.baseRateNameValue = null;
                $scope.$apply();
            }
        },
        filter: "startswith",
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

    var LIST_UNSED = [{ id: "0", name: "Відновлюваний" }, { id: "1", name: "Невідновлюваний" }];
    var RENEWABLE_VIDDS = [2, 3, 12];       // (1,11)- невідновлювана
    var getUnsedValueByVidd = function (viddArr) {
        for(var i = 0; i < viddArr.length; i++){
            if(RENEWABLE_VIDDS.indexOf(parseInt(viddArr[i].VIDD)) != -1){
                return LIST_UNSED[0];
            }
        }
        return LIST_UNSED[1];
    };

    $scope.ddlViddOptions = {
        autoBind: false,
        dataSource: {
            cache: false,
            transport: {
                read: {
                    //url: bars.config.urlContent('/creditui/newcredit/getVidd'),
                    url: url + "getVidd",
                    data: { rnk: function () { return $rootScope.credit.rnkValue; } },
                    dataType: "json"
                }
            }
        },
        change: function(e) {
            var dd = this;
            var v = dd.value();
            $rootScope.credit.listUnsedValue = getUnsedValueByVidd([{VIDD: v}]);
            $scope.$apply();
        },
        dataBound: function (e) {
            var dd = this;
            if ($rootScope.nd == null){
                $rootScope.credit.listUnsedValue = getUnsedValueByVidd(dd.dataSource._data);
            }
        },
        dataTextField: "NAME",
        dataValueField: "VIDD" //"METR"
    };

    $scope.ddlListUnsedOptions = {
        dataSource: LIST_UNSED,
        dataTextField: "name",
        dataValueField: "id"
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
        change: function (e) {
            if($rootScope.credit.prodValue != null){
                $rootScope.credit.prodValue = null;
                $scope.$apply();
            }
            if($rootScope.credit.prodNameValue != null){
                $rootScope.credit.prodNameValue = null;
                $scope.$apply();
            }
            //

            /*var dateStart = kendo.parseDate($rootScope.credit.startValue);
            var dateEnd = kendo.parseDate($rootScope.credit.endValue);
            var diff = dateDiff(dateStart, dateEnd);
            var yearDiff = $rootScope.custtype == 3 ? ((diff[0] <= 3 && diff[1] <= 36 && diff[2] == 0) || (diff[0] <= 3 && diff[1] < 36 && diff[2] >= 0))
                : ((diff[0] <= 1 && diff[1] <= 12 && diff[2] == 0) || (diff[0] <= 1 && diff[1] < 12 && diff[2] >= 0));
            var urlui = url + 'getAimBal?rnk=' + $rootScope.credit.rnkValue + "&aim=" + e.sender._old + "&yearDiff=" + yearDiff;
            //bars.ui.loader('body', true);
            $http.get(urlui).then(function (request) {
                if (request.data && request.data.NLS) {
                    urlui = url + 'setMasIni';
                    $http.post(urlui, { nbs: request.data.NLS }).then(function (request) {
                        bars.ui.loader('body', false);
                    });
                }
                else {
                    bars.ui.loader('body', false);
                }
            });*/
        },
        autoBind: false,
        dataTextField: "NAME",
        dataValueField: "AIM"
    };

    $scope.checkBal = function () {
        var dateStart = kendo.parseDate($rootScope.credit.startValue);
        var dateEnd = kendo.parseDate($rootScope.credit.endValue);
        var diff = dateDiff(dateStart, dateEnd);
        //var yearDiff = $rootScope.custtype == 3 ? ((diff[0] <= 3 && diff[1] <= 36 && diff[2] == 0) || (diff[0] <= 3 && diff[1] < 36 && diff[2] >= 0))
          // : ((diff[0] <= 1 && diff[1] <= 12 && diff[2] == 0) || (diff[0] <= 1 && diff[1] < 12 && diff[2] >= 0));
        //var yearDiff = ((diff[0] <= 3 && diff[1] <= 36 && diff[2] == 0) || (diff[0] <= 3 && diff[1] < 36 && diff[2] >= 0));
        var yearDiff = ((diff[2] <= 365));
        if (!$scope.credit.aimValue) return false;
        var aim = $scope.credit.aimValue.AIM;
        var urlui = url + 'getAimBal?rnk=' + $rootScope.credit.rnkValue + "&aim=" + /*e.sender._old*/aim + "&yearDiff=" + yearDiff;
        $http.get(urlui).then(function (request) {
            if (request.data && request.data.NLS) {
                urlui = url + 'setMasIni';
                $http.post(urlui, { nbs: request.data.NLS }).then(function (request) {
                    bars.ui.loader('body', false);
                });
            }
            else {
                bars.ui.loader('body', false);
            }
        });
        return true;
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
        format: "dd/MM/yyyy"
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

    $scope.replaceString = function (value) {
        return value.replace("null", "");
    }

    $scope.columns = [{
        field: "RNK",
        width: 100
    },
    {
        field: "NMK",
        width: 300
    },
    {
        field: "OKPO",
        width: 180
    },
    {
        field: "CUSTTYPE",
        width: 100
    },
    {
        field: "DATE_ON",
        template: '#: kendo.format("{0:dd.MM.yyyy}", DATE_ON) ? kendo.format("{0:dd.MM.yyyy}", DATE_ON) : ""#',
        width: 170
    },
    {
        field: "DATE_OFF",
        template: '#: kendo.format("{0:dd.MM.yyyy}", DATE_OFF) == "null" ? kendo.format("{0:dd.MM.yyyy}", DATE_OFF) : ""#',
        width: 170
    },
    {
        field: "TGR",
        width: 100
    },
    {
        field: "C_DST",
        template: "#= C_DST == 'null' ? '' : C_DST #",
        width: 100
    },
    {
        field: "C_REG",
        width: 100
    },
    {
        field: "ND",
        width: 170
    },
    {
        field: "CODCAGENT",
        width: 100
    },
    {
        field: "NAMEAGENT",
        width: 250
    },
    {
        field: "COUNTRY",
        width: 100
    },
    {
        field: "PRINSIDER",
        width: 100
    },
    {
        field: "NAMEPRINSIDER",
        width: 250
    },
    {
        field: "STMT",
        width: 100
    },
    {
        field: "SAB",
        width: 100
    },
    {
        field: "CRISK",
        width: 100
    },
    {
        field: "ADR",
        width: 300
    },
    {
        field: "VED",
        width: 100
    },
    {
        field: "SED",
        width: 100
    }];

    $scope.showReferCust = function (tabName, showFields, whereClause) {
        bars.ui.handBook(tabName, function (data) {
            $rootScope.credit.custValue = data[0].OKPO;
            $rootScope.credit.rnkValue = data[0].RNK;
            $rootScope.credit.nmkValue = data[0].NMK;
            $scope.ddlVidd.dataSource.read();
            $scope.ddlAim.dataSource.read();
            $rootScope.$apply();
        },
        {
            multiSelect: false,
            clause: $rootScope.whereForCust,
            columns: $scope.columns
        });
    }

    function dateDiff(date1, date2) {
        var years = date2.getFullYear() - date1.getFullYear();
        var months = years * 12 + date2.getMonth() - date1.getMonth();
        //var days = date2.getDate() - date1.getDate();
        var days = parseInt((date2 - date1) / (1000 * 60 * 60 * 24)); 
        years -= date2.getMonth() < date1.getMonth();
        months -= date2.getDate() < date1.getDate();
        //days += days < 0 ? new Date(date2.getFullYear(), date2.getMonth() - 1, 0).getDate() + 1 : 0;

        return [years, months, days];
    }


    $scope.columnsPotra = [{
        field: "ID",
        width: 100
    },
    {
        field: "NAME",
        width: 800
    }];

    $scope.showReferProd = function (tabName, showFields) {
        /*var dateStart = kendo.parseDate($rootScope.credit.startValue);
        var dateEnd = kendo.parseDate($rootScope.credit.endValue);
        var diff = dateDiff(dateStart, dateEnd);
        var yearDiff = $rootScope.custtype == 3 ? ((diff[0] <= 3 && diff[1] <= 36 && diff[2] == 0) || (diff[0] <= 3 && diff[1] < 36 && diff[2] >= 0))
            : ((diff[0] <= 1 && diff[1] <= 12 && diff[2] == 0) || (diff[0] <= 1 && diff[1] < 12 && diff[2] >= 0));
        
        var whereClause = "where (substr(id, 0, 4) in " +
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
                          "       where aim = " + $rootScope.credit.aimValue.AIM + "))" + 
                          "  and substr(id, 4, 1) = " + (yearDiff ? "'2'" : "'3'");*/
        if ($scope.checkBal()) {
            bars.ui.handBook(tabName, function (data) {
                $rootScope.credit.prodValue = data[0].ID;
                $rootScope.credit.prodNameValue = data[0].NAME;
                $scope.$apply();
            },
            {
                multiSelect: false,
                //clause: whereClause,
                columns: $scope.columnsPotra
            });
        }
    }
    $scope.showReferBRate = function (tabName, showFields, whereClause) {
        var kv = $rootScope.credit.curValue.KV;
        if(kv == null || kv == undefined || kv == ""){kv = 980;}
        whereClause = "where br_id in (select br_id from br_normal where kv=" + kv + ") order by br_id desc";

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