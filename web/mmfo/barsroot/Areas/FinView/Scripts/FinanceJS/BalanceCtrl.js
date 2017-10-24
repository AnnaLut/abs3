angular.module('BarsWeb.Controllers', ['kendo.directives'])
    .factory('transport', function() {
        return {
            parameters : {
                kf: '',
                nbs: '',
                //ob22: rowData.ob22,
                branch: '',
                kv: '',
                date: ''
            },
            docParams: {
                acc: '',
                date: ''
            },
            currentGrid: {
                grid: '',
                name: ''
            },
            branch : null
        }
    })
    .controller('FinanceView.BalanceCtrl', [
        '$scope', '$http', 'transport', function ($scope, $http, transport) {

        $scope.transport = transport;
        
        // btns states:
        $scope.btnState = {
            balance: false,
            account: false,
            document: false
        };

        $scope.gridState = {
            balance: true,
            account: false,
            document: false
        };

        var date = (new Date().getDate() < 9 ? '0' + new Date().getDate() : new Date().getDate()) +
                '/' + ((parseInt(new Date().getMonth(), 10) + 1) < 9 ? '0' + (parseInt(new Date().getMonth(), 10) + 1) : (parseInt(new Date().getMonth(), 10) + 1)) +
                '/' + new Date().getFullYear();

        $scope.balance = {
            date: date,
            rowType: 7
        };

         $scope.tabVal = {
            // must change with date change event
            usd: 0,
            eur: 0,
            rub: 0,
            xdr: 0
        };

        $scope.currencyRate = function (date) {

            var config = {
                date: date
            };

            var rates = $http({
                url: bars.config.urlContent("/api/finview/currentrate/get"),
                method: "GET",
                params: { date: date }
            });

            rates.success(function (result) {
                var data = result.Msg ? (function () {
                    var strMsg = result.Msg.slice(0, 101);
                    return bars.ui.alert({ text: 'Неможливо отримати значення курсів валют, причина: <br/>' + strMsg });
                })() : (function() {
                    $scope.tabVal.usd = result.USD;
                    $scope.tabVal.eur = result.EUR;
                    $scope.tabVal.rub = result.RUB;
                    $scope.tabVal.xdr = parseFloat(result.XDR);
                })();
            });
        };

        //balance toolbar widgets options:
        $scope.dateOptions = {
            format: 'dd/MM/yyyy'/*,
            change: function() {
                $scope.balanceGridOptions.dataSource.read({
                    date: function () {
                        return $scope.balance.date;
                    }
                });
                $scope.currencyRate($scope.balance.date);
            }*/
        };
            
        //balance toolbar 
        $scope.balanceToolbarOptions = {
            items: [
                {
                    template: 
                    "<div class='input-group input-group-sm' >" +
                        "<div style='margin-right:5px;'>" +
                            '<label>Дата:</label><input type="text" ng-model="balance.date" kendo-date-picker="" k-options="dateOptions" />' +
                            '<button class="k-button" ng-click="btnRefreshGrid()"><i class="pf-icon pf-16 pf-gears"></i></button>' +
                        "</div>" +
                    "</div>"
                },
                { type: 'separator' },
                /*{
                    template: "<button class='k-button' ng-show='true' ng-click='loadGridData()'><i class='pf-icon pf-16 pf-exel'></i>Завантажити</button>"
                },
                { type: 'separator' },*/
                {
                    template:
                        "<div class='col-xs-6'>" +
                        "<table class='custom-table'>" +
                            "<tbody>" +
                                "<tr>" +
                                    "<td>USD:</td>" +
                                    "<td class='usd-cell'>{{tabVal.usd}}</td>" +
                                    "<td>RUB:</td>" +
                                    "<td class='rub-cell'>{{tabVal.eur}}</td>" +
                                "</tr>" +
                                "<tr>" +
                                    "<td>EUR:</td>" +
                                    "<td class='eur-cell'>{{tabVal.rub}}</td>" +
                                    "<td>XDR:</td>" +
                                    "<td class='xdr-cell'>{{tabVal.xdr}}</td>" +
                                "</tr>" +
                            "</tbody>" +
                        "</table>" +
                        "</div>"
                },
                { type: 'separator' },
                { template: "<label>Фільтр:</label>" },
                {
                    template: "<input kendo-drop-down-list k-options='filterOptions' ng-model='balance.rowType' style='width: 220px;' />",
                    overflow: "never"
                }, 
                { type: 'separator' },
                /*{
                    template:
                        '<div style="margin-left:5px;float:left;">' +
                            '<div style="float:left;margin-top:2px;"><input type="checkbox" ng-model="useBranches" ng-change="switchBranches()"></div>' +
                            '<div style="margin-left: 10px;"><label>Фільтрувати за відділенням</label></div>' +
                        '</div>' +
                        
                        '<div ng-show="useBranches" style="float:right;margin-left: 5px;">' +
                        '<button class="k-button" ng-click="branchWindowOptions()"><i class="pf-icon pf-16 pf-filter-ok"></i></button>' +
                        '<div style="float:right;"><input name="branch" ng-model="branch" type="text" size="50" placeholder="Відділення..." readonly></div>' +
                        '</div>'
                }*/
                {
                    template: "<button class='k-button' ng-show='btnState.balance' ng-click='stateSwitcher(1)'><i class='pf-icon pf-16 pf-arrow_left'></i>Рівень балансу</button>"
                },
                {
                    template: "<button class='k-button' ng-show='btnState.account' ng-click='stateSwitcher(2)'><i class='pf-icon pf-16 pf-arrow_left'></i>Рівень рахунку</button>"
                }/*,
                {
                    template: "<button class='k-button' ng-show='btnState.document' ng-click='stateSwitcher(3)'><i class='pf-icon pf-16 pf-arrow_left'></i>Рівень документу</button>"
                }*/
            ]
        };

        $scope.filterOptions = {
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [
                { text: "0 - по Банку", value: 7 },
                { text: "1 - РУ", value: 8 },
                { text: "2 - РУ + Баланс", value: 9 },
                { text: "3 - РУ + Баланс + Вал", value: 10 },
                { text: "4 - РУ + Баланс + Вал + Відділення", value: 11 }
            ],
            select: function (e) {
                debugger;
                var dataItem = this.dataItem(e.item);
                
                if (dataItem.value === 11) {
                    $scope.branchWindowOptions();
                } else {

                    if (dataItem.value !== 7 || dataItem.value !== 7) {
                        $scope.stateSwitcher(1);
                    }

                    $scope.balanceGrid.dataSource.read({
                        date: function () {
                            return $scope.balance.date;
                        },
                        rowType: function () {
                            return dataItem.value;
                        }
                    });
                    $scope.currencyRate($scope.balance.date);
                }

                $scope.columsDisplaySwitcher(dataItem.value);
            }
        };

        $scope.columsDisplaySwitcher = function (val) {
            //debugger;
            switch (val) {
                case 9:
                    $scope.balanceGrid.showColumn('nbs');
                    break;
                case 10:
                    $scope.balanceGrid.showColumn('nbs');
                    $scope.balanceGrid.showColumn('kv');
                    $scope.balanceGrid.hideColumn('branch');
                    break;
                case 11:
                    $scope.balanceGrid.showColumn('nbs');
                    $scope.balanceGrid.showColumn('kv');
                    $scope.balanceGrid.showColumn('branch');
                    break;
                default:
                    $scope.balanceGrid.hideColumn('nbs');
                    $scope.balanceGrid.hideColumn('kv');
                    $scope.balanceGrid.hideColumn('branch');
            }
        };

        $scope.branchWindow;

        $scope.branchWindowOptions = function() {
            $scope.DlgOptions = {
                title: "Відділення",
                width: 500,
                //height: 500,
                visible: false,
                resizable: false,
                actions: ["Close"]
            };

            $scope.branchWindow.setOptions($scope.DlgOptions);
            $scope.branchWindow.center();
            $scope.branchWindow.open();
        };

        $scope.useBranches = false;

        $scope.switchBranches = function () {

            $scope.useBranches = $scope.useBranches ? true : false;

            if ($scope.useBranches) {
                debugger;
                $scope.balanceGrid.showColumn('branch');
            } else {
                debugger;
                transport.branch = null;
                $scope.balanceGrid.hideColumn('branch');
                $scope.balanceGrid.dataSource.read({
                    date: function () {
                        return $scope.balance.date;
                    },
                    rowType: function () {
                        return $scope.balance.rowType;
                    }
                });
                $scope.currencyRate($scope.balance.date);
            }
        }

        $scope.btnRefreshGrid = function () {

            transport.currentGrid = {
                grid: $scope.balanceGrid,
                name: 'balance'
            };

            $scope.balanceGridOptions.dataSource.read({
                date: function () {
                    debugger;
                    $scope.currencyRate($scope.balance.date);
                    return $scope.balance.date;
                },
                rowType: function () {
                    return $scope.balance.rowType;
                }
            });
        };

        /* --- redirect functions --- */
        $scope.stateSwitcher = function(state) {
            switch (state) {
                case 1:
                    debugger;
                    transport.currentGrid = {
                        grid: $scope.balanceGrid,
                        name: 'balance'
                    };
                    // grids state:
                    $scope.gridState.balance = true;
                    $scope.gridState.account = false;
                    $scope.gridState.document = false;
                    // btns state:
                    $scope.btnState.balance = false;
                    $scope.btnState.account = false;
                   // $scope.btnState.document = false;
                    break;
                case 2:
                    debugger;
                    transport.currentGrid = {
                        grid: $scope.accGrid,
                        name: 'account'
                    };
                    // grids state:
                    $scope.gridState.balance = false;
                    $scope.gridState.account = true;
                    $scope.gridState.document = false;
                    // btns state:
                    $scope.btnState.balance = true;
                    $scope.btnState.account = false;
                    //$scope.btnState.document = false;
                    break;
                case 3:
                    debugger;
                    transport.currentGrid = {
                        grid: $scope.docGrid,
                        name: 'document'
                    };
                    // grids state:
                    $scope.gridState.balance = false;
                    $scope.gridState.account = false;
                    $scope.gridState.document = true;
                    // btns state:
                    $scope.btnState.balance = true;
                    $scope.btnState.account = true;
                    //$scope.btnState.document = false;
                    break;
            }
        };

        /* --- end redirect --- */

        var docDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 10,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/finview/docdata"),
                        data: function() {
                            return transport.docParams;
                        }
                }
            },
            requestStart: function (e) {
                bars.ui.loader("body", true);
            },
            requestEnd: function (e) {
                bars.ui.loader("body", false);
            },
            schema: {
                data: function (result) {
                    return result.Data || (function () {
                        return bars.ui.alert({ text: 'Неможливо отримати значення таблиціб причина: <br/>' + result.Msg });
                    })();
                },
                total: function (result) {
                    return result.Total || 0;
                },
                model: {
                    fields: {
                        OperDB: { type: "string" },
                        RefDB: { type: "number" },
                        OperKR: { type: "string" },
                        RefKR: { type: "number" }
                    }
                }
            }
        });

        $scope.docGridOptions = {
            autoBind: false,
            dataSource: docDataSource,
            filterable: {
                mode: "row"
            },
            toolbar: ["excel"],
            excel: {
                fileName: "DocumentsData.xlsx",
                allPages: true,
                filterable: true,
                proxyURL: bars.config.urlContent("/finview/financeview/DocumentsToExcelFile")
            },
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100],
                buttonCount: 5
            },
            columns: [
                //{ command: { text: "View Doc"/*, click: */ }, title: "Дії", width: "110px" },
                { field: "OperDB", title: "Операція по дб", width: "150px" },
                {
                    field: "RefDB", title: "Реф по дб", width: "150px",
                    template: "<a class='mode' href='/barsroot/documentview/default.aspx?ref=#=RefDB#'>#= RefDB ? RefDB: '' #</a>"
                    // docinput/docinput.aspx?tt=#=OperDB#&refDoc=#=RefDB#
                },
                { field: "OperKR", title: "Операція по кр", width: "150px" },
                {
                    field: "RefKR", title: "Реф по кр", width: "150px",
                    template: "<a class='mode' href='/barsroot/documentview/default.aspx?ref=#=RefKR#'>#= RefKR ? RefKR : '' #</a>"
                    // docinput/docinput.aspx?tt=#=OperKR#&refDoc=#=RefKR#
                }
            ]
        };

        $scope.showDocumets = function (e) {
            e.preventDefault();

            var element = $(e.currentTarget);

            var row = element.closest('tr'),
                grid = $scope.accGrid,
                dataItem = grid.dataItem(row);

            transport.currentGrid = {
                grid: $scope.docGrid,
                name: 'document'
            };

            transport.docParams = {
                acc: dataItem.ACC,
                date: function () {
                    return $scope.balance.date;
                }
            };

            $scope.docGridOptions.dataSource.read(transport.docParams);

            $scope.btnState.balance = true;
            $scope.gridState.balance = false;

            $scope.btnState.account = true;
            $scope.gridState.account = false;

            //$scope.btnState.document = true;
            $scope.gridState.document = true;

            //$scope.$apply();
        }

        var accDataSource = new kendo.data.DataSource({
                type: "aspnetmvc-ajax",
                pageSize: 10,
                serverPaging: true,
                serverFiltering: true,
                serverSorting: true,
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/finview/balancedetails"),
                        data: function() {
                            return transport.parameters;
                        }
                    }
                },
                requestStart: function (e) {
                    bars.ui.loader("body", true);
                },
                requestEnd: function (e) {
                    bars.ui.loader("body", false);
                },
                schema: {
                    data: function (result) {
                        return result.Data || (function () {
                            return bars.ui.alert({ text: 'Неможливо отримати значення таблиціб причина: <br/>' + result.Msg });
                        })();
                    },
                    total: function (result) {
                        return result.Total || 0;
                    },
                    model: {
                        fields: {
                            KF: { type: "string" },
                            ACC: { type: "number" },
                            NLS: { type: "string" },
                            KV: { type: "number" },
                            OSTC: { type: "number" },
                            DOS: { type: "number" },
                            KOS: { type: "number" },
                            NMS: { type: "string" },
                            DAZS: { type: "date" },
                            BRANCH: { type: "string" }
                        }
                    }
                }
            });

        $scope.accGridOptions = {
            autoBind: false,
            dataSource: accDataSource,
            filterable: {
                mode: "row"
            },
            toolbar: ["excel"],
            excel: {
                fileName: "AccountsData.xlsx",
                allPages: true,
                filterable: true,
                proxyURL: bars.config.urlContent("/finview/financeview/AccountsToExcelFile")
            },
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100],
                buttonCount: 5
            },
            columns: [
                {
                    field: "KF", title: "Код філіалу(МФО)", width: "75px",
                    attributes: { 'class': "text-center" }
                },
                {
                    field: "ACC", title: "ІД Рахунку ", width: "75px",
                    template: "<div ng-click='showDocumets($event)' class='mode'>#:ACC#</div>"
                },
                { field: "NLS", title: "Рахунок", width: "75px" },
                {
                    field: "KV", title: "Код валюти", width: "75px",
                    attributes: { 'class': "text-center" },
                    filterable: {
                        cell: {
                            template: function (args) {
                                debugger;
                                // create a DropDownList of unique values (KV)
                                args.element.kendoDropDownList({
                                    dataSource: {
                                        transport: {
                                            read: {
                                                type: "GET",
                                                dataType: "json",
                                                url: bars.config.urlContent("/api/finview/kv/get")
                                            }
                                        }
                                    },
                                    optionLabel: {
                                        kv: ""
                                    },
                                    dataTextField: "kv",
                                    dataValueField: "kv",
                                    valuePrimitive: true
                                });
                            },
                            showOperators: false
                        }
                    }
                },
                {
                    field: "OSTC", title: "Поточний залишок", width: "75px",
                    format: "{0:n2}",
                    template: "<div>#= OSTC/100 #</div>",
                    attributes: { 'class': "text-right" }
                },
                {
                    field: "DOS", title: "Дт. обороти (номінал)", width: "75px",
                    format: "{0:n2}",
                    template: "<div>#= DOS/100 #</div>",
                    attributes: { 'class': "text-right" }
                },
                {
                    field: "KOS", title: "Кт. обороти (номінал)", width: "75px",
                    format: "{0:n2}",
                    template: "<div>#= KOS/100 #</div>",
                    attributes: { 'class': "text-right" }
                },
                { field: "NMS", title: "Назва рахунку", width: "125px" },
                {
                    field: "DAZS", title: "Дата закриття", width: "100px",
                    template: "<div>#= DAZS !== null ? kendo.toString(kendo.parseDate(DAZS),'dd/MM/yyyy') : '' #</div>"
                },
                { field: "BRANCH", title: "Відділення", width: "125px" }
            ]
        };

        $scope.showAccounts = function(e) {
            e.preventDefault();

            debugger;

            var element = $(e.currentTarget);

            var row = element.closest('tr'),
                grid = $scope.balanceGrid,
                dataItem = grid.dataItem(row);

            transport.currentGrid = {
                grid: $scope.accGrid,
                name: 'account'
            };

            transport.parameters = {
                kf: dataItem.kf.replace(/\s+/g, ''),
                nbs: dataItem.nbs,
                //ob22: rowData.ob22,
                branch: dataItem.branch,
                kv: dataItem.kv,
                date: $scope.balance.date
            };

            $scope.accGridOptions.dataSource.read(transport.parameters);

            $scope.btnState.balance = true;
            $scope.gridState.balance = false;

            $scope.gridState.account = true;

            //$scope.$apply();
        }
    
        // balance grid

         var columns = [
            //{ command: { text: "View Accounts", click: showAccounts }, title: " ", width: "120px" },
            {
                field: 'show_date',
                title: 'Дата балансу',
                hidden: true
            },
            {
                field: 'kf_name',
                title: 'Назва\nфіліалу',
                attributes: { 'class': "text-center" },
                width: 120 /*,
                        filterable: {
                            cell: {
                                showOperators: false
                            }
                        }*/
            },
            {
                field: 'kf',
                title: 'Код філіалу\n(МФО)',
                attributes: { 'class': "text-center" },
                width: 120
            },
            {
                field: 'row_type',
                title: 'Тип розрізу\nданих',
                hidden: true
            },
            {
                field: 'branch',
                title: 'Відділення',
                //width: 200,
                hidden: true
            },
            {
                field: 'nbs',
                title: 'Номер балансового\nрахунка (R020)',
                width: 150,
                template: "<div ng-click='showAccounts($event)' class='mode'>#=nbs#</div>",

                    /*function (options) {
                    debugger;
                    if (options.nbs) {
                        return "<div ng-click='showAccounts($event)>" + options.nbs + "</div>";
                    } else {
                        return "<div>" + options.nbs + "</div>";
                    }
                }*/
                hidden: true
            },
            {
                field: 'kv',
                title: 'Код валюти\n(R030)',
                width: 150,
                attributes: { 'class': "text-center" },
                filterable: {
                    cell: {
                        template: function (args) {
                            debugger;
                            // create a DropDownList of unique values (KV)
                            args.element.kendoDropDownList({
                                dataSource: {
                                    transport: {
                                        read: {
                                            type: "GET",
                                            dataType: "json",
                                            url: bars.config.urlContent("/api/finview/kv/get")
                                        }
                                    }
                                },
                                optionLabel: {
                                    kv: ""
                                },
                                dataTextField: "kv",
                                dataValueField: "kv",
                                valuePrimitive: true
                            });
                        },
                        showOperators: false
                    }
                },
                hidden: true
            },
            {
                field: 'dos',
                title: 'Дт. обороти\n(номінал)',
                format: "{0:n2}",
                template: "<div style='text-align:right;'>#=(dos/100).toFixed(2)#</div>",
                attributes: { 'class': "text-right" },
                width: 150,
                hidden: true
            },
            {
                field: 'dosq',
                title: 'Дт. обороти\n(еквівалент)',
                template: "<div style='text-align:right;'>#=(dosq/100).toFixed(2)#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" } /*,
                        width: 150*/
            },
            {
                field: 'kos',
                title: 'Кт. обороти\n(номінал)',
                format: "{0:n2}",
                template: "<div style='text-align:right;'>#=(kos/100).toFixed(2)#</div>",
                attributes: { 'class': "text-right" },
                width: 150,
                hidden: true
            },
            {
                field: 'kosq',
                title: 'Кт. обороти\n(еквівалент)',
                template: "<div style='text-align:right;'>#=(kosq/100).toFixed(2)#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" } /*,
                        width: 150*/
            },
            {
                field: 'ostd',
                title: 'Дт. залишок\n(номінал)',
                format: "{0:n2}",
                template: "<div style='text-align:right;'>#=(ostd/100).toFixed(2)#</div>",
                attributes: { 'class': "text-right" },
                width: 150,
                hidden: true
            },
            {
                field: 'ostdq',
                title: 'Дт. залишок\n(еквівалент)',
                template: "<div style='text-align:right;'>#=(ostdq/100).toFixed(2)#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" } /*,
                        width: 150*/
            },
            {
                field: 'ostk',
                title: 'Кт. залишок\n(номінал)',
                template: "<div style='text-align:right;'>#=(ostk/100).toFixed(2)#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" },
                width: 150,
                hidden: true
            },
            {
                field: 'ostkq',
                title: 'Кт. залишок\n(еквівалент)',
                template: "<div style='text-align:right;'>#=(ostkq/100).toFixed(2)#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" } /*,
                        width: 150*/
            }
        ];

        var balanceDataSource = new kendo.data.DataSource({
             type: 'webapi',
             transport: {
                 read: {
                     url: bars.config.urlContent('/api/finview/balancedata/'),
                     dataType: 'json' ,
                     data: {
                         date: function() {
                             return $scope.balance.date;
                         },
                         rowType: function () {
                             return $scope.balance.rowType;
                         }
                     }
                 }
             },
             requestStart: function (e) {
                 bars.ui.loader("body", true);
             },
             requestEnd: function (e) {
                 bars.ui.loader("body", false);
             },
             schema: {
                 data: function (result) {
                     debugger;
                     if (result.Msg === "Response ok") {
                         return result.Data.Data || (function () { return bars.ui.alert({ text: 'Неможливо отримати значення таблиціб причина: <br/>' + result.Msg }); })();
                     } else if (result.Msg.indexOf("ORA-20666: Information on the date") === 0) {
                         bars.ui.alert({ text: "Інформація за період " + $scope.balance.date + " недоступна!" });
                         return [];
                     } else {
                         return [];
                     }
                 },
                 total: function (result) {
                     debugger;
                     if (result.Msg === "Response ok") {
                         return result.Data.Total || result.length || 0;
                     } else if (result.Msg.indexOf("ORA-20666: Information on the date") === 0) {
                         return 0;
                     } else {
                         return 0;
                     }
                 },
                 model: {
                     fields: {
                         show_date: { type: "date" },
                         kf_name: { type: "string" },
                         kf: { type: "string" },
                         row_type: { type: "number" },
                         branch: { type: "string" },
                         nbs: { type: "string" },
                         kv: { type: "number" },
                         dos: { type: "number" },
                         dosq: { type: "number" },
                         kos: { type: "number" },
                         kosq: { type: "number" },
                         ostd: { type: "number" },
                         ostdq: { type: "number" },
                         ostk: { type: "number" },
                         ostkq: { type: "number" }
                     }
                 }
             },
             pageSize: 10,
             serverPaging: true,
             serverSorting: true,
             serverFiltering: true
        });

        $scope.balanceGridOptions = {
            autoBind: false,
            filterable: {
                mode: "row"
            },
            toolbar: ["excel"],
            excel: {
                fileName: "BalanceData.xlsx",
                allPages: true,
                filterable: true,
                proxyURL: bars.config.urlContent("/finview/financeview/GetBalanceToExcelFile")
            },
            selectable: "row",
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100],
                buttonCount: 5
            },
            dataSource: balanceDataSource,
            columns: columns
        }

        // branches toolbar options:
        $scope.branchesToolbaroptions = {
            items: [
                { template: '<button class="k-button" ng-click="btnFilterByBranch()"><i class="pf-icon pf-16 pf-ok"></i></button>' },
                { template: '<button class="k-button" ng-click="branchWindowClose()"><i class="pf-icon pf-16 pf-delete"></i></button>' }
            ]
        };

        $scope.btnFilterByBranch = function () {
            debugger;
            var grid = $scope.branchGrid,
                dataItem = grid.dataItem(grid.select());

            transport.branch = dataItem.NAME;
            $scope.balanceGrid.dataSource.read({
                date: function () {
                    return $scope.balance.date;
                },
                rowType: function () {
                    return $scope.balance.rowType;
                },
                branch: dataItem.BRANCH
            });
            // read currency rate too:
            $scope.currencyRate($scope.balance.date);
            $scope.branchWindow.close();
        }

        $scope.branchWindowClose = function() {
            $scope.branchWindow.close();
        };

        // branches grid options:
        $scope.branchesGridOptions = {
            autoBind: true,
            scrollable: true,
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100],
                buttonCount: 5
            },
            filterable: {
                mode: "row"
            },
            selectable: "row",
            dataSource: new kendo.data.DataSource({
                type: 'webapi',
                transport: {
                    read: {
                        // ToDo: change url apiBranch
                        url: bars.config.urlContent('/api/finview/branch/get'),
                        dataType: 'json'
                    }
                },
                schema: {
                    data: function (result) {
                        return result.Data || result;
                    },
                    total: function (result) {
                        return result.Total || result.length || 0;
                    },
                    model: {
                        fields: {
                            NAME: { type: "string" },
                            BRANCH: { type: "string" }
                        }
                    }
                },
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true
            }),
            columns: [
                {
                    field: 'NAME',
                    title: 'Назва'
                },
                {
                    field: 'BRANCH',
                    title: 'Відділення'
                }
            ]
        }


        $scope.loadGridData = function () {

            var grid = transport.currentGrid.grid;
            var gridName = transport.currentGrid.name;

            var parameterMap = grid.dataSource.transport.parameterMap;
            var data = parameterMap({ sort: grid.dataSource.sort(), filter: grid.dataSource.filter(), group: grid.dataSource.group() });
            var dataToUrl = $.param(data);

            dataToUrl += dataToUrl + '&date=' + $scope.balance.date + '&rowType=' + $scope.balance.rowType + '&branch=' + transport.branch;

            debugger;

            var url = bars.config.urlContent("/finview/financeview/GetBalanceToExcelFile?" + dataToUrl);
            document.location.href = url;
        }

        
}]);