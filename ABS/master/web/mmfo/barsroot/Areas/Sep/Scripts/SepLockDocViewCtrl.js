angular.module("BarsWeb.Controllers", ['kendo.directives'])
    .controller("Sep.SepLockDocViewCtrl", ["$scope", "$location", "$http", function ($scope, $location, $http) {
        var localUrl = $location.absUrl();
        $scope.recid = bars.extension.getParamFromUrl('recid', localUrl);

        debugger;
        $scope.arc = {
            recid: null,
            mfoa: null,
            mfob: null,
            nlsa: null,
            nlsb: null,
            nama: null,
            namb: null,
            s: null,
            sprop: null,
            lcv: null,
            nazn: null,
            data: null,
            datp: null,
            fna: null,
            ida: null,
            idb: null,
            datprop: null,
            banka: null,
            bankb: null,
            vobname: null,
            dat_2: null,
            datk:null
        };

        $scope.mainTabStripOptions = {
            animation: false
        };
        var url = '/sep/SepLockDocView/GetLockDoc?rec=' + $scope.recid;

        $http.get(bars.config.urlContent(url)).then(function (resp) {
            debugger;
            var arc = $scope.arc;
            if (resp.data && resp.data.length > 0) {
                arc.recid = resp.data[0].REC;
                arc.mfoa = resp.data[0].MFOA;
                arc.mfob = resp.data[0].MFOB;
                arc.nlsa = resp.data[0].NLSA;
                arc.nlsb = resp.data[0].NLSB;
                arc.nama = resp.data[0].NAM_A;
                arc.namb = resp.data[0].NAM_B;
                arc.s = resp.data[0].S;
                arc.sprop = resp.data[0].SPROP;
                arc.lcv = resp.data[0].LCV;
                arc.nazn = resp.data[0].NAZN;
                arc.data = kendo.parseDate(resp.data[0].DAT_A);
                arc.datp = kendo.parseDate(resp.data[0].DATP);
                arc.fna = resp.data[0].FN_A;
                arc.ida = resp.data[0].ID_A;
                arc.idb = resp.data[0].ID_B;
                arc.datprop = resp.data[0].DAT_PROP;
                arc.banka = resp.data[0].BANK_A;
                arc.bankb = resp.data[0].BANK_B;
                arc.vobname = resp.data[0].VOB_NAME;
                arc.dat_2 = kendo.parseDate(resp.data[0].DAT_2);
                arc.datk = kendo.parseDate(resp.data[0].DATK);
            } 
        });

        $('#BISGrid').kendoGrid({
            dataSource: {
                transport: {
                    read: {
                        url: bars.config.urlContent('/sep/SepLockDocs/GetBIS'),
                        data: function () {
                            return { rec: $scope.recid };
                        }
                    }
                },
                schema: {
                    model: {
                        fields: {
                            bis: { field: "bis", type: "string" }
                        }
                    }
                }
            },
            columns: [
                {
                    field: "bis",
                    title: "<div align=center>Значення</div>",
                    widnh: 250
                }
            ],
            change: function () {

            }
        });
    }]);