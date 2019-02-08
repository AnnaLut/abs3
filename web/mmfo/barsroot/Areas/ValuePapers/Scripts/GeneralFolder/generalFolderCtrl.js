if (!Object.keys) {
    Object.keys = function (obj) {
        var keys = [];

        for (var i in obj) {
            if (obj.hasOwnProperty(i)) {
                keys.push(i);
            }
        }

        return keys;
    };
}

angular.module("BarsWeb.Controllers")
    .factory('contractModel', function ($http) {
        
        var model = {
            dTmp: null,
            REF_MAIN: null,
            Amort: null,
            nTmp: null,
            sTmp: null,
            aMfo: null,
            sSqlPF: null,
            sTmp1: null,
            sREF: null,
            nDCP: null,
            nTipd: null,
            nBasey: null,
            FL: null,
            ACCA: null,
            ACCP: null,
            ACCR: null,
            nRYN: null,
            nPF: null,
            nDOX: null,
            nEMI: null,
            nameEMI: null,
            nameCP: null,
            Nd_: null,
            nId: null,
            n980: null,
            nCOUNTRY: null,
            mfo_NBU: null,
            nRef: null,
            nRef0: null,
            nRef1: null,
            nRef2: null,
            nRef3: null,
            sPoisk: null,
            sPoisk_: null,
            sPoisk1: null,
            NLS9: null,
            NLS8: null,
            NLS71: null,
            hBtnYes: null,
            hBtnNo: null,
            hBtns: null,
            bArc: null,
            dDat: null,
            dDat31: null,
            Day_ZO: null
        };

        var promice = $http.get('/barsroot/api/valuepapers/generalfolder/GetContractSaleWindowFixedParams')
            .then(function (response) {
                
                if (!$.isArray(response.data))
                    throw new Error('method return wrong value!');
                
                response.data.forEach(function (elem) {
                    model[elem.Param] = elem.Value;
                });

                return model;
            });

        return promice;
    })
    .controller("generalFolderCtrl", [
        '$scope', '$http', 'contractModel', function ($scope, $http, contractModel) {

            $scope.filter = 'ID=480';

            contractModel.then(function (model) {
                $scope.contractModel = model;
            });
         //   bars.ui.getFiltersByMetaTable
            bars.ui.getFiltersByMetaTable(function(response) {
                if (response.length > 0) {
                    window.gridParams.strPar02 = response.join(' and ');
                    $scope.gridParams = window.gridParams;
                    $scope.grid.dataSource.read();
                }
            }, { tableName: "CP_V" });

            

            $scope.dataSource = {
                type: "webapi",
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        url: bars.config.urlContent('/api/valuepapers/generalfolder/GetCpv'),
                        data: function () {
                            return $scope.gridParams;
                        }
                    }
                },
                serverPaging: true,
                serverFiltering: true,
                serverSorting: true,
                pageSize: 10,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            DATD: { type: "date" },
                            ND: { type: "number" },
                            SUMB: { type: "number" },
                            REF: { type: "string" },
                            ID: { type: "number" },
                            CP_ID: { type: "string" },
                            KV: { type: "number" },
                            VIDD: { type: "number" },
                            PFNAME: { type: "string" },
                            RYN: { type: "string" },
                            DATP: { type: "date" },
                            NO_PR: { type: "number" },
                            BAL_VAR: { type: "number" },
                            KIL: { type: "number" },
                            ZAL: { type: "number" },
                            CENA: { type: "number" },
                            OSTA: { type: "number" },
                            OSTAB: { type: "number" },
                            OSTAF: { type: "number" },
                            OSTD: { type: "number" },
                            OST_2VD: { type: "number" },
                            OSTP: { type: "number" },
                            OST_2VP: { type: "number" },
                            OSTR: { type: "number" },
                            OSTR2: { type: "number" },
                            OSTR3: { type: "number" },
                            OSTEXPN: { type: "number" },
                            OSTEXPR: { type: "number" },
                            OSTUNREC: { type: "number" },
                            OSTS: { type: "number" },
                            OSTSDM: { type: "number" },
                            ERAT: { type: "number" },
                            NO_P: { type: "number" }
                        }
                    }
                }
            };

            $scope.gridOptions = {
                autoBind: false,
                columns: [
                {
                    field: "DATD", title: "Дата<br>угоди<br>купівлі",
                    template: "<div>#=DATD!=null ? kendo.toString(DATD,'dd/MM/yyyy') : '' #</div>", width: 85
                },
                { field: "ND", title: "№<br>угоди<br>купівлі", width: 90 },
                { field: "SUMB", title: "Сума<br>угоди<br>купівлі", width: 90 },
                { field: "REF", title: "РЕФ<br>угоди<br>купівлі", width: 100 },
                { field: "ID", title: "№<br>ЦП", width: 90 },
                { field: "CP_ID", title: "Код<br>ЦП", width: 110 },
                { field: "KV", title: "Вал", width: 50 },
                { field: "VIDD", title: "Вид<br>угод", width: 90 },
                { field: "PFNAME", title: "Потрфель", width: 100 },
                { field: "RYN", title: "Суб<br>портфель", width: 100 },
                { field: "DATP", title: "Дата<br>погашення", template: "<div>#=DATP!=null ? kendo.toString(DATP,'dd/MM/yyyy') : ''#</div>", width: 85 },
                { field: "NO_PR", title: "Ном.<br>%ст.<br>річна", width: 60 },
                { field: "BAL_VAR", title: "Бал-варт.факт<br>N+D+P+R+R2<br>+S+2VD+2VP", width: 90 },
                { field: "KIL", title: "Кіль-ть<br>ЦП-факт.<br>в пакеті", width: 90 },
                { field: "ZAL", title: "в.т.ч.<br>в<br>заставі", width: 90 },
                { field: "CENA", title: "Ціна<br>1 шт.<br>ЦП", width: 70 },
                { field: "OSTA", title: "Сума<br>ном.<br>№", width: 70 },
                { field: "OSTAB", title: "Сума<br>ном<br>№-план", width: 75 },
                { field: "OSTAF", title: "Сума<br>ном.<br>№-буд.", width: 70 },
                { field: "OSTD", title: "Сума<br>дисконту<br>D", width: 90 },
                { field: "OST_2VD", title: "Сума<br>дисконту<br>2VD", width: 90 },
                { field: "OSTP", title: "Сума<br>премії<br>Р", width: 80 },
                { field: "OST_2VP", title: "Сума<br>премії<br>2VР", width: 80 },
                { field: "OSTSDM", title: "Сума дисконту<br>премії<br>модифікації", width: 100 },
                { field: "OSTR", title: "Сума<br>нарах.%<br>R", width: 90 },
                { field: "OSTR2", title: "Сума<br>куплених.%<br>R2", width: 90 },
                { field: "OSTR3", title: "Сума<br>куплених.%<br>R3", width: 90 },
                { field: "OSTUNREC", title: "Остат.<br>невизн.куп.%<br>доходыв", width: 90 },
                { field: "OSTEXPN", title: "Сума<br>прострочки<br>номіналу", width: 90 },
                { field: "OSTEXPR", title: "Сума<br>прострочки<br>нарах.купону", width: 90 },
                { field: "OSTS", title: "Сума<br>переоц.<br>S", width: 90 },
                { field: "ERAT", title: "Ефект<br>ставка %", width: 90 },
                { field: "NO_P", title: "Приз<br>НЕ<br>переоц.", width: 90 }
                ],
                dataSource: $scope.dataSource,
                columnMenu: true,
                pageable: true
            };

            $scope.inversePActiveUpdateGrid = function () {
                $scope.gridParams.p_active = +!$scope.gridParams.p_active;
                $scope.grid.dataSource.read();
            };

            $scope.showContractSaleWindow = function() {
                transport.dDat = 0;
                transport.SUMBK = 0;

            }

            $scope.newDeal = function (p_nOp, p_fl_END, p_nGrp, p_strPar02) {

                $http({
                    url: '/barsroot/api/valuepapers/generalfolder/GetPrepareWndDeal',
                    method: "GET",
                    params: { p_nOp: p_nOp, p_fl_END: p_fl_END, p_nGrp: p_nGrp, p_strPar02: p_strPar02 }
                })
                    .then(function (response) {
                        
                        Object.keys(response.data).forEach(function(elem) {
                            $scope.contractModel[elem] = response.data[elem];
                        });
                        Object.keys($scope.contractModel).forEach(function (elem) {
                            
                            if (typeof $scope.contractModel[elem] == "string" && $scope.contractModel[elem].match(/Date\((\S+)\)/)) {
                                $scope.contractModel[elem] = new Date(parseInt($scope.contractModel[elem].match(/Date\((\S+)\)/)[1]));
                           //     $scope.contractModel[elem] = kendo.toString(new Date(parseInt($scope.contractModel[elem].match(/Date\((\S+)\)/)[1])), "dd/MM/yyyy");
                            }
                                
                        });
                        $scope.contactSaleWindow.title($scope.contractModel.WndTitle).open().center();
                    });

               
            }


            $scope.logger = function () {
                console.log("rb_ACT = " + $scope.contractModel.rb_ACT);
            }

        }]);

