angular.module('BarsWeb.Controllers')
    .controller('CardInsurCtrl', ['$scope', '$http',
        function ($scope, $http) {
            $scope.dateFrom = null;
            $scope.account = null;
            $scope.fio = null;
            $scope.inn = null;
            $scope.win_width = document.documentElement.offsetWidth * 0.8;
            $scope.win_height = document.documentElement.offsetHeight * 0.6;
            $scope.win_style = "width: " + $scope.win_width + "; height: " + $scope.win_height;
            $scope.dpFormatOptions = {
                format: "{0:dd.MM.yyyy}",
                mask: "##.##.####"
            };

            $scope.$watch('dateFrom', function () {
                //console.log($scope.dateFrom);
            });

            $scope.gridOptionsCardInsurDataSource = new kendo.data.DataSource({
                type: "aspnetmvc-ajax",
                transport: {
                    read: {
                        type: "POST",
                        url: bars.config.urlContent("/InsUi/CardInsurance/GetCardsInsur"),
                        dataType: 'json',
                        data: {
                            inn: function () {
                                return $scope.inn;
                            },
                            account: function () {
                                return $scope.account;
                            },
                            fio: function () {
                                return $scope.fio;
                            }
                        },
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        id: "ND",
                        fields: {
                            ND: { type: "number" },
                            BRANCH: { type: "string" },
                            ACC_NLS: { type: "string" },
                            ACC_LCV: { type: "string" },
                            ACC_OB22: { type: "string" },
                            ACC_TIPNAME: { type: "string" },
                            CARD_CODE: { type: "string" },
                            CARD_IDAT: { type: "date" },
                            ACC_OST: { type: "number" },
                            CUST_RNK: { type: "number" },
                            CUST_OKPO: { type: "string" },
                            CUST_NAME: { type: "string" },
                            ACC_DAOS: { type: "date" },
                            ACC_DAZS: { type: "date" },
                            STATE: { type: "string" },
                            ERR_MSG: { type: "string" },
                            INS_EXT_ID: { type: "number" },
                            INS_EXT_TMP: { type: "number" },
                            DEAL_ID: { type: "string" },
                            DATE_FROM: { type: "date" },
                            DATE_TO: { type: "date" }
                        }
                    }
                },
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true
            });

            $scope.gridOptionsCardInsur = {
                dataSource: $scope.gridOptionsCardInsurDataSource,
                dataBound: onDataBound,
                scrollable: true,
                filterable: true,
                sortable: true,
                selectable: true,
                //resizable: true,
                pageable: {
                    refresh: true,
                    pageSizes: [5, 10, 20]
                },
                columns: [
                    {
                        template: '<button class="k-button" name="Create" title="Створити договір в системі EWA" ng-click="createDeal(#= ND #)" style="width:35px;min-width:0px"><i class="pf-icon pf-16 pf-accept_doc"></i></button>' +
                                  '<button class="k-button" name="Print" title="Роздрукувати СД" ng-click="printDeal(#= ND #)" style="width:35px;min-width:0px"><i class="pf-icon pf-16 pf-print"></i></button>',
                        headerTemplate: '<label>Дії</label>',
                        width: "100px"
                    },
                    {
                        field: "STATE",
                        title: "Статус",
                        attributes: {
                            title: "#= ERR_MSG #"
                        },
                        width: "90px"
                    },
                    {
                        field: "CUST_NAME",
                        title: "П.І.Б.",
                        width: "250px"
                    },
                    {
                        field: "CUST_OKPO",
                        title: "ІПН",
                        width: "100px",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    format: "n0"
                                });
                            }
                        }
                    },
                    {
                        field: "DEAL_ID",
                        title: "Номер<br />договору<br />(EWA)",
                        width: "100px"
                    },
                    {
                        field: "DATE_FROM",
                        title: "Дата початку<br />договору<br />страхування",
                        template: "#= (DATE_FROM == null ) ? ' ' : kendo.toString(kendo.parseDate(DATE_FROM), 'dd/MM/yyyy') #",
                        width: "120px"
                    },
                    {
                        field: "DATE_TO",
                        title: "Дата закінчення<br />договору<br />страхування",
                        template: "#= (DATE_TO == null ) ? ' ' : kendo.toString(kendo.parseDate(DATE_TO), 'dd/MM/yyyy') #",
                        width: "120px"
                    },
                    {
                        field: "ND",
                        title: "Номер<br />договору<br />ДКБО",
                        width: "90px",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    format: "n0"
                                });
                            }
                        }
                    },
                    {
                        field: "CUST_RNK",
                        title: "РНК",
                        width: "90px",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    format: "n0"
                                });
                            }
                        }
                    },
                    {
                        field: "ACC_NLS",
                        title: "Картковий<br />рахунок",
                        width: "120px",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    format: "n0"
                                });
                            }
                        }
                    },
                    {
                        field: "ACC_LCV",
                        title: "Валюта",
                        width: "90px"
                    },
                    {
                        field: "ACC_DAOS",
                        title: "Дата<br />відкриття<br />рахунку",
                        template: "#= (ACC_DAOS == null ) ? ' ' : kendo.toString(kendo.parseDate(ACC_DAOS), 'dd/MM/yyyy') #",
                        width: "120px"
                    },
                    {
                        field: "CARD_CODE",
                        title: "Тип карти",
                        width: "200px"
                    }
                ]
            };

            function onDataBound(e) {
                var grid = $scope.gridCardInsur;
                var gridData = $scope.gridOptionsCardInsurDataSource.view();

                for (var j = 0; j < gridData.length; j++) {
                    if (gridData[j].STATE == 'ERROR') {
                        var currRow = grid.table.find("tr[data-uid='" + gridData[j].uid + "']").addClass("k-error-colored");
                        var btnPrint = $(currRow).find("[name='Print']").attr("disabled", "disabled");
                    } else if (gridData[j].STATE == 'DONE') {
                        var currRow = grid.table.find("tr[data-uid='" + gridData[j].uid + "']").addClass("k-success-colored");
                        var btnCreate = $(currRow).find(".k-button[name='Create']").attr("disabled", "disabled");
                    } else {
                        var currRow = grid.table.find("tr[data-uid='" + gridData[j].uid + "']");
                        var btnCreate = $(currRow).find(".k-button[name='Create']").attr("disabled", "disabled");
                        var btnPrint = $(currRow).find(".k-button[name='Print']").attr("disabled", "disabled");
                    }
                };
            };

            $scope.createDeal = function (nd) {
                var url = '/BpkW4/RegisteringNewCard/CreateDealsEWA?nd=' + nd;
                $http.get(bars.config.urlContent(url)).then(function (request) {
                    var grid = $scope.gridCardInsur;
                    if (request.data == '"Ok"') {
                        bars.ui.alert({
                            text: "Створено договір у зовнішній системі EWA",
                        });
                        grid.dataSource.read();
                    }
                    else {
                        bars.ui.error({
                            text: "Помилка: " + request.data,
                        });
                        grid.dataSource.read();
                    }
                });
            };

            $scope.printDeal = function (nd) {
                var url = '/BpkW4/RegisteringNewCard/GetDealReport?nd=' + nd;
                window.location = bars.config.urlContent(url);
            };

            $scope.search = function () {
                var grid = $scope.gridCardInsur;
                $scope.gridOptionsCardInsur.dataSource.read();
            };

            $scope.clear = function () {
                $scope.inn = null;
                $scope.account = null;
                $scope.fio = null;
                $scope.gridOptionsCardInsur.dataSource.read();
            };

            $scope.archive = function () {
                var grid = $("#gridCardInsur").data("kendoGrid");
                var selectedItem = grid.dataItem(grid.select());
                if (selectedItem != null) {
                    $scope.arc_nd = selectedItem.ND;
                    bars.ui.dialog({
                        content: bars.config.urlContent('/insui/CardInsurance/archive') + '?nd=' + $scope.arc_nd,
                        iframe: true,
                        width: document.documentElement.offsetWidth * 0.9
                        //height: document.documentElement.offsetHeight * 0.6
                    });
                }
                else {
                    bars.ui.alert({ text: "Оберіть договір." });
                }
            };

            

        }]);