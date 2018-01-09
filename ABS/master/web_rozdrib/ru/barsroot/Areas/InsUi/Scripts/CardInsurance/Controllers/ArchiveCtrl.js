angular.module('BarsWeb.Controllers')
    .controller('ArchiveCtrl', ['$scope', '$http',
        function ($scope, $http) {
            $scope.init = function (nd) {
                $scope.arc_nd = nd;
            }

            $scope.gridOptionsCardInsurArcDataSource = new kendo.data.DataSource({
                type: "aspnetmvc-ajax",
                transport: {
                    read: {
                        type: "POST",
                        url: bars.config.urlContent("/InsUi/CardInsurance/GetCardsInsurArc"),
                        dataType: 'json',
                        data: function () {
                            return { par: $scope.arc_nd };
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

            $scope.gridOptionsCardInsurArc = {
                dataSource: $scope.gridOptionsCardInsurArcDataSource,
                dataBound: function (e) {
                    var grid = $scope.gridCardInsurArc;
                    var gridData = $scope.gridOptionsCardInsurArcDataSource.view();

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
                },
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
        }]);