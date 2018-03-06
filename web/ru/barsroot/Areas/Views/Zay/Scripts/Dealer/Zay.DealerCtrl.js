angular.module('BarsWeb.Controllers')
    .factory('transport', function () {
        return {
            backReasonModel: {
                id: "",
                viza: "",
                reasonType: "",
                comment: ""
            },
            gridHandler: {},
            backBuyWindow: {},
            backSaleWindow: {},
            btnBackRequestOption: {},
            gridBuy: {},
            gridSale: {},
            rateConfigWin: {},
            defRateConfig: {
                /*rateType: 1,
                viewType: 1,
                kvCode: 980,
                pair: {},
                pairData : "",
                rateComfigModel: {
                        kvCode: $scope.kvCode
                    }*/

            },
            multiAprooveGridHandler: {},
            multiApprovedWindow: {},
            multiApproveData: [],
            multiApproveCurs: {
                value: null
            },
            separationGridHandler: {},
            separationWindow: {},
            separationModel: {
                id: null,
                totalSum: null,
                sum1: null,
                sum2: null
            },
            vizaViewWindow: {},
            vizaViewGridOptions: {},
            vizaViewGrid: {},
            vizaView: {
                id: null
            }
        };
    })

    .controller('Zay.DealerCtrl', [
        '$scope', '$http', 'transport', function ($scope, $http, transport) {

            // Buy:
            // gridBuy reload condition:
            $scope.isActive = false;
            $scope.isEmptyList = true;
            $scope.buyEndorsedOnly = false;
            $scope.saleEndorsedOnly = false;
            $scope.sos = null;
            $scope.visa = null;

            $scope.isSeparator = true;
            $scope.isSaleSeparator = true;

            // set dealer data:
            $scope.forUpdateData = [];

            $scope.dkBuy = 1;
            $scope.gridBuyRefresh = function () {
                $scope.isActive = !$scope.isActive;
                if ($scope.isActive) {
                    $scope.gridBuy.showColumn("KV_CONV");
                } else {
                    $scope.gridBuy.hideColumn("KV_CONV");
                }
                $scope.dkBuy = $scope.dkBuy === 1 ? 3 : 1;
                $scope.gridBuy.dataSource.read();
            };

            $scope.gridEndorsedRefresh = function (arg, tabSwitch) {
                tabSwitch = tabSwitch || false;
                if ('buy' === arg) {
                    if (!tabSwitch) $scope.buyEndorsedOnly = !$scope.buyEndorsedOnly;
                    $scope.sos = $scope.buyEndorsedOnly ? 0 : null;
                    $scope.visa = $scope.buyEndorsedOnly ? 2 : null;
                    $scope.gridBuy.dataSource.read();
                }
                else if ('sale' === arg) {
                    if (!tabSwitch) $scope.saleEndorsedOnly = !$scope.saleEndorsedOnly;
                    $scope.sos = $scope.saleEndorsedOnly ? 0 : null;
                    $scope.visa = $scope.saleEndorsedOnly ? 2 : null;
                    $scope.gridSale.dataSource.read();
                }
            }

            $scope.buyS2EqvColumnVisible = false;
            $scope.SaleS2EqvColumnVisible = false;
            $scope.columnSwitcher = function (id) {
                if (id == 'sale') {
                    $scope.SaleS2EqvColumnVisible = !$scope.SaleS2EqvColumnVisible;
                    if ($scope.SaleS2EqvColumnVisible) {
                        $scope.gridSale.showColumn("S2_EQV");
                    }
                    else {
                        $scope.gridSale.hideColumn("S2_EQV");
                    }
                }
                else {   // buy
                    $scope.buyS2EqvColumnVisible = !$scope.buyS2EqvColumnVisible;
                    if ($scope.buyS2EqvColumnVisible) {
                        $scope.gridBuy.showColumn("S2_EQV");
                    }
                    else {
                        $scope.gridBuy.hideColumn("S2_EQV");
                    }
                }
            };

            /* --- tabstip ---*/
            $scope._tabstripOptions = {
                activate: function (e) {
                    e.item.innerText === "Покупка валюти" ?
                        (function () {
                            $scope.gridBuy.dataSource.read();
                        })()
                        : (function () {
                            $scope.gridSale.dataSource.read();
                        })();
                }
            };

            // close rateConfigWindow condition:
            $scope.onCloseRateConfigWindow = function () {

                transport.defRateConfig();
            };
            transport.rateConfigWin = $scope.rateConfigWindow;

            $scope.openRateConfigWindow = function () {
                $scope.rateConfigWindow.center().open();
            }

            $scope.openCurrencyRateArchiveWindow = function () {
                $scope.currencyRateArchiveWindow.center().open();
            }

            $scope.toolbarBuyOptions = {
                items: [
                    {
                        type: "button",
                        text: "Button",
                        template: "<button title='Повернути' class='k-button' ng-disabled='!btnBackRequest' ng-click='backRequest()'><i class='pf-icon pf-16 pf-delete'></i></button>"
                    },
                    { // was: ng-disabled='!btnSave'
                        template: "<button title='Зберегти зміни в базі даних' class='k-button'  ng-click='saveUpdatedData()'><i class='pf-icon pf-16 pf-save'></i></button>"
                    },
                    { type: "separator" },
                    {
                        template: "<button title='Курс дилера' class='k-button'  ng-click='openRateConfigWindow()'><i class='pf-icon pf-16 pf-currency_conversion'></i></button>"
                    },
                    {
                        template: "<button title='Перегляд курсів дилера (архив)' class='k-button'  ng-click='openCurrencyRateArchiveWindow()'><i class='pf-icon pf-16 pf-help'></i></button>"
                    },
                    {
                        template: "<button title='Показати(сховати) еквіваленти' class='k-button'  ng-click='columnSwitcher()'><i class='pf-icon pf-16 pf-table_column'></i></button>"
                    },
                    { type: "separator" },
                    {
                        template: "<button title='Пакетне погодження заявок' class='k-button' ng-disabled='isEmptyList' ng-click='openDlgWindowApprove()'><i class='pf-icon pf-16 pf-ok'></i></button>"
                    },
                    {
                        template: "<button title='Розділення заявки' class='k-button' ng-disabled='isSeparator' ng-click='openDlgWindowSeparation()'><i class='pf-icon pf-16 pf-tree'></i></button>"
                    },
                    /*{
                        type: "button",
                        text: "За валюту",
                        togglable: true,
                        toggle: $scope.gridBuyRefresh
                    },*/
                    { type: "separator" },
                    {
                        template: "<button title='Перегляд статусів заявки' class='k-button' ng-disabled='!btnBackRequest' ng-click='openDlgWindowVizaView()'><i class='pf-icon pf-16 pf-report_open'></i></button>"
                    },
                    { type: "separator" },
                    {
                        template: '<button ng-class="{\'active\': buyEndorsedOnly}" ng-click="gridEndorsedRefresh(\'buy\')" title="Очікують ділера" type="button">Заявки на обробку</button>'
                    },
                    { type: "separator" },
                    {
                        template: '<button ng-class="{\'active\': isActive}" ng-click="gridBuyRefresh()" type="button">За валюту</button>'
                    }
                ]
            }

            $scope.gridBuyDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: "application/json",
                        url: bars.config.urlContent("/api/zayBuy/zay/dealerbuy/get"),
                        data: {
                            dk: function () { return $scope.dkBuy; },
                            sos: function () { return $scope.sos = $scope.buyEndorsedOnly ? 0 : null; },
                            visa: function () { return $scope.visa = $scope.buyEndorsedOnly ? 2 : null; }
                        }
                    }
                },
                requestEnd: function (e) {
                    var response = e.response;
                    for (var i = 0; i < response.Data.length; i++) {
                        response.Data[i].UPDATED_SOS_DECODED = 0;
                    }
                },
                schema: {
                    data: 'Data',
                    total: 'Total',
                    model: {
                        fields: {
                            ID: { type: "number", editable: false },
                            MFO: { type: "string", editable: false },
                            MFO_NAME: { type: "string", editable: false },
                            REQ_ID: { type: "number", editable: false },
                            DK: { type: "number", editable: false },
                            SOS: { type: "number", editable: false },
                            SOS_DECODED: { type: "number", editable: false },
                            KV2: { type: "number", editable: false },
                            LCV: { type: "string", editable: false },
                            DIG: { type: "number", editable: false },
                            FDAT: { type: "date", editable: false },
                            KURS_Z: { type: "number", editable: false },
                            VDATE: { type: "date", editable: true }, // E
                            KURS_F: { type: "number", editable: true, validation: { min: 0 } }, // E
                            S2: { type: "number", editable: false },
                            VIZA: { type: "number", editable: false },
                            DATZ: { type: "date", editable: false },
                            RNK: { type: "number", editable: false },
                            NMK: { type: "string", editable: false },
                            CUST_BRANCH: { type: "string", editable: false },
                            PRIORITY: { type: "number", editable: false },
                            PRIORNAME: { type: "string", editable: false },
                            AIM_NAME: { type: "string", editable: false },
                            COMM: { type: "string", editable: false },
                            KURS_KL: { type: "string", editable: false },
                            KV_CONV: { type: "number", editable: false },
                            PRIORVERIFY_VIZA: { type: "number", editable: false },
                            CLOSE_TYPE: { type: "number", editable: true },
                            CLOSE_TYPE_NAME: { type: "string", editable: true },
                            STATE: { type: "string", editable: false },
                            START_TIME: { type: "date", editable: false },
                            REQ_TYPE: { type: "number", editable: false },
                            VDATE_PLAN: { type: "date", editable: false },

                            S2_EQV: { type: "number", editable: false }
                        }
                    }
                },
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true
            });

            $scope.gridBuyOptions = {
                dataSource: $scope.gridBuyDataSource,
                filterable: true,
                sortable: true,
                selectable: "multiple, row",
                editable: true,
                pageable: {
                    //refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                toolbar: [{ name: "excel", text: 'Друк' }],
                excel: {
                    fileName: "Dealer_BuyData.xlsx",
                    allPages: true,
                    filterable: true,
                    proxyURL: bars.config.urlContent("/zay/Dealer/ConvertBase64ToFile")
                },
                columns: [
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
                                    dataSource: getDdlDataSource("STATE", "/api/zayBuy/zay/dealerbuy/GetDdlValues", "dkBuy", "buyEndorsedOnly"),
                                    optionLabel: "--Select Value--",
                                    open: filterReload
                                });
                            }
                        }
                    },
                    {
                        field: "DATZ",
                        title: "Дата<br/>зарахування<br/>коштів",
                        template: "<div>#=kendo.toString(kendo.parseDate(DATZ),'dd/MM/yyyy') === null ? '' : kendo.toString(kendo.parseDate(DATZ),'dd/MM/yyyy')#</div>",
                        width: 80
                    },
                    {
                        field: "ID",
                        title: "№ заявки",
                        width: 80,
                        filterable: {
                            ui: function (element) {
                                var idArr = $scope.gridBuyDataSource._data.map(function (row) { return row.ID + ''; });
                                element.kendoAutoComplete({
                                    dataSource: idArr,
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
                                var mfoArr = $scope.gridBuyDataSource._data.map(function (row) { return row.MFO; });
                                element.kendoAutoComplete({
                                    dataSource: mfoArr,
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
                                var mfoNames = $scope.gridBuyDataSource._data.map(function (row) { return row.MFO_NAME; });
                                element.kendoAutoComplete({
                                    dataSource: mfoNames,
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
                                var rnkArr = $scope.gridBuyDataSource._data.map(function (row) { return row.RNK + ''; });
                                element.kendoAutoComplete({
                                    dataSource: rnkArr,
                                });
                            }
                        }
                    },
                    {
                        field: "NMK",
                        title: "Клієнт-<br/>покупець",
                        width: 250
                    },
                    {
                        field: "KV2",
                        title: "Код<br/>вал",
                        width: 45,
                        template: "<div style='text-align: center;'>#=KV2#</div>",
                        filterable: {
                            ui: function (element) {
                                element.kendoDropDownList({
                                    dataSource: getDdlDataSource("KV2", "/api/zayBuy/zay/dealerbuy/GetDdlValues", "dkBuy", "buyEndorsedOnly"),
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
                        // template: "<div style='text-align: right;'>#=kendo.toString(S2/100,'n')#</div>",
                        template: '#=kendo.toString(S2,"n")#',
                        format: '{0:n}',
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
                        "<input name='SOS_DECODED' type='checkbox' ng-click='change($event)' data-bind='checked: SOS_DECODED' #= UPDATED_SOS_DECODED === 1 || SOS_DECODED === 1 ? checked='checked' : '' #  #= SOS_DECODED === 1 ? 'disabled' : ''#/>" +
                        "</div>",
                        width: 40,
                        filterable: false
                    },
                    {
                        field: "VDATE",
                        title: "Дата<br/>валюту-<br/>вання",
                        template: "<div>#=kendo.toString(VDATE,'dd/MM/yyyy') === null ? '' : kendo.toString(VDATE,'dd/MM/yyyy')#</div>",
                        //template: "#= kendo.toString(kendo.parseDate(VDATE, 'dd/MM/yyyy'), 'dd/MM/yyyy') #",
                        width: 80
                    },
                    {
                        field: "S2_EQV",
                        title: "Еквівалент<br/>суми купівлі<br/>(по курсу дилера)",
                        //template: "<div style='text-align:right;background-color:rgb(165,205,232);'>#=(S2*KURS_F/100).toFixed(2)#</div>",
                        hidden: (function () {
                            return $scope.dkBuy === 3 ? false : true;
                        })(),
                        width: 120,
                        attributes: { "class": "money" },
                        format: "{0:n2}"
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
                        //template: "<div style='text-align: right;'>#=(KURS_Z).toFixed(2)#</div>",
                        template: "<div style='text-align: right;'>#=kendo.toString(KURS_Z == null ? ' ' : KURS_Z,'n')#</div>",
                        format: '{0:n3}',
                        attributes: { "class": "money" },
                        width: 70
                    },
                    {
                        field: "CUST_BRANCH",
                        title: "Відділення<br/>Клієнта-<br/>покупця",
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
                        width: 110,
                        editor: function (container, options) {

                            var input = $('<input data-text-field="CLOSE_TYPE_NAME" data-value-field="CLOSE_TYPE" data-bind="value:' + options.field + '" />');
                            input.appendTo(container);

                            // init block of dropdownlist:
                            input.kendoDropDownList({
                                autoBind: true,
                                dataTextField: "CLOSE_TYPE_NAME",
                                dataValueField: "CLOSE_TYPE",
                                optionLabel: "Змінити на...",
                                valueTemplate: '<span>#:CLOSE_TYPE#</span>',
                                template: '<span class="k-state-default"></span>' +
                                '<span class="k-state-default">#:CLOSE_TYPE_NAME#</span>',
                                dataSource: {
                                    transport: {
                                        read: {
                                            type: "GET",
                                            dataType: "json",
                                            url: bars.config.urlContent("/api/zay/closetypes/get")
                                        }
                                    }
                                },
                                change: function (e) {
                                    var type = this.value();

                                    var row = this.element.closest('tr'),
                                        grid = $scope.gridBuy,
                                        dataItem = grid.dataItem(row);

                                    if (type) {
                                        row.addClass('success');
                                    } else {
                                        row.removeClass('success').addClass('danger');
                                    }

                                    dataItem.set('CLOSE_TYPE', type);
                                }
                            }).appendTo(container);
                        }
                    },
                    // {
                    //     field: "REQ_TYPE",
                    //     title: "Найменування<br/>типа<br/>заявки",
                    //     template: "<div style='text-align: center;'>#=(REQ_TYPE == null) ? ' ' : REQ_TYPE#</div>",
                    //     width: 100
                    // },
                    {
                        field: "COMM",
                        title: "Коментар",
                        width: 400
                    }
                ],
                dataBound: function (data) {
                    $scope.btnBackRequest = false;
                    //$scope.btnSave = false;

                    $scope.gridBuy.tbody.find('>tr').each(function () {
                        var dataItem = $scope.gridBuy.dataItem(this);
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
                },
                noRecords: {
                    template: "<h4>Немає заявок, що відповідають вказаним критеріям. Поточна сторінка: #=this.dataSource.page()#</h4>"
                }
            };

            $scope.multiApprove = function (curs) {
                var arr = transport.multiApproveData;
                var grid = transport.multiAprooveGridHandler;

                /*   grid.select().each(function () {
                       var selectRow = grid.dataItem($(this));
                       selectRow.KURS_F = curs.value;
                       selectRow.set("KURS_F", curs.value);
                       selectRow.SOS_DECODED = 1;
                       selectRow.SOS = parseInt(glDilViza) === 1 ? parseFloat(0.5) : 1;
                       var date;
                       if (kendo.parseDate(selectRow.FDAT, 'dd.MM.yyyy') < kendo.parseDate(glBankDate, 'dd.MM.yyyy'))
                       { date = glBankDate; }
                       else { date = selectRow.FDAT; }
                  
                       selectRow.VDATE = kendo.parseDate(date, 'dd.MM.yyyy');
                       console.log(selectRow);
                   });*/


                //    for (var a = 0; a < arr.length; a++) {

                //    var cell = transport.gridHandler.tbody.find("tr[data-uid=" + arr[a].uid + "]");
                //    cell.find('td').find('input[data-bind]').attr('checked', 'checked');

                //}
                for (var i = 0; i < arr.length; i++) {
                    var row = transport.gridHandler.tbody.find("tr[data-uid=" + arr[i].uid + "]");
                    row.find('td').find('input[data-bind]').attr('checked', 'checked');
                    var item = grid.dataItem(row);
                    item.set("KURS_F", curs.value);
                    item.SOS_DECODED = 1;
                    item.SOS = parseInt(glDilViza) === 1 ? parseFloat(0.5) : 1;
                    var data;
                    if (kendo.parseDate(item.FDAT, 'dd.MM.yyyy') < kendo.parseDate(glBankDate, 'dd.MM.yyyy'))
                    { data = glBankDate; }
                    else { data = item.FDAT; }
                    // var data = kendo.parseDate(item.FDAT, 'dd/MM/yyyy') < kendo.parseDate(glBankDate, 'dd.MM.yyyy') ? kendo.parseDate(glBankDate, 'dd/MM/yyyy') : kendo.parseDate(item.FDAT, 'dd/MM/yyyy');

                    item.set("VDATE", data);

                    $scope.forUpdateData.push(item);

                }
                $scope.$apply();

                //console.log($scope.forUpdateData);
                transport.multiApprovedWindow.close();
            };

            function checkDataCurrency(array) {
                var value = array[0].KV2,
                    i = 0,
                    result = false;
                for (i; i < array.length; i++) {
                    if (value === array[i].KV2) {
                        result = true;
                    } else {
                        bars.ui.error({ text: 'Не співпадають валюти!' });
                        result = false;
                    }
                }
                return result;
            };

            $scope.doSomething = function () {
                // do something awesome
                focus('curs');
            };

            $scope.openDlgWindowApprove = function () {

                $scope.DlgMultiOptions = {
                    title: "Валюта",
                    width: 600,
                    visible: false,
                    resizable: false,
                    actions: ["Close"],
                    close: function () {
                        $scope.isEmptyList = true;
                        transport.multiApproveData = [];
                        //$scope.gridBuy.dataSource.read();
                    },
                    open: function () {
                        //$scope.doSomething();
                    }
                };

                // to close window from Zay.ReasonCtrl:
                transport.multiApprovedWindow = $scope.multiApprovedWindow;
                transport.multiAprooveGridHandler = $scope.gridBuy;

                $scope.multiApprovedWindow.setOptions($scope.DlgMultiOptions);
                $scope.multiApprovedWindow.center();
                $scope.multiApprovedWindow.open();
            };

            $scope.openDlgWindowVizaView = function () {
                $scope.DlgVizaViewOptions = {
                    title: "Перегляд статусів заявки",
                    width: 800,
                    visible: false,
                    resizable: false,
                    actions: ["Close"],
                    close: function () {
                        //transport.vizaViewGrid = {};
                    },
                    open: function () {
                        //var a = transport.vizaViewGridOptions;
                        transport.vizaViewGridOptions.dataSource.read({ id: transport.vizaView.id });
                    }
                };

                transport.vizaViewWindow = $scope.VizaViewWindow;

                $scope.VizaViewWindow.setOptions($scope.DlgVizaViewOptions);
                $scope.VizaViewWindow.center();

                transport.vizaViewGrid = $scope.gridVizaView;
                $scope.VizaViewWindow.open();
            };

            //grid event hendler:
            $scope.handleChange = function (data, dataItem, columns, kendoEvent) {
                $scope.btnBackRequest = true;

                // default state
                transport.multiApproveData = [];
                // 
                $scope.data = data;
                $scope.columns = columns;
                $scope.dataItem = dataItem;
                $scope.sender = kendoEvent.sender;

                if (data.length > 1 && checkDataCurrency(data)) {
                    $scope.isEmptyList = false;

                    for (var i = 0; i < data.length; i++) {
                        /*  if (data[i].STATE === "Завізована ZAY3.Очікує ділера") {
                              transport.multiApproveData.push(data[i]);
                          }*/
                        if ((data[i].SOS == 0) && (data[i].VIZA == 2)) {
                            transport.multiApproveData.push(data[i]);

                        }
                    }

                } else {
                    $scope.isEmptyList = true;
                }

                if ($scope.btnBackRequest) {
                    transport.vizaView.id = data[0].ID;
                    transport.vizaViewGridOptions.dataSource.read({
                        id: transport.vizaView.id
                    });
                }

                // Separation check:
                if (data.length === 1) {
                    $scope.isSeparator = false;
                    transport.separationModel.id = data[0].ID;
                    transport.separationModel.totalSum = data[0].S2;
                } else {
                    $scope.isSeparator = true;
                }

                //GRID handler:

                transport.gridHandler = kendoEvent.sender;

                // disable if sos : 0 - введена, 0.5 - удовлетворена дилером незавизирована
                //var sos = data.SOS < 1 && data.SOS >= 0 ? false : true;

                //if (sos && data.PRIORVERIFY_VIZA === 1) { /* was: data.SOS_DECODED === 1 */
                //    if ($scope.gridBuy === kendoEvent.sender) {
                //        $scope.btnSave = true;
                //    }
                //}


                transport.backReasonModel = {
                    id: data[0].ID, // так як data.id повертав undefined
                    viza: 4,//data.VIZA,
                    reasonType: "",
                    comment: ""
                };

                transport.btnBackRequestOption = $scope.btnBackRequest;
            };

            $scope.transport = transport;

            // back window init & config:
            $scope.window;

            $scope.backRequest = function () {

                $scope.DlgOptions = {
                    title: "Повернення",
                    width: 600,
                    visible: false,
                    resizable: false,
                    actions: ["Close"],
                    close: function () {
                        $scope.btnBackRequest = false;
                        $scope.gridBuy.dataSource.read();
                    }
                };

                // to close window from Zay.ReasonCtrl:
                transport.backBuyWindow = $scope.window;
                transport.gridBuy = $scope.gridBuy;

                $scope.window.setOptions($scope.DlgOptions);
                $scope.window.center();
                $scope.window.open();
            };

            $scope.change = function (e, curs) {
                var c = curs;

                var element = $(e.currentTarget);

                var checked = element.is(':checked'),
                    row = element.closest('tr'),
                    grid = $scope.gridBuy,
                    dataItem = grid.dataItem(row);

                if (checked) {
                    //buy  
                    dataItem["UPDATED_SOS_DECODED"] = 1;
                    dataItem["SOS"] = parseInt(glDilViza) === 1 ? parseFloat(0.5) : 1;
                    dataItem.set("VDATE", dataItem.FDAT < kendo.parseDate(glBankDate, 'dd.MM.yyyy') ? glBankDate : dataItem.FDAT);
                    //dataItem.set("KURS_F", dataItem.KURS_F === null ? dataItem.KURS_Z : null);
                    dataItem["KURS_F"] = dataItem.KURS_F === null ? dataItem.KURS_Z : null;

                    //$scope.forUpdateData.push(dataItem);
                    if ($scope.forUpdateData.length < 1) {
                        $scope.forUpdateData.push(dataItem);
                    } else {
                        for (var a = $scope.forUpdateData.length; a--;) {
                            if ($scope.forUpdateData[a] !== dataItem) {
                                $scope.forUpdateData.push(dataItem);
                            }
                        }
                    }


                    //$scope.btnSave = true;
                } else {
                    dataItem["UPDATED_SOS_DECODED"] = 0;
                    dataItem.set("KURS_F", null);
                    dataItem.set("VDATE", null);
                    for (var i = $scope.forUpdateData.length; i--;) {
                        if ($scope.forUpdateData[i] === dataItem) {
                            $scope.forUpdateData.splice(i, 1);
                        }
                    }
                    //$scope.btnSave = $scope.forUpdateData.length > 0 ? true : false;
                }
            };

            $scope.closeTypesValidation = function (array) {
                var i = 0;
                for (i; i < array.length; i++) {
                    if (array[i].CLOSE_TYPE) {
                        return true;
                    } else {
                        return false;
                    }
                }
            };

            // clear update data array & all btns:
            $scope.clearDataFunc = function () {
                $scope.forUpdateData = [];

                //$scope.btnSave = false;
                $scope.btnBackRequest = false;

                //$scope.btnSaveSale = false;
                $scope.btnBackSaleRequest = false;
            };

            // update dealer data request:
            function updateDealerDataRequest(arrData) {
                var update = $http.post(bars.config.urlContent("/api/zay/updatedata/post"), JSON.stringify(arrData));
                update.success(function (data) {

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

                        $scope.gridBuy.dataSource.read();
                        $scope.gridSale.dataSource.read();

                        // clear update data array:
                        $scope.clearDataFunc();

                    } else {
                        bars.ui.alert({
                            text: 'Зміни збережено: ' + $scope.successResults.length + '.<br/>'
                        });

                        $scope.gridBuy.dataSource.read();
                        $scope.gridSale.dataSource.read();

                        // clear update data array:
                        $scope.clearDataFunc();

                    }
                });
            }

            // update dealer data: 
            $scope.saveUpdatedData = function () {
                //if false nor all viza set
                if ($scope.forUpdateData.length > 0) {


                    //if ($scope.closeTypesValidation($scope.forUpdateData)) {
                    //console.log($scope.forUpdateData);

                    var arrData = [],
                        arrErr = [];
                    for (var i = 0; i < $scope.forUpdateData.length; i++) {

                        // disable if sos : 0 - введена, 0.5 - удовлетворена дилером незавизирована
                        //var sos = $scope.forUpdateData[i].SOS < 1 && $scope.forUpdateData[i].SOS >= 0 ? false : true;

                        var sos = $scope.forUpdateData[i].SOS >= 0 && $scope.forUpdateData[i].VIZA == 2 ? true : false;

                        if (sos) {
                            arrData.push({
                                Id: $scope.forUpdateData[i].ID,
                                KursF: $scope.forUpdateData[i].KURS_F,
                                Sos: $scope.forUpdateData[i].SOS,
                                Vdate: $scope.forUpdateData[i].VDATE,
                                CloseType: $scope.forUpdateData[i].CLOSE_TYPE,
                                Fdat: $scope.forUpdateData[i].FDAT
                            });
                        } else {
                            arrErr.push({
                                Id: $scope.forUpdateData[i].ID
                            });
                        }
                    }

                    if (arrErr.length > 0 && arrData.length > 0) {
                        bars.ui.confirm({
                            text: "У переліку заявок на погодження є ті, що мають стан \"Незавізовано\" (кіл-ть: " + arrErr.length + ")!<br/>Відповідні " +
                            "заявки не будуть погоджені, бажаєте продовжити?"
                        }, function () {
                            updateDealerDataRequest(arrData);
                        });
                        $scope.clearDataFunc();
                        $scope.gridBuy.dataSource.read();
                        $scope.gridSale.dataSource.read();

                    } else if (arrErr.length > 0 && arrData.length === 0) {
                        bars.ui.error({ text: 'Змінені заявки не можуть бути погоджені тому, що мають стан \"Незавізовано\"!' });
                        $scope.gridBuy.dataSource.read();
                        $scope.gridSale.dataSource.read();
                        $scope.clearDataFunc();
                    }
                    else {
                        //var a = arrData;
                        updateDealerDataRequest(arrData);
                    }

                    //} else {
                    //    bars.ui.error({ text: 'Перевірте чи задано значення закриття заявки!' });
                    //}

                } else {
                    bars.ui.alert({
                        text: 'Не обрані заявки для погодження!'
                    });
                }
            };

            // Sale:
            // gridSale reload condition:
            $scope.dkSale = 2;
            $scope.isEmptySaleList = true;

            $scope.isActiveSale = false;
            $scope.gridSaleRefresh = function () {
                $scope.isActiveSale = !$scope.isActiveSale;
                if ($scope.isActiveSale) {
                    $scope.gridSale.showColumn("KV_CONV");
                } else {
                    $scope.gridSale.hideColumn("KV_CONV");
                }
                $scope.dkSale = $scope.dkSale === 2 ? 4 : 2;
                $scope.gridSale.dataSource.read();
            };

            $scope.toolbarSaleOptions = {
                items: [
                    {
                        type: "button",
                        text: "Button",
                        template: "<button title='Повернути' class='k-button' ng-disabled='!btnBackSaleRequest' ng-click='backSaleRequest()'><i class='pf-icon pf-16 pf-delete'></i></button>"
                    },
                    {
                        // was: ng-disabled='!btnSaveSale'
                        template: "<button title='Зберегти зміни в базі даних' class='k-button'  ng-click='saveUpdatedData()'><i class='pf-icon pf-16 pf-save'></i></button>"
                    },
                    { type: "separator" },
                    {
                        type: "buttonGroup",
                        buttons: [
                            {
                                spriteCssClass: "pf-icon pf-16 pf-currency_conversion",
                                text: ' Курс дилера',
                                showText: "overflow",
                                click: function () {
                                    return $scope.rateConfigWindow.center().open();
                                }
                            },
                            {
                                spriteCssClass: "pf-icon pf-16 pf-help",
                                text: 'Просмотр курсов дилера (архив)',
                                showText: "overflow",
                                click: function () {
                                    return $scope.currencyRateArchiveWindow.center().open();
                                }
                            },
                            {
                                spriteCssClass: "pf-icon pf-16 pf-table_column",
                                text: "Показати(сховати) еквіваленти",
                                showText: "overflow",
                                click: function () {
                                    return $scope.columnSwitcher("sale");
                                }
                            }
                        ]
                    },
                    { type: "separator" },
                    {
                        template: "<button title='Пакетне погодження заявок' class='k-button' ng-disabled='isEmptySaleList' ng-click='openDlgWindowSaleApprove()'><i class='pf-icon pf-16 pf-ok'></i></button>"
                    },
                    {
                        template: "<button title='Розділення заявки' class='k-button' ng-disabled='isSaleSeparator' ng-click='openDlgWindowSaleSeparation()'><i class='pf-icon pf-16 pf-tree'></i></button>"
                    },
                    /*{ type: "separator" },
                    {
                        type: "button",
                        text: "За валюту",
                        togglable: true,
                        toggle: $scope.gridSaleRefresh
                    },*/
                    { type: "separator" },
                    {
                        template: "<button title='Перегляд статусів заявки' class='k-button' ng-disabled='!btnBackSaleRequest' ng-click='openDlgWindowVizaView()'><i class='pf-icon pf-16 pf-report_open'></i></button>"
                    },
                    { type: "separator" },
                    {
                        template: '<button ng-class="{\'active\': saleEndorsedOnly}" ng-click="gridEndorsedRefresh(\'sale\')" title="Очікують ділера" type="button">Заявки на обробку</button>'
                    },

                    { type: "separator" },
                    {
                        template: '<button ng-class="{\'active\': isActiveSale}" ng-click="gridSaleRefresh()" type="button">За валюту</button>'
                    }
                ]
            }

            $scope.gridSaleDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: "application/json",
                        url: bars.config.urlContent("/api/zaySale/zay/dealersale/get"),
                        data: {
                            dk: function () { return $scope.dkSale; },
                            sos: function () { return $scope.sos = $scope.saleEndorsedOnly ? 0 : null; },
                            visa: function () { return $scope.visa = $scope.saleEndorsedOnly ? 2 : null; }
                        }
                    }
                },
                requestEnd: function (e) {
                    var response = e.response;
                    for (var i = 0; i < response.Data.length; i++) {
                        response.Data[i].UPDATED_SOS_DECODED = 0;
                    }
                },
                schema: {
                    data: 'Data',
                    total: 'Total',
                    model: {
                        fields: {
                            ID: { type: "number", editable: false },
                            MFO: { type: "string", editable: false },
                            MFO_NAME: { type: "string", editable: false },
                            REQ_ID: { type: "number", editable: false },
                            DK: { type: "number", editable: false },
                            SOS: { type: "number", editable: false },
                            SOS_DECODED: { type: "number", editable: false },
                            KV2: { type: "number", editable: false },
                            LCV: { type: "string", editable: false },
                            DIG: { type: "number", editable: false },
                            KV_CONV: { type: "number", editable: false },
                            FDAT: { type: "date", editable: false },
                            KURS_Z: { type: "number", editable: false },
                            VDATE: { type: "date", editable: true }, //
                            KURS_F: { type: "number", editable: true, validation: { min: 0 } }, //
                            S2: { type: "number", editable: false },
                            VIZA: { type: "number", editable: false },
                            DATZ: { type: "date", editable: false },
                            RNK: { type: "number", editable: false },
                            NMK: { type: "string", editable: false },
                            CUST_BRANCH: { type: "string", editable: false },
                            PRIORITY: { type: "number", editable: false },
                            PRIORNAME: { type: "string", editable: false },
                            AIM_NAME: { type: "string", editable: false },
                            COMM: { type: "string", editable: false },
                            KURS_KL: { type: "string", editable: false },
                            PRIORVERIFY_VIZA: { type: "number", editable: false },
                            CLOSE_TYPE: { type: "number", editable: true }, //
                            CLOSE_TYPE_NAME: { type: "string", editable: true }, //
                            STATE: { type: "string", editable: false },
                            START_TIME: { type: "date", editable: false },
                            REQ_TYPE: { type: "number", editable: false },
                            VDATE_PLAN: { type: "date", editable: false },
                            OBZ: { type: "number", editable: false }
                        }
                    }
                },
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true
            });

            $scope.gridSaleOptions = {
                dataSource: $scope.gridSaleDataSource,
                sortable: true,
                filterable: true,
                selectable: "multiple, row",
                editable: true,
                pageable: {
                    //refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                toolbar: [{ name: "excel", text: 'Друк' }],
                excel: {
                    fileName: "Dealer_SaleData.xlsx",
                    allPages: true,
                    filterable: true,
                    proxyURL: bars.config.urlContent("/zay/Dealer/ConvertBase64ToFile")
                },
                columns: [
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
                                    dataSource: getDdlDataSource("STATE", "/api/zaySale/zay/dealersale/GetDdlValues", "dkSale", "saleEndorsedOnly"),
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
                                var idArr = $scope.gridSaleDataSource._data.map(function (row) { return row.ID + ''; });
                                element.kendoAutoComplete({
                                    dataSource: idArr,
                                });
                            }
                        }
                    },
                    {
                        field: "MFO",
                        title: "МФО",
                        width: 60,
                        filterable: {
                            ui: function (element) {
                                var mfoArr = $scope.gridSaleDataSource._data.map(function (row) { return row.MFO; });
                                element.kendoAutoComplete({
                                    dataSource: mfoArr,
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
                                var mfoNames = $scope.gridSaleDataSource._data.map(function (row) { return row.MFO_NAME; });
                                element.kendoAutoComplete({
                                    dataSource: mfoNames,
                                });
                            }
                        }
                    },
                    {
                        field: "RNK",
                        title: "Рег.№<br/>клиента",
                        width: 80,
                        filterable: {
                            ui: function (element) {
                                var rnkArr = $scope.gridSaleDataSource._data.map(function (row) { return row.RNK + ''; });
                                element.kendoAutoComplete({
                                    dataSource: rnkArr,
                                });
                            }
                        }
                    },
                    {
                        field: "NMK",
                        title: "Клієнт-<br/>ПРОДАВЕЦЬ",
                        width: 250
                    },
                    {
                        field: "KV2",
                        title: "Код<br/>ВАЛ",
                        width: 45,
                        template: "<div style='text-align: center;'>#=KV2#</div>",
                        filterable: {
                            ui: function (element) {
                                element.kendoDropDownList({
                                    dataSource: getDdlDataSource("KV2", "/api/zaySale/zay/dealersale/GetDdlValues", "dkSale", "saleEndorsedOnly"),
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
                        template: "<div style='text-align:center'>" +
                        "<input name='OBZ' type='checkbox' data-bind='checked: OBZ' #= OBZ === 1 ? checked='checked' : '' #  disabled/>" +
                        "</div>",
                        width: 75
                    },
                    {
                        field: "KURS_KL",
                        title: "Курс<br/>клієнта<br/>(початк.)",
                        width: 70
                    },
                    {
                        hidden: true,
                        field: "KV_CONV",
                        title: "За<br>ВАЛ",
                        template: "<div style='text-align: center;'>#=KV_CONV#</div>",
                        width: 60
                    },
                    {
                        field: "KURS_F",
                        title: "Курс<br/>дилера",
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
                        "<input name='SOS_DECODED' type='checkbox' ng-click='changeSale($event)' data-bind='checked: SOS_DECODED' #= UPDATED_SOS_DECODED === 1 || SOS_DECODED === 1 ? checked='checked' : '' #  #= SOS_DECODED === 1 ? 'disabled' : ''#/>" +
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
                        //template: "<div style='text-align: right;background-color:rgb(165,205,232);'>#=(S2*KURS_F/100).toFixed(2)#</div>",
                        hidden: true,
                        width: 120,
                        attributes: { "class": "money" },
                        format: "{0:n2}"
                    },
                    {
                        field: "AIM_NAME",
                        title: "Ціль<br/>продажу",
                        width: 100
                    },
                    {
                        field: "KURS_Z",
                        title: "Курс<br/>заявки",
                        template: "<div style='text-align: right;'>#=kendo.toString(KURS_Z == null ? ' ' : KURS_Z,'n')#</div>",
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
                        width: 110,
                        editor: function (container, options) {

                            var input = $('<input data-text-field="CLOSE_TYPE_NAME" data-value-field="CLOSE_TYPE" data-bind="value:' + options.field + '" />');
                            input.appendTo(container);

                            // init block of dropdownlist:
                            input.kendoDropDownList({
                                autoBind: true,
                                dataTextField: "CLOSE_TYPE_NAME",
                                dataValueField: "CLOSE_TYPE",
                                optionLabel: "Змінити на...",
                                valueTemplate: '<span>#:CLOSE_TYPE#</span>',
                                template: '<span class="k-state-default"></span>' +
                                '<span class="k-state-default">#:CLOSE_TYPE_NAME#</span>',
                                dataSource: {
                                    transport: {
                                        read: {
                                            type: "GET",
                                            dataType: "json",
                                            url: bars.config.urlContent("/api/zay/closetypes/get")
                                        }
                                    }
                                },
                                change: function (e) {
                                    var type = this.value();

                                    var row = this.element.closest('tr'),
                                        grid = $scope.gridSale,
                                        dataItem = grid.dataItem(row);

                                    if (type) {
                                        row.addClass('success');
                                    } else {
                                        row.removeClass('success').addClass('danger');
                                    }

                                    dataItem.set('CLOSE_TYPE', type);
                                }
                            }).appendTo(container);
                        }
                    },
                    // {
                    //     field: "REQ_TYPE",
                    //     title: "Найменування<br/>типу<br/>заявки",
                    //     template: "<div style='text-align: center;'>#=(REQ_TYPE == null) ? ' ' : REQ_TYPE#</div>",
                    //     width: 100
                    // },
                    {
                        field: "COMM",
                        title: "Коментар",
                        width: 400
                    }
                ],
                dataBound: function (data) {
                    $scope.btnBackSaleRequest = false;

                    $scope.gridSale.tbody.find('>tr').each(function () {
                        var dataItem = $scope.gridSale.dataItem(this);
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
                },
                noRecords: {
                    template: "<h4>Немає заявок, що відповідають вказаним критеріям. Поточна сторінка: #=this.dataSource.page()#</h4>"
                }
            };

            $scope.openDlgWindowSaleApprove = function () {

                $scope.DlgSaleMultiOptions = {
                    title: "Валюта",
                    width: 600,
                    visible: false,
                    resizable: false,
                    actions: ["Close"],
                    close: function () {
                        $scope.isEmptySaleList = true;
                        transport.multiApproveData = [];
                    }
                };

                transport.multiApprovedWindow = $scope.multiApprovedWindow;
                transport.multiAprooveGridHandler = $scope.gridSale;

                $scope.multiApprovedWindow.setOptions($scope.DlgSaleMultiOptions);
                $scope.multiApprovedWindow.center();
                $scope.multiApprovedWindow.open();
            };

            //grid event hendler:
            $scope.handleSaleChange = function (data, dataItem, columns, kendoEvent) {
                $scope.btnBackSaleRequest = true;
                // default state
                transport.multiApproveData = [];
                // 
                $scope.data = data;
                $scope.columns = columns;
                $scope.dataItem = dataItem;
                $scope.sender = kendoEvent.sender;

                //GRID handler:
                if (data.length > 1 && checkDataCurrency(data)) {
                    $scope.isEmptySaleList = false;

                    for (var i = 0; i < data.length; i++) {
                        /* if (data[i].STATE === "Завизирована ZAY3. Ожидает дилера")
                             transport.multiApproveData.push(data[i]);*/
                        if ((data[i].SOS == 0) && (data[i].VIZA == 2)) {
                            transport.multiApproveData.push(data[i]);
                        }
                    }

                } else {
                    $scope.isEmptySaleList = true;
                }

                if ($scope.btnBackSaleRequest) {
                    transport.vizaView.id = data[0].ID;
                    transport.vizaViewGridOptions.dataSource.read({
                        id: transport.vizaView.id
                    });
                }

                // Separation check:
                if (data.length === 1) {
                    $scope.isSaleSeparator = false;
                    transport.separationModel.id = data[0].ID;
                    transport.separationModel.totalSum = data[0].S2;
                } else {
                    $scope.isSaleSeparator = true;
                }

                transport.gridHandler = kendoEvent.sender;

                //if (data.SOS_DECODED === 1)
                //    $scope.btnSaveSale = true;

                transport.backReasonModel = {
                    id: data[0].ID, // так як data.id повертав undefined
                    viza: 4,//data.VIZA,
                    reasonType: "",
                    comment: ""
                };

                transport.btnBackRequestOption = $scope.btnBackSaleRequest;
            };

            $scope.changeSale = function (e) {
                var element = $(e.currentTarget);

                var checked = element.is(':checked'),
                    row = element.closest('tr'),
                    grid = $scope.gridSale,
                    dataItem = grid.dataItem(row);

                if (checked) {
                    //sale
                    dataItem["UPDATED_SOS_DECODED"] = 1;
                    dataItem["SOS"] = parseInt(glDilViza) === 1 ? parseFloat(0.5) : 1;
                    dataItem.set("VDATE", dataItem.FDAT < kendo.parseDate(glBankDate, 'dd.MM.yyyy') ? glBankDate : dataItem.FDAT);
                    //dataItem.set("KURS_F", dataItem.KURS_F === null ? dataItem.KURS_Z : null);
                    dataItem["KURS_F"] = dataItem.KURS_F === null ? dataItem.KURS_Z : null;

                    //$scope.forUpdateData.push(dataItem);
                    if ($scope.forUpdateData.length < 1) {
                        $scope.forUpdateData.push(dataItem);
                    } else {
                        for (var a = $scope.forUpdateData.length; a--;) {
                            if ($scope.forUpdateData[a] !== dataItem) {
                                $scope.forUpdateData.push(dataItem);
                            }
                        }
                    }

                    //$scope.btnSaveSale = true;
                } else {
                    dataItem["UPDATED_SOS_DECODED"] = 0;
                    dataItem.set("KURS_F", null);
                    dataItem.set("VDATE", null);
                    for (var i = $scope.forUpdateData.length; i--;) {
                        if ($scope.forUpdateData[i] === dataItem) {

                            $scope.forUpdateData.splice(i, 1);
                        }
                    }

                    //$scope.btnSaveSale = $scope.forUpdateData.length > 0 ? true : false;
                }
            };

            $scope.backSaleRequest = function () {

                $scope.DlgOptions = {
                    title: "Повернення",
                    width: 600,
                    visible: false,
                    resizable: false,
                    actions: ["Close"],
                    close: function () {
                        $scope.btnBackSaleRequest = false;
                        $scope.gridSale.dataSource.read();
                    }
                };

                // to close window from Zay.ReasonCtrl:
                transport.backSaleWindow = $scope.window;
                transport.gridSale = $scope.gridSale;

                $scope.window.setOptions($scope.DlgOptions);
                $scope.window.center();
                $scope.window.open();
            };

            // - end - 

            // Dlg separation sum

            $scope.openDlgWindowSeparation = function () {

                $scope.DlgSeparationOptions = {
                    title: "Розділення заявки",
                    width: 600,
                    visible: false,
                    resizable: false,
                    actions: ["Close"],
                    close: function () {
                        $scope.isSeparator = true;
                        $scope.gridBuy.dataSource.read();
                    }
                };

                transport.separationWindow = $scope.separationWindow;
                transport.separationGridHandler = $scope.gridBuy;

                $scope.separationWindow.setOptions($scope.DlgSeparationOptions);
                $scope.separationWindow.center();
                $scope.separationWindow.open();
            };

            $scope.openDlgWindowSaleSeparation = function () {

                $scope.DlgSaleSeparationOptions = {
                    title: "Розділення заявки",
                    width: 600,
                    visible: false,
                    resizable: false,
                    actions: ["Close"],
                    close: function () {
                        $scope.isSaleSeparator = true;
                        $scope.gridSale.dataSource.read();
                    }
                };

                transport.separationWindow = $scope.separationWindow;
                transport.separationGridHandler = $scope.gridSale;

                $scope.separationWindow.setOptions($scope.DlgSaleSeparationOptions);
                $scope.separationWindow.center();
                $scope.separationWindow.open();
            };

            function sumValidation(model) {
                var result = true;
                if ((parseFloat(model.sum1) + parseFloat(model.sum2)) > parseFloat(model.totalSum)) {
                    bars.ui.error({ text: 'Сума заявок 1 та 2 не має перевищувати загальної суми зявки!' });
                    result = false;
                } else if (parseFloat(model.sum1) + parseFloat(model.sum2) !== parseFloat(model.totalSum)) {
                    bars.ui.error({ text: 'Сума заявок 1 та 2 має відповідати загальній сумі зявки!' });
                    result = false;
                }
                return result;
            }

            $scope.approveSeparation = function (model) {
                if (sumValidation(model)) {
                    var sepRequestHttp = $http.post(bars.config.urlContent("/api/zay/separation/post"), JSON.stringify(model));
                    sepRequestHttp.success(function (data) {
                        if (data.Status === "Ok") {
                            transport.separationWindow.close();
                            transport.separationModel = {};
                        } else {
                            transport.separationWindow.close();
                            bars.ui.error({
                                text: 'Заявка: ' + reason.id + '.<br/>' +
                                data.Message
                            });
                            transport.separationModel = {};
                        }

                    });
                }
            };

            function getDdlDataSource(param, url, dk, endorsement) {
                return {
                    transport: {
                        read: {
                            type: "GET",
                            dataType: 'json',
                            contentType: "application/json",
                            url: bars.config.urlContent(url),
                            data: {
                                dk: function () { return $scope[dk]; },
                                sos: function () { return $scope.sos = $scope[endorsement] ? 0 : null; },
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
        }

    ]);