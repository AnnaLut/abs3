// Раскраска и преобразование данных в формат отображения счетов
function CellPaint(data) {
    if (data == 0) {
        return moneyFormat(data);
    }
    else {
        if (data < 0) {
            return "<font color=\"red\">" + moneyFormat(Math.abs(data)) + "</font>";

        }
        else if (data > 0) {
            return "<font color=\"blue\">" + moneyFormat(data) + "</font>";
        }
    }
}

// Преобразование в формать отображения денег
function moneyFormat(money) {
    if (money === null) {
        return '';
    }
    else {
        return kendo.toString(money, '###,##0.00').replace(new RegExp(",", 'g'), ' ');
    }
}

angular.module("BarsWeb.Controllers", ['kendo.directives'])
    .controller("CreditUi.analysisBalanceCtrl", ["$scope", "$http", "$location", "$document", function ($scope, $http, $location, $document) {
        $scope.Title = 'Індивідуальний розбір кредитових залишків';
        var localUrl = $location.absUrl();
        $scope.nd = bars.extension.getParamFromUrl('nd', localUrl);
        $scope.isDisExec = true;
        $scope.isAccShow = true;
        $scope.credit = {
            CC_ID: null,
            OKPO: null,
            ND: null,
            KV: null,
            NLS: null,
            OSTB: null,
            NAZN: [],
            ACC: null
        };
        $scope.payment = {
            NPP: null,
            NAZN: null,
            OSTC: null
        };

        $scope.nppval = {
            sum: null,
            nls: null
        };

        var url = '/creditui/analysisbalance/GetInfo/?nd=' + $scope.nd;
        $http.get(bars.config.urlContent(url)).then(function (request) {
            $scope.credit.CC_ID = request.data.CC_ID;
            $scope.credit.OKPO = request.data.OKPO;
            $scope.credit.ND = request.data.ND;
            $scope.gridDebit.dataSource.read({ nd: $scope.nd, ccId: $scope.credit.CC_ID });
        });
        url = '/api/kernel/BankDates/';
        $http.get(bars.config.urlContent(url)).then(function (request) {
            $scope.bankDate = request.data.Date;
        });
        $scope.toolsOptions = {
            items: [{
                template: "<table>" +
                              "<tr>" +
                                  "<td><label><b>Номер та дата КД:</b></label></td>" +
                                  "<td><span>{{credit.CC_ID}}</span></td>" +
                              "</tr>" +
                              "<tr>" +
                                  "<td><label><b>Ід. код клієнта:</b></label></td>" +
                                  "<td><span>{{credit.OKPO}}</span></td>" +
                              "</tr>" +
                              "<tr>" +
                                  "<td><label><b>Ідентифікатор КД:</b></label></td>" +
                                  "<td><span>{{credit.ND}}</span></td>" +
                              "</tr>" +
                          "</table>"
            },
            {
                type: "separator"
            },
            {
                template: "<table>" +
                              "<tr>" +
                                  "<td><label><b>Вал. рах. погашення:</b></label></td>" +
                                  "<td><span>{{credit.KV}}</span></td>" +
                              "</tr>" +
                              "<tr>" +
                                  "<td><label><b>Рах. погашення:</b></label></td>" +
                                  "<td><span>{{credit.NLS}}</span></td>" +
                              "</tr>" +
                              "<tr>" +
                                  "<td><label><b>Сума до погашення:</b></label></td>" +
                                  "<td><span>{{credit.OSTB}}</span></td>" +
                              "</tr>" +
                          "</table>"
            },
            {
                type: "separator"
            },
            {
                template: "<button class='k-button' ng-click='showAccList()' ng-disabled='isAccShow'><i class='pf-icon pf-16 pf-business_report'></i> Виписка за поточний день</button>",
            },
            {
                template: "<button class='k-button' ng-click='savePayment()' ng-disabled='isDisExec' ><i class='pf-icon pf-16 pf-execute'></i> Виконати операцію погашення</button>",
            }]
        };
        $scope.gridKreditOptions = {
            dataSource: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/analysisbalance/getAccKredit"),
                        dataType: 'json',
                        data: {
                            nd: $scope.nd
                        }
                    }
                },
                batch: true,
                pageSize: 20,
                //   serverPaging: true,
                //   serverFiltering: true,
                //   serverSorting: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        id: "ACC",
                        fields: {
                            ACC: { type: "number" },
                            TIP: { type: "string" },
                            KV: { type: "number" },
                            NLS: { type: "string" },
                            NMS: { type: "string" },
                            OSTB: { type: "number" },
                            OSTC: { type: "number" }
                        }
                    }
                }
            },
            selectable: true,
            filterable: true,
            dataBound: function (data) {
                var d = data.sender._data[0];
                if (d) {
                    $scope.credit.KV = d.KV;
                    $scope.credit.NLS = d.NLS;
                    $scope.credit.OSTB = d.OSTB;
                    $(data.sender.tbody).find("tr").addClass("k-success-colored");
                }
            },
            change: function (e) {
                var gridKredit = e.sender;
                var gridDebit = $scope.gridDebit;
                var selectKredit = gridKredit.dataItem(gridKredit.select());
                var selectDebit = gridDebit.dataItem(gridDebit.select());
                $scope.credit.NLS = selectKredit.NLS;
                $scope.credit.KV = selectKredit.KV;
                $scope.credit.OSTB = selectKredit.OSTB;
                if (selectKredit) {
                    $scope.credit.ACC = selectKredit.ACC;
                    $scope.isAccShow = false;
                    $scope.$apply();
                }
                else {
                    $scope.isAccShow = true;
                    $scope.$apply();
                }
                if (selectKredit && selectDebit && $scope.credit.OSTB <= selectKredit.OSTB) {
                    $scope.isDisExec = false;
                    $scope.$apply();
                }
                else {
                    $scope.isDisExec = true;
                    $scope.$apply();
                }
            },
            pageable: {
                messages: {
                    allPages: "Всі"
                },
                refresh: true,
                pageSizes: [10, 50, 200, 1000, "All"],
                buttonCount: 5
            },
            columns: [{
                field: "TIP",
                title: "Тип"
            },
            {
                field: "KV",
                title: "Вал."
            },
            {
                field: "NLS",
                title: "Рах. погашення"
            },
            {
                field: "NMS",
                title: "Назва рах."
            },
            {
                field: "OSTB",
                title: "Плановий зал.",
                template: "#=moneyFormat(OSTB)#"
            },
            {
                field: "OSTC",
                title: "Фактичний зал.",
                template: "#=moneyFormat(OSTC)#"
            }]
        };

        $scope.gridDebitOptions = {
            dataSource: {
                transport: {
                    read: {
                        url: bars.config.urlContent("/analysisbalance/getAccDebit"),
                        dataType: 'json'/*,
                        data: function () {
                            return {
                                nd: $scope.nd,
                                ccId: $scope.credit.CC_ID
                            };
                        }*/
                    },
                    update: {
                        url: "#"
                    }
                },
                aggregate: [{ field: "OSTB", aggregate: "sum" },
                    { field: "OSTC", aggregate: "sum" },
                ],
                batch: true,
                pageSize: 1000,
                //  serverPaging: true,
                //  serverFiltering: true,
                //   serverSorting: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        id: "ACC",
                        fields: {
                            ACC: { type: "number", editable: false },
                            TIP: { type: "string", editable: false },
                            KV: { type: "number", editable: false },
                            NLS: { type: "string", editable: false },
                            NMS: { type: "string", editable: false },
                            OSTB: { type: "number", editable: false },
                            OSTC: { type: "number", editable: false },
                            DPLAN: { type: "date", editable: false },
                            FDAT: { type: "date", editable: false },
                            NPP: { type: "number", editable: true },
                            NAZN: { type: "string", editable: true }
                        }
                    }
                }
            },
            selectable: "multiple row",
            dataBind: false,
            dataBound: function (e) {
                var grid = this;
                var data = this.dataSource.data();
                $(data).each(function (index, elem) {
                    if ($scope.nppval.sum) {
                        if (elem.NLS == $scope.nppval.nls) {
                            this.set("NPP", $scope.nppval.sum);
                            $scope.nppval.sum = null;
                            $scope.nppval.nls = null;
                        }
                    }
                });
                $(e.sender.tbody).find("tr").each(function (index, elem) {
                    if (grid.dataItem(elem).NPP) {
                        $(elem).addClass("k-success-colored");
                    }
                });

                var total = $scope.CalcSum();
                $("#Summ").html(total.toString());
            },
            change: function (e) {
                var gridKredit = $scope.gridKredit;
                var gridDebit = e.sender;
                var selectKredit = gridKredit.dataItem(gridKredit.select());
                var selectDebit = gridDebit.dataItem(gridDebit.select());
                var grid = e.sender.tbody.find(">tr:not(.k-grouping-row)");
                for (var i = 0; i < grid.length; i++) {
                    var item = gridDebit.dataItem(grid[i]);
                    if (item.NPP && item.NPP > 0) {
                        e.sender.tbody.find(">tr:not(.k-grouping-row)[data-uid=" + item.uid + "]").addClass("k-state-selected");
                    }
                }
                if (selectKredit && selectDebit && $scope.credit.OSTB <= selectKredit.OSTB) {
                    $scope.isDisExec = false;
                    $scope.$apply();
                }
                else {
                    $scope.isDisExec = true;
                    $scope.$apply();
                }

            },
            sortable: true,
            editable: true,
            filterable: true,
            edit: function (e) {
                if (e.container.context.cellIndex == 7) {
                    var input = e.container.find("input");
                    input.dblclick(function () {
                        e.model.set("NPP", Math.abs(e.model.OSTC));
                    });
                }
            },
            save: function (e) {
                if (e.values.NPP || $scope.payment.NPP != null) {
                    $scope.payment.NPP = e.values.NPP;
                    $scope.payment.OSTC = e.model.OSTC;
                }
                if (e.values.NAZN) {
                    $scope.payment.NAZN = e.values.NAZN;
                }
            },
            pageable: {
                messages: {
                    allPages: "Всі"
                },
                refresh: true,
                pageSizes: [10, 50, 200, 1000, "All"],
                buttonCount: 5
            },
            columns: [{
                field: "TIP",
                title: "Тип",
                width: 50,
                sortable: false
            },
            {
                field: "KV",
                title: "Вал.",
                width: 50,
                sortable: false
            },
            {
                field: "NLS",
                title: "Рах. погашення",
                width: 120,
                sortable: false
            },
            {
                field: "NMS",
                title: "Назва рах.",
                width: 200,
                sortable: false
            },
            {
                field: "FDAT",
                title: "Факт-дата видачі",
                format: "{0:dd.MM.yyyy}",
                width: 100,
                sortable: true
            },
            {
                field: "OSTB",
                title: "Плановий зал.",
                template: "#=moneyFormat(OSTB)#",
                width: 100,
                footerTemplate: " #: kendo.toString(sum, 'n2') #",
                format: "{0:##,#}",
                sortable: true
            },
            {
                field: "OSTC",
                title: "Фактичний зал.",
                template: "#=moneyFormat(OSTC)#",
                width: 100,
                footerTemplate: " #: kendo.toString(sum, 'n2') #",
                format: "{0:##,#}",
                sortable: true
            },
            {
                field: "NPP",
                title: "Погасити суму",
                template: "#=moneyFormat(NPP)#",
                width: 100,
                footerTemplate: " <span id='Summ'> </span> ",
                sortable: false
            },
            {
                field: "DPLAN",
                title: "План-дата погаш.",
                format: "{0:dd.MM.yyyy}",
                width: 100,
                sortable: true
            },
            {
                field: "NAZN",
                title: "Призначення платежу",
                width: 200,
                sortable: false
            }/*,
            {
                command: ["edit"]
            }*/]
        };

        $scope.CalcSum = function () {
            var newValue = 0;

            var grid = $scope.gridDebit;
            var data = grid.dataSource.data();
            $(data).each(function (index, elem) {
                newValue += elem.NPP;
            });

            if (newValue != 0) { return moneyFormat(newValue); } else { return ""; }
        }

        $scope.window;
        $scope.showAccList = function () {
            $scope.DlgOptions = {
                title: "Виписка по рахункам",
                width: "800",
                height: "600",
                content: {
                    url: "/barsroot/acct/Statements/index?acctId=" + $scope.credit.ACC + "&date=" + $scope.bankDate
                }
            };

            $scope.window.setOptions($scope.DlgOptions);
            $scope.window.refresh();
            $scope.window.center();
            $scope.window.open();
        };

        $scope.savePayment = function () {
            var gridKredit = $scope.gridKredit;
            var gridDebit = $scope.gridDebit;
            var selectKredit = gridKredit.dataItem(gridKredit.select());

            var selectDebitArray = gridDebit.select();
            var sumDebit = 0;
            for (var i = 0; i < selectDebitArray.length; i++) {
                var selectDebit = gridDebit.dataItem(selectDebitArray[i]);
                sumDebit += selectDebit.NPP;
            }
            var kredit = (selectKredit.OSTC < 0 ? -selectKredit.OSTC : selectKredit.OSTC);
            var isgModelArray = [];
            debugger;
            if (kredit < sumDebit) {
                bars.ui.error({
                    text: "Введена сума перевищує залишок на рахунку!"
                });
            }
            else {
                bars.ui.confirm({
                    text: "Виконати операцію погашення?"
                }, function () {
                    bars.ui.loader('body', true);
                    for (var i = 0; i < selectDebitArray.length; i++) {
                        var selectDebit = gridDebit.dataItem(selectDebitArray[i]);
                        if (selectDebit.NLS != null && kredit > 0 && selectDebit.NPP && selectDebit.NPP > 0) {
                            var isgModel = {
                                KVD: selectKredit.KV,
                                NLSD: selectKredit.NLS,
                                SD: selectDebit.NPP * 100,//($scope.payment.NPP ? $scope.payment.NPP : selectDebit.NPP) * 100,
                                KVK: selectDebit.KV,
                                NLSK: selectDebit.NLS,
                                NAZN: selectDebit.NAZN  //$scope.payment.NAZN ? $scope.payment.NAZN : selectDebit.NAZN
                            };
                            isgModelArray.push(isgModel);
                        }
                    }
                    var url = "/creditui/analysisbalance/createIsg";
                    $http.post(bars.config.urlContent(url), isgModelArray).then(function (request) {
                        var data = request.data;
                        var successMsg = "Створено документи №";
                        var successRef = [];
                        var errorsMsg = "";

                        for (var i = 0; i < data.length; i++) {
                            if (data[i].error) {
                                errorsMsg += "Документ на рахунок №" + data[i].nlsb + " з помилками<br />"
                            }
                            else {
                                successRef.push(data[i].referense);
                            }
                        }

                        var msg = successMsg + successRef.toString() + "<br /><br /><span style='color:red'>" + errorsMsg + "</span>";

                        console.log(msg);
                        bars.ui.alert({
                            text: msg
                        });
                        //gridDebit.select().addClass("k-success-colored");
                        gridKredit.dataSource.read();
                        gridDebit.dataSource.read({ nd: $scope.nd, ccId: $scope.credit.CC_ID });
                        /*$scope.nppval.sum = ($scope.payment.NPP ? $scope.payment.NPP : selectDebit.NPP);
                        $scope.nppval.nls = selectDebit.NLS;*/
                        bars.ui.loader('body', false);
                    });
                });
            }

            /*var selectDebit = gridDebit.dataItem(gridDebit.select());
            debugger;
            var kredit = (selectKredit.OSTB < 0 ? -selectKredit.OSTB : selectKredit.OSTB);
            if (kredit < $scope.payment.NPP) {
                bars.ui.alert({
                    text: "Введена сума перебільшує залишок на рахунку!"
                });
            }
            else {
                bars.ui.confirm({
                    text: "Виконати операцію погашення?"
                }, function () {
                    bars.ui.loader('body', true);
                    if (selectDebit.NLS != null && kredit > 0) {
                        debugger;
                        var url = "/creditui/analysisbalance/createIsg";
                        var isgModel = {
                            KVD: selectKredit.KV,
                            NLSD: selectKredit.NLS,
                            SD: ($scope.payment.NPP ? $scope.payment.NPP : selectDebit.NPP) * 100,
                            KVK: selectDebit.KV,
                            NLSK: selectDebit.NLS,
                            NAZN: $scope.payment.NAZN ? $scope.payment.NAZN : selectDebit.NAZN
                        };
                        $http.post(bars.config.urlContent(url), isgModel).then(function (request) {
                            bars.ui.alert({
                                text: "Створено документ №" + request.data
                            });
                            //gridDebit.select().addClass("k-success-colored");
                            gridKredit.dataSource.read();
                            gridDebit.dataSource.read({ nd: $scope.nd, ccId: $scope.credit.CC_ID });
                            $scope.nppval.sum = ($scope.payment.NPP ? $scope.payment.NPP : selectDebit.NPP);
                            $scope.nppval.nls = selectDebit.NLS;
                            bars.ui.loader('body', false);
                        });
                    }
                });
            }*/
        };

        $scope.$watch('payment.NPP', function (e) {
            var total = $scope.CalcSum();
            var gridKredit = $scope.gridKredit;
            var gridDebit = $scope.gridDebit;
            var selectKredit = gridKredit.dataItem(gridKredit.select());
            var lastSelectItem = gridDebit.dataItem(gridDebit.select().last());

            var selectDebit = gridDebit.dataItem(gridDebit.select());
            if (selectKredit && selectDebit && $scope.credit.OSTB <= selectKredit.OSTB && $scope.payment.NPP > 0) {
                $scope.isDisExec = false;
                $scope.$apply();
            }
            else {
                $scope.isDisExec = true;
            }
            if (selectDebit && Math.abs($scope.payment.OSTC) < $scope.payment.NPP) {
                bars.ui.alert({
                    text: "Введена сума перевищує залишок на рахунку!"
                });

            }
            
              $("#Summ").html(total.toString().replace(/(\d{1,3})(?=((\d{3})*([^\d]|$)))/g, "$1"));
        });
    }]);