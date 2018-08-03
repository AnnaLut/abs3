angular.module('BarsWeb.Controllers', ['kendo.directives'])
    .factory('transport', function () {
        return {
            backReasonModel: {
                id: "",
                viza: "",
                reasonType: "",
                comment: ""
            },
            backBuyWindow: {},
            btnBackRequestOption: {},
            gridBuy: {}
        };
    })
    .controller('Zay.DealerCtrl', [
        '$scope', '$http', 'transport', function ($scope, $http, transport) {
        
            // Buy:
            // gridBuy reload condition:
            $scope.dkBuy = 1;
            $scope.gridBuyRefresh = function () {
                $scope.dkBuy = $scope.dkBuy === 1 ? 3 : 1;
                $scope.gridBuy.dataSource.read();
            };

            $scope.toolbarBuyOptions = {
                items: [
                    {
                        type: "button",
                        text: "Button",
                        template: "<button title='Повернути' class='k-button' ng-disabled='!btnBackRequest' ng-click='backRequest()'><i class='pf-icon pf-16 pf-delete'></i></button>"
                    },
                    {
                        template: "<button title='Зберегти зміни в базі даних' class='k-button' ng-disabled='!btnSave' ng-click='saveUpdatedData()'><i class='pf-icon pf-16 pf-save'></i></button>"
                    },
                    { type: "separator" },
                    {
                        template: "<button title='Курс дилера' class='k-button' ng-click='dilerRateDialog()'><i class='pf-icon pf-16 pf-currency_conversion'></i></button>"
                    },
                    {
                        template: "<button title='Просмотр курсов дилера (архив)' class='k-button' ng-click='currencyRateArchiveDialog()'><i class='pf-icon pf-16 pf-help'></i></button>"
                    },
                    { type: "separator" },
                    {
                        type: "button",
                        text: "За валюту",
                        togglable: true,
                        toggle: $scope.gridBuyRefresh
                    }
                ]
            }

            $scope.gridBuyDataSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: "application/json",
                        url: bars.config.urlContent("/api/zayBuy/zay/dealerbuy/get"),
                        data: {
                            dk: function () {
                                return $scope.dkBuy;
                            }
                        }
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
                            PRIORVERIFY_VIZA: { type: "number", editable: false },
                            CLOSE_TYPE: { type: "number", editable: true  },
                            CLOSE_TYPE_NAME: { type: "string", editable: true },
                            STATE: { type: "string", editable: false },
                            START_TIME: { type: "date", editable: false },
                            REQ_TYPE: { type: "number", editable: false },
                            VDATE_PLAN: { type: "date", editable: false },

                            S2_EQV: { type: "number", editable: false }
                        }
                    }
                },
                pageSize: 10
            });

            $scope.gridBuyOptions = {
                dataSource: $scope.gridBuyDataSource,
                sortable: true,
                selectable: "row",
                editable: true,
                pageable: {
                    //refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                columns: [
                    {
                        field: "ID",
                        title: "№ заявки",
                        width: 100
                    },
                    {
                        field: "MFO",
                        title: "МФО",
                        width: 100
                    },
                    {
                        field: "MFO_NAME",
                        title: "Наименование",
                        width: 300
                    },
                    {
                        field: "REQ_ID",
                        title: "№ заявки<br/>РУ",
                        width: 100
                    },
                    {
                        field: "KV2",
                        title: "Код<br/>ВАЛ",
                        width: 100
                    },
                    {
                        field: "FDAT",
                        title: "Дата<br/>заявки",
                        template: "<div>#=kendo.toString(kendo.parseDate(FDAT),'dd/MM/yyyy')#</div>",
                        width: 100
                    },
                    {
                        field: "KURS_Z",
                        title: "Курс<br/>заявки",
                        width: 100
                    },
                    {
                        field: "KURS_F",
                        title: "Курс<br/>дилера",
                        width: 100
                    },
                    {
                        field: "SOS_DECODED", 
                        title: "Отм",
                        template: "<div style='text-align:center'>" +
                            "<input name='SOS_DECODED' type='checkbox' ng-click='change($event)' data-bind='checked: SOS_DECODED' #= KURS_F !== null || VDATE !== null ? checked='checked' : '' #/>" +
                            "</div>", 
                        width: 50
                    },
                    {
                        field: "VDATE",
                        title: "Дата<br/>валюти-<br/>рования",
                        template: "<div>#=kendo.toString(kendo.parseDate(VDATE),'dd/MM/yyyy') === null ? '-' : kendo.toString(kendo.parseDate(VDATE),'dd/MM/yyyy')#</div>",
                        width: 100
                    },
                    {
                        field: "VDATE_PLAN",
                        title: "Плановая<br/>дата<br/>валютир.",
                        template: "<div>#=kendo.toString(kendo.parseDate(VDATE_PLAN),'dd/MM/yyyy') === null ? '-' : kendo.toString(kendo.parseDate(VDATE_PLAN),'dd/MM/yyyy')#</div>",
                        width: 100
                    },
                    {
                        field: "S2",
                        title: "Сумма<br/>ВАЛ<br/>ПОКУПКИ",
                        template: "<div style='text-align: right;'>#=(S2/100).toFixed(2)#</div>",
                        width: 100
                    },
                    {
                        field: "S2_EQV", 
                        title: "Эквивалент<br/>суммы<br/>ПОКУПКИ<br/>(по курсу<br/>дилера)",
                        template: "<div style='text-align: right;'>#=(S2*KURS_F/100).toFixed(2)#</div>",
                        width: 100
                    },
                    {
                        field: "DATZ",
                        title: "Дата<br/>зачисления<br/>ВАЛЮТЫ",
                        template: "<div>#=kendo.toString(kendo.parseDate(DATZ),'dd/MM/yyyy') === null ? '-' : kendo.toString(kendo.parseDate(DATZ),'dd/MM/yyyy')#</div>",
                        width: 100
                    },
                    {
                        field: "PRIORITY",
                        title: "Прио-<br/>ритет<br/>заявки",
                        width: 75
                    },
                    {
                        field: "RNK",
                        title: "Рег.№<br/>клиента",
                        width: 100
                    },
                    {
                        field: "NMK",
                        title: "Клиент-<br/>ПОКУПАТЕЛЬ",
                        width: 100
                    },
                    {
                        field: "CUST_BRANCH",
                        title: "Отделение<br/>Клиента-<br/>ПОКУПАТЕЛЯ",
                        width: 200
                    },
                    {
                        field: "AIM_NAME",
                        title: "Цель<br/>покупки",
                        width: 150
                    },
                    {
                        field: "COMM",
                        title: "Коментарий",
                        width: 400
                    },
                    {
                        field: "KURS_KL",
                        title: "Курс<br/>клиента<br/>(первонач.)",
                        width: 200
                    },
                    {
                        field: "CLOSE_TYPE",
                        title: "Тип<br/>закрытия<br/>заявки",
                        width: 200,
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
                    {
                        field: "STATE",
                        title: "Состояние<br/>заявки",
                        width: 200
                    },
                    {
                        field: "START_TIME",
                        title: "Время<br/>поступления<br/>заявки",
                        template: "<div>#=kendo.toString(kendo.parseDate(START_TIME),'dd/MM/yyyy')#</div>",
                        width: 100
                    },
                    {
                        field: "REQ_TYPE",
                        title: "Наименование<br/>типа<br/>заявки",
                        width: 100
                    }
                ],
                dataBound: function (data) {
                    $scope.btnBackRequest = false;
                    //$scope.btnSave = false;
                   
                    $scope.gridBuy.tbody.find('>tr').each(function () {
                        var dataItem = $scope.gridBuy.dataItem(this);
                        if (dataItem.KURS_F >= 0 && dataItem.VDATE !== null && dataItem.CLOSE_TYPE === null) {
                            $(this).addClass('danger');
                        }
                    });
                }
            };

            //grid event hendler:
            $scope.handleChange = function (data, dataItem, columns, kendoEvent) {
                $scope.btnBackRequest = true;
                //debugger;
                $scope.data = data;
                $scope.columns = columns;
                $scope.dataItem = dataItem;
                $scope.sender = kendoEvent.sender;

                if (data.SOS_DECODED === 1)
                    $scope.btnSave = true;

                transport.backReasonModel = {
                    id: data.ID,
                    viza: data.VIZA,
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
                    close: function() {
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
            
            
            // set dealer data:
            $scope.forUpdateData = [];
            $scope.change = function (e) {
               
                var element = $(e.currentTarget);

                var checked = element.is(':checked'),
                    row = element.closest('tr'),
                    grid = $scope.gridBuy,
                    dataItem = grid.dataItem(row);
              
                if (checked) {
                    dataItem.set("SOS", glDilViza === 1 ? 0.5 : 1);
                    dataItem.set("VDATE", dataItem.FDAT < Date.parse(glBankDate) ? glBankDate : dataItem.FDAT);
                    dataItem.set("KURS_F", dataItem.KURS_F === null ? dataItem.KURS_Z : null);

                    $scope.forUpdateData.push(dataItem);

                    $scope.btnSave = true;
                } else {
                    dataItem.set("KURS_F", null);
                    dataItem.set("VDATE", null);

                    for (var i = $scope.forUpdateData.length; i--;) {
                        if ($scope.forUpdateData[i] === dataItem) {
                           
                            $scope.forUpdateData.splice(i, 1);
                        }
                    }
                   
                    $scope.btnSave = $scope.forUpdateData.length > 0 ? true : false;
                }
            };

            $scope.closeTypesValidation = function(array) {
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
            $scope.clearDataFunc = function() {
                $scope.forUpdateData = [];
                $scope.btnSave = false;
                $scope.btnBackRequest = false;
            };

            // update dealer data: 
            $scope.saveUpdatedData = function () {
               
                if ($scope.forUpdateData && $scope.closeTypesValidation($scope.forUpdateData)) {
                    console.log($scope.forUpdateData);

                    var arrData = [];
                    for (var i = 0; i < $scope.forUpdateData.length; i++) {
                        arrData.push({
                            Id: $scope.forUpdateData[i].ID,
                            KursF: $scope.forUpdateData[i].KURS_F,
                            Sos: $scope.forUpdateData[i].SOS,
                            Vdate: $scope.forUpdateData[i].VDATE,
                            CloseType: $scope.forUpdateData[i].CLOSE_TYPE,
                            Fdat: $scope.forUpdateData[i].FDAT
                        });
                    }
                   

                    var update = $http.post(bars.config.urlContent("/api/zay/updatedata/post"), JSON.stringify(arrData));
                    update.success(function(data) {

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
                            // clear update data array:
                            $scope.clearDataFunc();
                        } else {
                            bars.ui.alert({
                                text: 'Зміни збережено: ' + $scope.successResults.length + '.<br/>'
                            });
                            $scope.gridBuy.dataSource.read();
                            // clear update data array:
                            $scope.clearDataFunc();
                        }
                    });
                } else {
                    bars.ui.error({ text: 'Перевірте чи задано значення закриття заявки!' });
                }
            };
            
            // Diler rate functions:
            $scope.rateWindow;
            
            $scope.dilerRateDialog = function() {
                $scope.dilerRateWindowOptions = {
                    title: 'Встановлення курсів валюти',
                    width: 360,
                    //height: 350,
                    visible: false,                    
                    resizable: false,
                    actions: ['Close'],
                    close: function() {
                       
                    }        
                };
                
                $scope.rateWindow.setOptions($scope.dilerRateWindowOptions);
                $scope.rateWindow.center();
                $scope.rateWindow.open();
            };

            // currency rate archive:
            $scope.currencyRateArchiveWindow;
            $scope.currencyRateArchiveDialog = function () {

                // todo: have some troubles with window.....

                /*$scope.currencyRateArchiveWindowOptions = {
                    title: 'Просмотр курсов валют, установленных ДИЛЕРОМ',
                    width: 600,
                    //height: 350,
                    visible: false,
                    resizable: false,
                    actions: ['Close'],
                    close: function () {
                       
                    }
                };*/
                //$scope.currencyRateArchiveWindow.setOptions($scope.currencyRateArchiveDialog);
                $scope.currencyRateArchiveWindow.center();
                $scope.currencyRateArchiveWindow.open();
                //alert("dasdsadasdsa");
            };

            // Sale:
            // gridSale reload condition:
            $scope.dkSale = 2;
            $scope.gridSaleRefresh = function () {
                $scope.dkSale = $scope.dkSale === 2 ? 4 : 2;
                $scope.gridSale.dataSource.read();
            };

            $scope.toolbarSaleOptions = {
                items: [
                    { type: "separator" },
                    {
                        type: "button",
                        text: "За валюту",
                        togglable: true,
                        toggle: $scope.gridSaleRefresh
                    }
                ]
            }

            $scope.gridSaleDataSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: "application/json",
                        url: bars.config.urlContent("/api/zaySale/zay/dealersale/get"),
                        data: {
                            dk: function () {
                                return $scope.dkSale;
                            }
                        }
                    }
                },
                schema: {
                    data: 'Data',
                    total: 'Total',
                    model: {
                        fields: {
                            ID: { type: "number" },
                            MFO: { type: "string" },
                            MFO_NAME: { type: "string" },
                            REQ_ID: { type: "number" },
                            DK: { type: "number" },
                            SOS: { type: "number" },
                            SOS_DECODED: { type: "number" },
                            KV2: { type: "number" },
                            LCV: { type: "string" },
                            DIG: { type: "number" },
                            KV_CONV: { type: "number"},
                            FDAT: { type: "date" },
                            KURS_Z: { type: "number" },
                            VDATE: { type: "date" },
                            KURS_F: { type: "number" },
                            S2: { type: "number" },
                            VIZA: { type: "number" },
                            DATZ: { type: "date" },
                            RNK: { type: "number" },
                            NMK: { type: "string" },
                            CUST_BRANCH: { type: "string" },
                            PRIORITY: { type: "number" },
                            PRIORNAME: { type: "string" },
                            AIM_NAME: { type: "string" },
                            COMM: { type: "string" },
                            KURS_KL: { type: "string" },
                            PRIORVERIFY_VIZA: { type: "number" },
                            CLOSE_TYPE: { type: "number" },
                            CLOSE_TYPE_NAME: { type: "string" },
                            STATE: { type: "string" },
                            START_TIME: { type: "date" },
                            REQ_TYPE: { type: "number" },
                            VDATE_PLAN: { type: "date" }
                        }
                    }
                },
                pageSize: 10
            });

            $scope.gridSaleOptions = {
                dataSource: $scope.gridSaleDataSource,
                sortable: true,
                selectable: "row",
                pageable: {
                    //refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                columns: [
                    {
                        field: "ID",
                        title: "№ заявки",
                        width: 100
                    },
                    {
                        field: "MFO",
                        title: "МФО",
                        width: 100
                    },
                    {
                        field: "MFO_NAME",
                        title: "Наименование",
                        width: 300
                    },
                    {
                        field: "REQ_ID",
                        title: "№ заявки<br/>РУ",
                        width: 100
                    },
                    {
                        field: "KV2",
                        title: "Код<br/>ВАЛ",
                        width: 100
                    },
                    {
                        field: "KV_CONV",
                        title: "ЗА<br/>ВАЛ",
                        width: 100
                    },
                    {
                        field: "OBZ",
                        title: "ОБЗ",
                        width: 100
                    },
                    {
                        field: "FDAT",
                        title: "Дата<br/>заявки",
                        template: "<div>#=kendo.toString(kendo.parseDate(FDAT),'dd/MM/yyyy')#</div>",
                        width: 100
                    },
                    {
                        field: "KURS_Z",
                        title: "Курс<br/>заявки",
                        width: 100
                    },
                    {
                        field: "KURS_F",
                        title: "Курс<br/>дилера",
                        width: 100
                    },
                    {
                        field: "SOS",
                        title: "Отм",
                        width: 100
                    },
                    {
                        field: "VDATE",
                        title: "Дата<br/>валюти-<br/>рования",
                        template: "<div>#=kendo.toString(kendo.parseDate(VDATE),'dd/MM/yyyy') === null ? '-' : kendo.toString(kendo.parseDate(VDATE),'dd/MM/yyyy')#</div>",
                        width: 100
                    },
                    {
                        field: "S2",
                        title: "Сумма<br/>ВАЛ<br/>на ПРОДАЖУ",
                        template: "<div style='text-align: right;'>#=(S2/100).toFixed(2)#</div>",
                        width: 100
                    },
                    {
                        field: "S2_EQV",
                        title: "ГРН Эквивалент<br/>суммы<br/>ПРОДАЖИ<br/>(по курсу<br/>дилера)",
                        template: "<div style='text-align: right;'>#=(S2*KURS_F/100).toFixed(2)#</div>",
                        width: 100
                    },
                    {
                        field: "DATZ",
                        title: "Дата<br/>зачисления<br/>ГРИВНЫ",
                        template: "<div>#=kendo.toString(kendo.parseDate(DATZ),'dd/MM/yyyy')#</div>",
                        width: 100
                    },
                    {
                        field: "PRIORITY",
                        title: "Прио-<br/>ритетзаявки",
                        width: 100
                    },
                    {
                        field: "RNK",
                        title: "Рег.№<br/>клиента",
                        width: 100
                    },
                    {
                        field: "NMK",
                        title: "Клиент-<br/>ПРОДАВЕЦ",
                        width: 100
                    },
                    {
                        field: "CUST_BRANCH",
                        title: "Отделение<br/>Клиента-<br/>ПРОДАВЦА",
                        width: 200
                    },
                    {
                        field: "AIM_NAME",
                        title: "Цель<br/>продажи",
                        width: 100
                    },
                    {
                        field: "COMM",
                        title: "Коментарий",
                        width: 350
                    },
                    {
                        field: "KURS_KL",
                        title: "Курс<br/>клиента<br/>(первонач.)",
                        width: 200
                    },
                    {
                        field: "CLOSE_TYPE",
                        title: "Тип<br/>закрытия<br/>заявки",
                        width: 100
                    },
                    {
                        field: "STATE",
                        title: "Состояние<br/>заявки",
                        width: 200
                    },
                    {
                        field: "START_TIME",
                        title: "Время<br/>поступления<br/>заявки",
                        template: "<div>#=kendo.toString(kendo.parseDate(START_TIME),'dd/MM/yyyy')#</div>",
                        width: 100
                    },
                    {
                        field: "REQ_TYPE",
                        title: "Наименование<br/>типа<br/>заявки",
                        width: 100
                    }
                ]
            };
        }])
.controller('Zay.ReasonCtrl', [
        '$scope', '$http', 'transport',
        function ($scope, $http, transport) {

            $scope.transport = transport;

            $scope.backRequest = function (reason) {

               
                var item = {
                    Mode: reason.viza,
                    Id: reason.id,
                    IdBack: reason.reasonType,
                    Comment: reason.comment
                };

                var backRequestHttp = $http.post(bars.config.urlContent("/api/zay/backrequest/post"), JSON.stringify(item));
                backRequestHttp.success(function (data) {

                    if (data.Status === "Ok") {
                        bars.ui.alert({
                            text: 'Заявка: ' + reason.id + '.<br/>' +
                                data.Message
                        });
                    } else {
                        bars.ui.error({
                            text: 'Заявка: ' + reason.id + '.<br/>' +
                                data.Message
                        });
                    }
                    
                    transport.btnBackRequestOption = false;
                    transport.backBuyWindow.close();
                });
            };

            $scope.reasonsDataSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: "application/json",
                        url: bars.config.urlContent("/api/zay/reason/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            });

            $scope.reasonsOptions = {
                dataSource: $scope.reasonsDataSource,
                dataTextField: "REASON",
                dataValueField: "ID"
            };
        }])
.controller('Zay.RateCtrl', ['$scope', '$http', function($scope, $http) {
    
    $scope.currencyDictionary = new kendo.data.DataSource({
        transport: {
            read: {
                
            }
        }
    });
}]);