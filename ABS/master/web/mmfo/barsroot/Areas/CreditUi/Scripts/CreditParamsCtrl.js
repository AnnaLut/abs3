angular.module("BarsWeb.Areas").controller("CreditUi.creditParamsCtrl", ["$scope", "$http", "$rootScope", function ($scope, $http, $rootScope) {
    var url = bars.config.urlContent("/creditui/newcredit/");

    var creditKeys = ['currBValue', 'currCValue', 'currDValue', 'currEValue'];

    $scope.showReferKv = function (tabName, showFields, whereClause, creditKey) {
        bars.ui.handBook(tabName, function (data) {
                var kv = data[0].KV;
                if($rootScope.credit.curValue.KV == kv){
                    bars.ui.error({ text: "Виберіть іншу валюту" });
                    return;
                }

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
    $scope.isIFRSchosen = function () { return $rootScope.credit.ifrs != null || $rootScope.IsGKD(); };

    $scope.checkRisk = function () {

        if ($rootScope.credit.finValue.Key != null && $rootScope.credit.obsValue.Key != null && $rootScope.data_sources !== undefined) {
            var obj = $.grep($rootScope.data_sources.Crisk, function (e) { return e.FIN == $rootScope.credit.finValue.Key && e.OBS == $rootScope.credit.obsValue.Key; });
            if (obj.length > 0) {
                $rootScope.credit.sIdValue = obj[0].CRISK;
                $rootScope.credit.sCatValue = obj[0].NAME;
        }
            else
                $rootScope.credit.sIdValue = $rootScope.credit.sCatValue = null;
        }
        }
   
    var LIST_UNSED = [{ id: "0", name: "Відновлюваний" }, { id: "1", name: "Невідновлюваний" }];
    var RENEWABLE_VIDDS = [2, 3, 12];       // (1,11)- невідновлювана
    var getUnsedValueByVidd = function (viddArr) {
        for(var i = 0; i < viddArr.length; i++){
            if(RENEWABLE_VIDDS.indexOf(parseInt(viddArr[i].Key)) != -1){
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
            if(($rootScope.sos == "0") || ($rootScope.sos == null)){
                $rootScope.credit.listUnsedValue = getUnsedValueByVidd([{Key: v}]);
            }
            
            $scope.ChangeFields4GKD();
            $scope.$apply();
            $scope.ddlAim.dataSource.read();
            $rootScope.LoadRangs();
        },
        dataBound: function (e) {
            var dd = this;
            if ($rootScope.nd == null){
                $rootScope.credit.listUnsedValue = getUnsedValueByVidd(dd.dataSource._data);
            }
            $rootScope.ShowCustInfo = false;
            if (dd.dataSource && [11, 12, 13].indexOf(dd.dataSource._data[0].Key) !== -1) {
                $scope.GetCustInfo($rootScope.credit.rnkValue);
                $rootScope.ShowCustInfo = true;
            }
            $scope.ChangeFields4GKD();

            $rootScope.$apply();

        },
        dataTextField: "Value",
        dataValueField: "Key" //"METR"
    };

    $scope.ddlListUnsedOptions = {
        dataSource: LIST_UNSED,
        dataTextField: "name",
        dataValueField: "id"
    };

    $scope.ddlListServiceOptions = {
        dataSource: [{ id: "0", name: "Класичний" }, { id: "1", name: "Ануїтетний" }],
        dataTextField: "name",
        dataValueField: "id"
    };

    $scope.ddlGPKOptions = {
        dataSource: [{ id: "0", name: "Ні" }, { id: "1", name: "Так" }],
        dataTextField: "name",
        dataValueField: "id",
        optionLabel: " ",
        change: function () {
            if ($rootScope.credit.belongtoGKD !== undefined && $rootScope.credit.belongtoGKD.id != 1 && $rootScope.credit.gkd_id !== null) {
                $rootScope.credit.gkd_id = null;
                $rootScope.GKD.limit = null;
                $rootScope.GKD.wdate = null;
                $scope.$apply();
            }
        }
    };


    $scope.ddlAimOptions = {
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: url + "getAim",
                    data: {
                        vidd: function () {
                            return $rootScope.credit.viddValue.Key;
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
        },
        autoBind: false,
        dataTextField: "Value",
        dataValueField: "Key"
    };

    $scope.ddlBusModOptions = {
        autoBind: false,
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: url + "getBusMod",
                    data: { rnk: function () { return $rootScope.credit.rnkValue; } },
                    dataType: "json"
                }
            }
        },
        dataTextField: "Value",
        dataValueField: "Key",
        dataBound: function () {
            this.select(0);
            $rootScope.credit.bus_mod = { Key: this.value() };
            $scope.GetSppi();
        },
        change: function (e) {
            $rootScope.SetIFRS();
            $rootScope.credit.prodValue = null;
            $rootScope.credit.prodNameValue = null;
        }
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
            $rootScope.$apply();
        },
        {
            multiSelect: false,
            clause: $rootScope.whereForCust,
            columns: $scope.columns
        });
    }

    $scope.columnsPotra = [{
        field: "ID",
        width: 100
    },
    {
        field: "NAME",
        width: 800
    }];

    $scope.showReferProd = function () {
        var poci = ($rootScope.credit.poci !== null && $rootScope.credit.poci.Key !== "") ? $rootScope.credit.poci.Key : 0;
        var custtype = [11, 12, 13].indexOf($rootScope.credit.viddValue.Key) !== -1 ? 3 : 2;
        var where_clause = "where IFRS = '" + $rootScope.credit.ifrs + "' and AIM = " + $rootScope.credit.aimValue.Key +
            " and CUSTTYPE = " + custtype + " and POCI =  " + poci;
            bars.ui.handBook('CC_POTR_2', function (data) {
                $rootScope.credit.prodValue = data[0].ID;
                $rootScope.credit.prodNameValue = data[0].NAME;
                $scope.$apply();
            },
            {
                multiSelect: false,
                clause: where_clause,
                columns: $scope.columnsPotra
            });
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

    $scope.FillLim = function () {
        $rootScope.credit.lim = $rootScope.credit.sumValue;
    };

    $scope.columnsInspector = [{
        field: "ID",
        width: 100
    },
   {
       field: "FIO",
       width: 400
   }];

    $scope.showInspectors = function (tabName, showFields, whereClause) {
        bars.ui.handBook(tabName, function (data) {
            $rootScope.credit.inspector_id = data[0].ID;
            $scope.$apply();
        },
        {
            multiSelect: false,
            clause: "active = 1 and branch like sys_context('bars_context', 'user_branch') || '%'",
            columns: $scope.columnsInspector,
            ResizedColumns: true
        });
    }

    $scope.GetCustInfo = function (rnk) {
        $http.get(bars.config.urlContent('/creditui/newcredit/GetCustData/?rnk=' + rnk)).then(function (request) {
            $rootScope.CUST_INFO.EDRPO = $rootScope.CUST_INFO.EDUCA = $rootScope.CUST_INFO.MEMB = $rootScope.CUST_INFO.NAMEW =
               $rootScope.CUST_INFO.NREMO = $rootScope.CUST_INFO.REMO = $rootScope.CUST_INFO.STAT = $rootScope.CUST_INFO.TYPEW =
                 $rootScope.CUST_INFO.REAL6INCOME = $rootScope.CUST_INFO.NOREAL6INCOME = "";

            if (!$scope.validateRequest(request)) { return; }

            var _cust_data = request.data.Data;
            if (_cust_data !== null) {
                $rootScope.CUST_INFO.EDRPO = _cust_data.EDRPO;
                $rootScope.CUST_INFO.EDUCA = _cust_data.EDUCA;
                $rootScope.CUST_INFO.MEMB = _cust_data.MEMB;
                $rootScope.CUST_INFO.NAMEW = _cust_data.NAMEW;
                $rootScope.CUST_INFO.NREMO = _cust_data.NREMO;
                $rootScope.CUST_INFO.REMO = _cust_data.REMO;
                $rootScope.CUST_INFO.STAT = _cust_data.STAT;
                $rootScope.CUST_INFO.TYPEW = _cust_data.TYPEW;
                $rootScope.CUST_INFO.REAL6INCOME = _cust_data.REAL6INCOME;
                $rootScope.CUST_INFO.NOREAL6INCOME = _cust_data.NOREAL6INCOME;
                $rootScope.ShowCustInfo = true;
            }
        });
      }

    $scope.showGKD = function (tabName) {
        bars.ui.handBook(tabName, function (data) {
            $rootScope.credit.gkd_id = data[0].ND;
            $rootScope.GKD.wdate = kendo.toString(kendo.parseDate(data[0].WDATE, 'yyyy-MM-dd'), 'dd/MM/yyyy');
            $rootScope.SetActualLimit(data[0].ND);
            $scope.$apply();
        },
        {
            multiSelect: false,
            clause: " SOS >= 10 and WDATE > gl.bd and VIDD = 5 and RNK = " + $rootScope.credit.rnkValue,
            columns: [
                {
                    field: "ND",
                    width: 100
                },
                {
                    field: "CC_ID",
                    width: 100
                },
            {
                field: "WDATE",
                width: 80,
                template: "#= kendo.toString(kendo.parseDate(WDATE, 'yyyy-MM-dd'), 'dd/MM/yyyy') #"
            }],
            ResizedColumns: true
        });
    }

   $rootScope.SetIFRS = function () {
        if ($rootScope.credit.bus_mod.Key != null && $rootScope.credit.sppi.Key !== undefined) {
            $http.get(bars.config.urlContent('/creditui/newcredit/GetIFRS/'), {
                params: { bus_mod: $rootScope.credit.bus_mod.Key, sppi: $rootScope.credit.sppi.Key },
                headers: { 'Accept': 'application/json' }
            }).then(function (request) {
                $rootScope.credit.ifrs = request.data.IFRS;
                $rootScope.credit.poci = null;
                //$scope.$apply();
            });
        }
    }

    $scope.GetSppi = function () {
        $http.get(bars.config.urlContent('/creditui/newcredit/GetSPPI/'), {
            params: { rnk: $rootScope.credit.rnkValue }
        }).then(function (request) {
            if (request.data.SPPI !== "") {
                $rootScope.credit.sppi = { Key: kendo.parseInt(request.data.SPPI) };
                $rootScope.SetIFRS();
            }

        });
    }

    $scope.ChangeFields4GKD = function () {
        if ($rootScope.credit.viddValue && $rootScope.credit.viddValue.Key == 5) {
            $rootScope.credit.gkd_id = null;
            $rootScope.GKD.limit = null;
            $rootScope.GKD.wdate = null;
            $rootScope.credit.belongtoGKD = null;
            if ($scope.ddlBusMod.dataSource) {
                $scope.ddlBusMod.text("");
                $scope.ddlBusMod.value("");
                $scope.sppi_ddl.text("");
                $scope.sppi_ddl.value("");
                $scope.ddlPoci.text("");
                $scope.ddlPoci.value("");
                $rootScope.credit.bus_mod.Key = ""; 
                $rootScope.credit.sppi.Key = "";
                $rootScope.credit.poci = "";
                $rootScope.credit.ifrs = null;
            }

        }
        else
            $scope.ddlBusMod.dataSource.read();
    }

    $rootScope.SetActualLimit = function (gkd_nd) {

        _data = ($rootScope.nd !== null) ? { sub_nd: $rootScope.nd } : { gkd_nd: gkd_nd };
        $http.get(bars.config.urlContent('/creditui/newcredit/GetActualLimit/'),
        {
            params: _data,
            headers: { 'Accept': 'application/json' }
        }).then(function (request) {
            $rootScope.GKD.limit = kendo.toString(request.data.Limit, "n2");
        });
    };

}]);