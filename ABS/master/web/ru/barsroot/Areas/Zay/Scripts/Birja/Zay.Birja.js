angular.module('BarsWeb.Controllers')
    .controller('Zay.Birja', ['$scope', '$http', '$document', 'bridge', function ($scope, $http, $document, bridge) {

        /* --- init transport bridge --- */
        $scope.bridge = bridge;

        /* --- toolbar's buttons default state --- */
        $scope.enableBtn = false;
        $scope.enableBtnCurrency = false;
        $scope.isBuyActive = false;
        $scope.isSaleActive = false;
        $scope.buySatisfiedByDealer = false;
        $scope.saleSatisfiedByDealer = false;
        $scope.sos = null;
        $scope.visa = null;
        $scope.requestRows = [];

        $scope.gridsUpdateTrigger = function () {
            bridge.bDk = bridge.bDk === 1 ? 3 : 1;
            bridge.sDk = bridge.sDk === 2 ? 4 : 2;
            //reload bGrid abd sGrid together:
            $scope._bGridOptions.dataSource.read();
            $scope._sGridOptions.dataSource.read();
        };

        $scope.bGridUpdateTrigger = function () {
            bridge.bDk = bridge.bDk === 1 ? 3 : 1;
            $scope._bGridOptions.dataSource.read();
        };

        $scope.sGridUpdateTrigger = function () {
            bridge.sDk = bridge.sDk === 2 ? 4 : 2;
            $scope._sGridOptions.dataSource.read();
        };

        $scope.activeButton = function (targetGrid, operType) {
            if (targetGrid) {
                if ('buy' === operType) {
                    $scope.isBuyActive = !$scope.isBuyActive;
                    if ($scope.isBuyActive) targetGrid.showColumn("KV_CONV");
                    else targetGrid.hideColumn("KV_CONV");
                    $scope.bGridUpdateTrigger();
                } else if ('sale' === operType) {
                    $scope.isSaleActive = !$scope.isSaleActive;
                    if ($scope.isSaleActive) targetGrid.showColumn("KV_CONV");
                    else targetGrid.hideColumn("KV_CONV");
                    $scope.sGridUpdateTrigger();
                }

                //$scope.gridsUpdateTrigger();
            }

            //$scope.isActive = !$scope.isActive;
            //if (targetGrid) {
            //    if ($scope.isActive) {
            //        targetGrid.showColumn("KV_CONV");
            //    } else {
            //        targetGrid.hideColumn("KV_CONV");
            //    }
            //    $scope.gridsUpdateTrigger();
            //}
        };

        $scope.gridSatisfiedRefresh = function (arg) {

            if ('buy' === arg) {
                $scope.buySatisfiedByDealer = !$scope.buySatisfiedByDealer;
                $scope.sos = $scope.buySatisfiedByDealer ? 0.5 : null;
                $scope.visa = $scope.buySatisfiedByDealer ? 2 : null;
                $scope.bGrid.dataSource.read();
            }
            else if ('sale' === arg) {
                $scope.saleSatisfiedByDealer = !$scope.saleSatisfiedByDealer;
                $scope.sos = $scope.saleSatisfiedByDealer ? 0.5 : null;
                $scope.visa = $scope.saleSatisfiedByDealer ? 2 : null;
                $scope.sGrid.dataSource.read();
            }


            //$scope.isSatisfiedByDealer = !$scope.isSatisfiedByDealer;
            //$scope.sos = null === $scope.sos ? 0.5 : null;
            //$scope.visa = null === $scope.visa ? 2 : null;
            //$scope.bridge.activeTabGrid.dataSource.read();
            //$scope.gridBuy.dataSource.read();
        };

        /* --- toolbar --- */
        $scope._buyToolbarBirjaOptions = {
            items: [
                {
                    template: '<button class="k-button" ng-disabled="!enableBtn" ng-click="func_back()">' +
                    '<i class="pf-icon pf-16 pf-delete"></i>Повернути' +
                    '</button>'
                },
                {
                    template: '<button class="k-button" ng-disabled="!enableBtn" ng-click="func_save()">' +
                    '<i class="pf-icon pf-16 pf-save"></i>Зберегти' +
                    '</button>'
                },
                { type: 'separator' },
                {
                    template: '<button ng-class="{\'active\': buySatisfiedByDealer}" ng-click="gridSatisfiedRefresh(\'buy\')" title="Задоволені ділером. НЕзавізовані" type="button">Заявки на візу</button>'
                },
                { type: 'separator' },
                {
                    template: '<button ng-class="{\'active\': isBuyActive}" ng-disabled="!enableBtnCurrency" ng-click="activeButton(bridge.activeTabGrid, \'buy\')" type="button">За валюту</button>'
                }
            ]
        };

        $scope._saleToolbarBirjaOptions = {
            items: [
                {
                    template: '<button class="k-button" ng-disabled="!enableBtn" ng-click="func_back()">' +
                    '<i class="pf-icon pf-16 pf-delete"></i>Повернути' +
                    '</button>'
                },
                {
                    template: '<button class="k-button" ng-disabled="!enableBtn" ng-click="func_save()">' +
                    '<i class="pf-icon pf-16 pf-save"></i>Зберегти' +
                    '</button>'
                },
                { type: 'separator' },
                {
                    template: '<button ng-class="{\'active\': saleSatisfiedByDealer}" ng-click="gridSatisfiedRefresh(\'sale\')" title="Задоволені ділером. НЕзавізовані" type="button">Заявки на візу</button>'
                },
                { type: 'separator' },
                {
                    template: '<button ng-class="{\'active\': isSaleActive}" ng-disabled="!enableBtnCurrency" ng-click="activeButton(bridge.activeTabGrid, \'sale\')" type="button">За валюту</button>'
                }
            ]
        };

        $scope.clearSelection = function (selector) {
            if (selector) {
                if (selector.select()) {
                    $scope.requestRows = [];
                    selector.clearSelection();
                    $scope.enableBtn = false;
                }
            }
        };

        /* --- tabstip ---*/
        $scope._tabstripOptions = {
            activate: function (e) {
                e.item.innerText === "Купівля" ?
                    (function () {
                        bridge.activeTabGrid = $scope.bGrid;
                        $scope._bGridOptions.dataSource.read();
                    })() : (function () {
                        bridge.activeTabGrid = $scope.sGrid;
                        $scope._sGridOptions.dataSource.read();
                    })();
            }
        };

        $scope.succesResult = function (data) {
            $scope.data = data;
            $scope.successResults = [];
            $scope.errorResults = [];

            for (var j = 0; j < $scope.data.length; j++) {
                $scope.data[j].Status === 1 ? $scope.successResults.push($scope.data[j]) : $scope.errorResults.push($scope.data[j]);
            }
            if ($scope.errorResults.length > 0) {
                bars.ui.alert({
                    text: 'Зміни збережено: ' + $scope.successResults.length + '.<br/>' +
                    'Не збережено: ' + $scope.errorResults.length + '.<br/>' +
                    'Причина: ' + $scope.errorResults[0].Msg
                });
                bridge.activeTabGrid.dataSource.read();
            } else {
                bars.ui.alert({
                    text: 'Зміни збережено: ' + $scope.successResults.length + '.<br/>'
                });
                bridge.activeTabGrid.dataSource.read();
            }
        };

        $scope.sendBackRequest = function (arr) {
            var backReq = $http.post(bars.config.urlContent("/api/birja/zay/birjaback/post"), JSON.stringify(arr));
            backReq.success(function (data) {
                $scope.succesResult(data);
            });
        };

        $scope.func_back = function () {
            var modelPack = [];
            for (var i = 0; i < $scope.requestRows.length; i++) {
                modelPack.push({ id: $scope.requestRows[i].ID });
            }
            $scope.sendBackRequest(modelPack);
        };

        $scope.sendRequest = function (approve) {
            var sendReq = $http.post(bars.config.urlContent("/api/birja/zay/birja/post"), JSON.stringify(approve));
            sendReq.success(function (data) {
                $scope.succesResult(data);
            });
        };

        $scope.checkRequest = function (approve, error) {
            if (error.length > 0 && approve.length === 0) {
                bars.ui.alert({ text: "Нажаль, жодна з обраних заявок не відповідає умовам виконання візування!" });
            } else {
                if (error.length > 0) {
                    bars.ui.confirm({
                        text: "Наступні заявки не будуть завізовані:<br/>" + error.toString() +
                        "<br/>Так як їхній стан та значення не відповідають вимогам!<br/>" +
                        "Продовжити виконання операції?"
                    }, function () {
                        $scope.sendRequest(approve);
                    });
                } else {
                    $scope.sendRequest(approve);
                }
            }
        };

        $scope.func_save = function () {
            var approve = [],
                error = [];
            for (var i = 0; i < $scope.requestRows.length; i++) {
                if ($scope.requestRows[i].KURS_F !== null
                    && $scope.requestRows[i].VDATE !== null
                    && $scope.requestRows[i].SOS === 0.5) {
                    approve.push({ id: $scope.requestRows[i].ID, datz: $scope.requestRows[i].DATZ });
                } else {
                    error.push($scope.requestRows[i].ID);
                }
            }
            $scope.checkRequest(approve, error);
        };

        /* --- DataSource'S http result function --- */
        $scope.requestDataResult = function (result) {
            $scope.enableBtnCurrency = true;
            return result.Data || (function () {
                $scope.enableBtnCurrency = false;
                return bars.ui.error({ text: 'Помилка отримання значень таблиці:<br/>' + result.Msg });
            })();
        };

        /* --- DataBound function, to masked row condition --- */
        $scope.dataBound = function (e) {
            var rows = e.sender.tbody.children();
            for (var j = 0; j < rows.length; j++) {
                var dataItem = e.sender.dataItem(rows[j]);
                if (dataItem.SOS === 0 && dataItem.PRIORSTATE === 0) {
                    rows[j].addClass("COLOR_LightGray");
                } else if (dataItem.SOS >= 1) {
                    rows[j].addClass("COLOR_Sky");
                } else if (dataItem.KV2 === 840) {
                    rows[j].addClass("COLOR_DarkGreen");
                } else if (dataItem.KV2 === 978) {
                    rows[j].addClass("COLOR_MidnightBlue");
                } else if (dataItem.KV2 === 643) {
                    rows[j].addClass("COLOR_DarkRed");
                }
            }
        };

        /* --- columns arrais --- */
        var bColumnsArr = [
            {
                field: "START_TIME",
                title: "Час<br/>надходження<br/>заявки",
                template: "<div>#=kendo.toString(kendo.parseDate(START_TIME),'dd/MM/yyyy') === null ? '' : kendo.toString(kendo.parseDate(START_TIME),'dd/MM/yyyy hh:mm:ss')#</div>",
                width: 75
            },
            {
                field: "STATE",
                title: "Стан<br/>заявки",
                width: 100,
                filterable: {
                    ui: function (element) {
                        element.kendoDropDownList({
                            dataSource: getDdlDataSource("STATE", "bDk", "buySatisfiedByDealer"),
                            optionLabel: "--Select Value--",
                            open: filterReload
                        });
                    }
                }
            },
            {
                field: "DATZ",
                title: "Дата<br/>зачислення<br/>ВАЛЮТИ",
                template: "<div>#=kendo.toString(kendo.parseDate(DATZ),'dd/MM/yyyy') === null ? '' : kendo.toString(kendo.parseDate(DATZ),'dd/MM/yyyy')#</div>",
                width: 80
            },
            {
                field: "ID",
                title: "№ заявки",
                width: 80,
                filterable: {
                    ui: function (element) {
                        var idArr = $scope.bDataSource._data.map(function (row) { return row.ID + ''; });
                        element.kendoAutoComplete({
                            dataSource: idArr
                        });
                    }
                }
            },
            {
                field: "REQ_ID",
                title: "№ заявки<br/>РУ",
                width: 80
            },
            {
                field: "MFO",
                title: "МФО",
                width: 60,
                filterable: {
                    ui: function (element) {
                        var mfoArr = $scope.bDataSource._data.map(function (row) { return row.MFO; });
                        element.kendoAutoComplete({
                            dataSource: mfoArr
                        });
                    }
                }
            },
            {
                field: "MFO_NAME",
                title: "Найменування",
                width: 150,
                filterable: {
                    ui: function (element) {
                        var mfoNames = $scope.bDataSource._data.map(function (row) { return row.MFO_NAME; });
                        element.kendoAutoComplete({
                            dataSource: mfoNames
                        });
                    }
                }
            },
            {
                field: "RNK",
                title: "Рег.№<br/>клієнта",
                width: 80,
                filterable: {
                    ui: function (element) {
                        var rnkArr = $scope.bDataSource._data.map(function (row) { return row.RNK + ''; });
                        element.kendoAutoComplete({
                            dataSource: rnkArr
                        });
                    }
                }
            },
            {
                field: "NMK",
                title: "Клієнт-<br/>ПОКУПЕЦЬ",
                width: 250
            },
            {
                field: "KV2",
                template: "<div style='text-align: center;'>#=KV2#</div>",
                title: "Код<br/>ВАЛ",
                width: 45,
                filterable: {
                    ui: function (element) {
                        element.kendoDropDownList({
                            dataSource: getDdlDataSource("KV2", "bDk", "buySatisfiedByDealer"),
                            optionLabel: "--Select Value--",
                            open: filterReload
                        });
                    }
                }
            },
            {
                field: "S2",
                title: "Сума<br/>ВАЛ<br/>Купівлі",
                //template: "<div style='text-align: right;'>#=(S2/100).toFixed(2)#</div>",
                //template: "<div style='text-align: right;'>#=kendo.toString(S2/100,'n')#</div>",
                template: '#=kendo.toString(S2,"n")#',
                format: '{0:n3}',
                attributes: { "class": "money" },
                width: 100
            },
            {
                field: "KURS_KL",
                title: "Курс<br/>клієнта<br/>(початк.)",
                width: 70
            },
            {
                field: "KV_CONV",
                title: "За<br>ВАЛ",
                width: 60,
                template: "<div style='text-align: center;'>#=KV_CONV#</div>",
                hidden: true
            },
            {
                field: "KURS_F",
                title: "Курс<br/>дилера",
                //template: "<div style='text-align: right;'>#=(KURS_F).toFixed(2)#</div>",
                format: "{0:n8}",
                attributes: { "class": "money" },
                editor: function (container, options) {
                    $('<input data-bind="value:' + options.field + '"/>')
                        .appendTo(container)
                        .kendoNumericTextBox({
                            decimals: 8,
                            format: "n8"
                        });
                },
                width: 100
            },
            {
                field: "SOS_DECODED",
                title: "Отм",
                template: "<div style='text-align:center'>" +
                "<input name='SOS_DECODED' type='checkbox' data-bind='checked: SOS_DECODED' #= KURS_F !== null || VDATE !== null ? checked='checked' : '' # disabled/>" +
                "</div>",
                width: 40,
                filterable: false
            },
            {
                field: "VDATE",
                title: "Дата<br/>валюту-<br/>вання",
                template: "<div>#=kendo.toString(kendo.parseDate(VDATE),'dd/MM/yyyy') === null ? '' : kendo.toString(kendo.parseDate(VDATE),'dd/MM/yyyy')#</div>",
                width: 80
            },
            {
                field: "S2_EQV",
                title: "Еквівалент<br/>суми купівлі<br/>(по курсу дилера)",
                //template: "<div style='text-align: right;'>#=(S2*KURS_F/100).toFixed(2)#</div>",
                template: "#=kendo.toString(S2_EQV == null ? ' ' : S2_EQV,'n')#",
                format: '{0:n3}',
                attributes: { "class": "money" },
                width: 120
            },
            {
                field: "AIM_NAME",
                title: "Ціль<br/>заявки",
                width: 100
            },
            {
                field: "VDATE_PLAN",
                title: "Планова<br/>дата<br/>валютув.",
                template: "<div>#=kendo.toString(kendo.parseDate(VDATE_PLAN),'dd/MM/yyyy') === null ? '' : kendo.toString(kendo.parseDate(VDATE_PLAN),'dd/MM/yyyy')#</div>",
                width: 80
            },
            {
                field: "KURS_Z",
                title: "Курс<br/>заявки",
                template: "#=kendo.toString(KURS_Z == null ? ' ' : KURS_Z,'n')#",
                format: '{0:n3}',
                attributes: { "class": "money" },
                width: 70
            },
            {
                field: "CUST_BRANCH",
                title: "Відділення<br/>Клієнта-<br/>ПОКУПЦЯ",
                width: 200
            },
            {
                field: "PRIORNAME",
                title: "Пріо-<br/>ритет<br/>заявки",
                template: "<div style='text-align: center;'>#=PRIORNAME#</div>",
                width: 70
            },
            {
                field: "CLOSE_TYPE",
                title: "Тип<br/>закриття<br/>заявки",
                template: "<div style='text-align: center;'>#=CLOSE_TYPE == null ? ' ' : CLOSE_TYPE#</div>",
                width: 110
            },
            // {
            //     field: "REQ_TYPE",
            //     title: "Найменування<br/>типу<br/>заявки",
            //     width: 100
            // },
            {
                field: "COMM",
                title: "Коментар",
                width: 400
            }
        ];

        var sColumnsArr = [
            {
                field: "START_TIME",
                title: "Час<br/>надходження<br/>заявки",
                template: "<div>#=kendo.toString(kendo.parseDate(START_TIME),'dd/MM/yyyy') === null ? '' : kendo.toString(kendo.parseDate(START_TIME),'dd/MM/yyyy hh:mm:ss')#</div>",
                width: 75
            },
            {
                field: "STATE",
                title: "Стан<br/>заявки",
                width: 100,
                filterable: {
                    ui: function (element) {
                        element.kendoDropDownList({
                            dataSource: getDdlDataSource("STATE", "sDk", "saleSatisfiedByDealer"),
                            optionLabel: "--Select Value--",
                            open: filterReload
                        });
                    }
                }
            },
            {
                field: "ID",
                title: "№ заявки",
                width: 80,
                filterable: {
                    ui: function (element) {
                        var idArr = $scope.sDataSource._data.map(function (row) { return row.ID + ''; });
                        element.kendoAutoComplete({
                            dataSource: idArr
                        });
                    }
                }
            },
            {
                field: "REQ_ID",
                title: "№ заявки<br/>РУ",
                width: 80
            },
            {
                field: "MFO",
                title: "МФО",
                width: 60,
                filterable: {
                    ui: function (element) {
                        var mfoArr = $scope.sDataSource._data.map(function (row) { return row.MFO; });
                        element.kendoAutoComplete({
                            dataSource: mfoArr
                        });
                    }
                }
            },
            {
                field: "MFO_NAME",
                title: "Найменування",
                width: 150,
                filterable: {
                    ui: function (element) {
                        var mfoNames = $scope.sDataSource._data.map(function (row) { return row.MFO_NAME; });
                        element.kendoAutoComplete({
                            dataSource: mfoNames
                        });
                    }
                }
            },
            {
                field: "RNK",
                title: "Рег.№<br/>клієнта",
                width: 80,
                filterable: {
                    ui: function (element) {
                        var rnkArr = $scope.sDataSource._data.map(function (row) { return row.RNK + ''; });
                        element.kendoAutoComplete({
                            dataSource: rnkArr
                        });
                    }
                }
            },
            {
                field: "NMK",
                title: "Клієнт-<br/>Продавець",
                width: 250
            },
            {
                field: "KV2",
                template: "<div style='text-align: center;'>#=KV2#</div>",
                title: "Код<br/>ВАЛ",
                width: 45,
                filterable: {
                    ui: function (element) {
                        element.kendoDropDownList({
                            dataSource: getDdlDataSource("KV2", "sDk", "saleSatisfiedByDealer"),
                            optionLabel: "--Select Value--",
                            open: filterReload
                        });
                    }
                }
            },
            {
                field: "S2",
                title: "Сума<br/>ВАЛ<br/>на ПРОДАЖ",
                //template: "<div style='text-align: right;'>#=(S2/100).toFixed(2)#</div>",
                //template: "<div style='text-align: right;'>#=kendo.toString(S2/100,'n')#</div>",
                template: '#=kendo.toString(S2,"n")#',
                format: '{0:n3}',
                attributes: { "class": "money" },
                width: 100
            },
            {
                field: "OBZ",
                title: "ОБЗ",
                width: 75
            },
            {
                field: "KURS_KL",
                title: "Курс<br/>клієнта<br/>(початк.)",
                width: 70
            },
            {
                field: "KV_CONV",
                title: "За<br>ВАЛ",
                width: 60,
                template: "<div style='text-align: center;'>#=KV_CONV#</div>",
                hidden: true
            },
            {
                field: "KURS_F",
                title: "Курс<br/>дилера",
                //template: "<div style='text-align: right;'>#=(KURS_F).toFixed(2)#</div>",
                format: "{0:n8}",
                attributes: { "class": "money" },
                editor: function (container, options) {
                    $('<input data-bind="value:' + options.field + '"/>')
                        .appendTo(container)
                        .kendoNumericTextBox({
                            decimals: 8,
                            format: "n8"
                        });
                },
                width: 100
            },
            {
                field: "SOS_DECODED",
                title: "Отм",
                template: "<div style='text-align:center'>" +
                "<input name='SOS_DECODED' type='checkbox' data-bind='checked: SOS_DECODED' #= KURS_F !== null || VDATE !== null ? checked='checked' : '' # disabled/>" +
                "</div>",
                width: 40,
                filterable: false
            },
            {
                field: "VDATE",
                title: "Дата<br/>валюту-<br/>вання",
                template: "<div>#=kendo.toString(kendo.parseDate(VDATE),'dd/MM/yyyy') === null ? '' : kendo.toString(kendo.parseDate(VDATE),'dd/MM/yyyy')#</div>",
                width: 80
            },
            {
                field: "S2_EQV",
                title: "Еквівалент<br/>суми продажу<br/>(по курсу дилера)",
                //template: "<div style='text-align: right;'>#=(S2*KURS_F/100).toFixed(2)#</div>",
                template: "#=kendo.toString(S2_EQV == null ? ' ' : S2_EQV,'n')#",
                format: '{0:n3}',
                attributes: { "class": "money" },
                width: 120
            },
            {
                field: "AIM_NAME",
                title: "Ціль<br/>продажу",
                width: 100
            },
            {
                field: "KURS_Z",
                title: "Курс<br/>заявки",
                template: "#=kendo.toString(KURS_Z == null ? ' ' : KURS_Z,'n')#",
                format: '{0:n3}',
                attributes: { "class": "money" },
                width: 70
            },
            {
                field: "CUST_BRANCH",
                title: "Відділення<br/>Клієнта-<br/>ПРОДАВЦЯ",
                width: 200
            },
            {
                field: "PRIORNAME",
                title: "Пріо-<br/>ритет заявки",
                template: "<div style='text-align: center;'>#=PRIORNAME#</div>",
                width: 70
            },
            {
                field: "CLOSE_TYPE",
                title: "Тип<br/>закриття<br/>заявки",
                template: "<div style='text-align: center;'>#=CLOSE_TYPE == null ? ' ' : CLOSE_TYPE#</div>",
                width: 110
            },
            // {
            //     field: "REQ_TYPE",
            //     title: "Найменування<br/>типу<br/>заявки",
            //     width: 100
            // },
            {
                field: "COMM",
                title: "Коментар",
                width: 400
            }
        ];

        /* --- Grids events --- */
        $scope.onSelection = function (data, kendoEvent) {
            if (bridge.activeTabGrid.select().length > 0) {
                $scope.enableBtn = true;
            }
            $scope.requestRows = data;//kendoEvent.sender.select();          
        };

        /* --- bGrid data --- */
        $scope.bDataSource = new kendo.data.DataSource({
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent('/api/zay/birjabdata/get'),
                    dataType: 'json',
                    data: {
                        dk: function () { return bridge.bDk; },
                        sos: function () { return $scope.sos = $scope.buySatisfiedByDealer ? 0.5 : null; },
                        visa: function () { return $scope.visa = $scope.buySatisfiedByDealer ? 2 : null; }
                    }
                }
            },
            requestStart: function (e) {
                $scope.clearSelection(bridge.activeTabGrid);
            },
            schema: {
                data: $scope.requestDataResult,
                total: function (result) {
                    return result.Total || 0;
                },
                model: {}
            },
            pageSize: 10,
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true
        });

        /* --- bGrid --- */
        $scope._bGridOptions = {
            autoBind: true,
            dataSource: $scope.bDataSource,
            filterable: true,
            sortable: true,
            selectable: 'multiple, row',
            pageable: {
                refresh: true,
                pageSizes: [15, 30, 45, 60],
                buttonCount: 5
            },
            columns: bColumnsArr,
            dataBound: function (data) {
                var grid = this;
                $scope.setColorGrid(grid);
            },
            noRecords: {
                template: "<h4>Немає заявок, що відповідають вказаним критеріям. Поточна сторінка: #=this.dataSource.page()#</h4>"
            }
            //dataBound: $scope.dataBound,
        };

        /* --- sGrid data --- */
        $scope.sDataSource = new kendo.data.DataSource({
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent('/api/zay/birjasdata/get'),
                    dataType: 'json',
                    data: {
                        dk: function () { return bridge.sDk; },
                        sos: function () { return $scope.sos = $scope.saleSatisfiedByDealer ? 0.5 : null; },
                        visa: function () { return $scope.visa = $scope.saleSatisfiedByDealer ? 2 : null; }
                    }

                }
            },
            requestStart: function (e) {
                $scope.clearSelection(bridge.activeTabGrid);
            },
            schema: {
                data: $scope.requestDataResult,
                total: function (result) {
                    return result.Total || 0;
                },
                model: {}
            },
            pageSize: 10,
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true
        });

        /* --- sGrid --- */
        $scope._sGridOptions = {
            autoBind: true,
            filterable: true,
            selectable: 'multiple, row',
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: [15, 30, 45, 60],
                buttonCount: 5
            },
            dataSource: $scope.sDataSource,
            columns: sColumnsArr,
            dataBound: function (data) {
                var grid = this;
                $scope.setColorGrid(grid);
            },
            noRecords: {
                template: "<h4>Немає заявок, що відповідають вказаним критеріям. Поточна сторінка: #=this.dataSource.page()#</h4>"
            }
        };

        $scope.setColorGrid = function (grid) {
            grid.tbody.find('>tr').each(function () {
                var dataItem = grid.dataItem(this);
                if (dataItem.SOS === 0 && dataItem.PRIORSTATE === 0) {
                    $(this).addClass("COLOR_LightGray");
                } else if (dataItem.SOS >= 1) {
                    $(this).addClass("COLOR_Sky");
                } else if (dataItem.KV2 === 840) {
                    $(this).addClass("COLOR_DarkGreen");
                } else if (dataItem.KV2 === 978) {
                    $(this).addClass("COLOR_MidnightBlue");
                } else if (dataItem.KV2 === 643) {
                    $(this).addClass("COLOR_DarkRed");
                }
            });
        };

        function sortUnique(arr) {
            arr.sort();
            var last_i;
            for (var i = 0; i < arr.length; i++)
                if ((last_i = arr.lastIndexOf(arr[i])) !== i)
                    arr.splice(i + 1, last_i - i);
            return arr;
        }

        $document.ready(function () {
            bridge.activeTabGrid = $scope.bGrid;
        });
        /* ----- end ctrl ----- */

        function getDdlDataSource(param, dk, endorsement) {
            return {
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: "application/json",
                        url: bars.config.urlContent("/api/zay/birja/GetDdlValues"),
                        data: {
                            dk: function () { return bridge[dk]; },
                            sos: function () { return $scope.sos = $scope[endorsement] ? 0.5 : null; },
                            visa: function () { return $scope.visa = $scope[endorsement] ? 2 : null; },
                            field: function () { return param; }
                        }
                    }
                }
            };
        }


        function filterReload() {
            this.dataSource.read();
        }

    }]);