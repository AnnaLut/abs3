angular.module('BarsWeb.Controllers', ["kendo.directives"])
    .factory('transport', function () {
        return {
            backReasonModel: {},
            backBuyWindow: {},
            btnBackRequestOption: {},
            activeTabGrid: null
        };
    })
    .controller('Zay.ConfirmPrimaryCtrl', [
        '$scope', '$http', 'transport',
        function ($scope, $http, transport) {

            $scope.transport = transport;

            // grid reload condition:
            $scope.dk = 1;
            $scope.gridRefresh = function () {
                $scope.dk = $scope.dk === 1 ? 3 : 1;
                //alert($scope.dk);
                $scope.buyGrid.dataSource.read();
            };

            /* --- tabstip ---*/
            /*$scope._tabstripOptions = {
                activate: function (e) {
                    e.item.innerText === "Заявки на покупку" ?
                    (function () {

                        transport.activeTabGrid = $scope.buyGrid;
                        $scope.buyGridOptions.dataSource.read();
                    })() : (function () {
                        transport.activeTabGrid = $scope.saleGrid;
                        $scope.saleGridOptions.dataSource.read();
                    })();
                }
            };*/

            // Buy Toolbar:
            $scope.buyToolbarOptions = {
                items: [
                    {
                        template: "<button title='Повернути з візування' class='k-button' ng-disabled='!btnBackRequest' ng-click='backRequest()'><i class='pf-icon pf-16 pf-delete'></i></button>"
                    },
                    {
                        template: "<button title='Завізувати' class='k-button' ng-click='setVisa()'><i class='pf-icon pf-16 pf-save'></i></button>"
                    },
                    { type: "separator" },
                    {
                        type: "button",
                        id: "currencyUse",
                        text: "За валюту",
                        togglable: true,
                        toggle: $scope.gridRefresh
                    }
                ]
            };

            // вікно повернення з візування:
            $scope.window;
            $scope.backRequest = function () {

                $scope.DlgOptions = {
                    title: "Повернення заявки з візування",
                    width: 600,
                    visible: false,
                    resizable: false,
                    actions: ["Close"],
                    close: function () {
                        $scope.btnBackRequest = false;
                        $scope.buyGrid.dataSource.read();
                    }
                };

                // to close window from Zay.ReasonCtrl:
                transport.backBuyWindow = $scope.window;

                $scope.window.setOptions($scope.DlgOptions);
                $scope.window.center();
                $scope.window.open();
            };

            // visa
            $scope.checkedIds = [];
            $scope.chkArr = [];
            $scope.visaModel = function (arr) {
                return {
                    Id: arr.ID,
                    Viza: 2,//arr.DK,
                    Priority: arr.PRIORITY,
                    AimsCode: arr.AIMS_CODE ? arr.AIMS_CODE : null,
                    SupDoc: null
                };
            }
            $scope.onClick = function (e) {
               
                var element = $(e.currentTarget);
                var checked = element.is(':checked'),
                    row = element.closest('tr'),
                    grid = $scope.buyGrid,
                    dataItem = grid.dataItem(row);

                $scope.checkedIds[dataItem.ID] = checked;

                if (checked) {
                    $scope.chkArr.push(dataItem.ID);
                } else {
                    var index = $scope.chkArr.indexOf(dataItem.ID);
                    if (index > -1) {
                        $scope.chkArr.splice(index, 1);
                    }
                }
                
                if (checked) {
                    row.addClass("k-state-selected");
                } else {
                    row.removeClass("k-state-selected");
                }
            };


            function sendVisaRequest(checked) {
                var visaRequest = $http.post(bars.config.urlContent("/api/zay/setvisa/post"), JSON.stringify(checked));
                visaRequest.success(function (data) {

                    $scope.data = data;
                    $scope.successResults = [];
                    $scope.errorResults = [];

                    for (var j = 0; j < $scope.data.length; j++) {
                        $scope.data[j].Status === 1 ? $scope.successResults.push($scope.data[j]) : $scope.errorResults.push($scope.data[j]);
                    }
                    if ($scope.errorResults.length > 0) {
                        bars.ui.alert({
                            text: 'Завізовано: ' + $scope.successResults.length + '.<br/>' +
                                'Не завізовано: ' + $scope.errorResults.length + '.<br/>'
                        });
                        transport.activeTabGrid.dataSource.read();
                    } else {
                        bars.ui.alert({
                            text: 'Завізовано: ' + $scope.successResults.length + '.<br/>'
                        });
                        transport.activeTabGrid.dataSource.read();
                    }
                });
            }

            $scope.setVisa = function () {
               

                transport.activeTabGrid = $scope.buyGrid;

                var checked = [];
                var arrErr = [];
                var visaArr = $scope.buyGrid._data;
                if ($scope.chkArr.length > 0) {
                    for (var i in $scope.chkArr) {
                       
                        if ($scope.chkArr[parseInt(i)]) {
                            for (var a = 0; a < visaArr.length; a++) {
                                // check if ZAY2 past successed:
                                var sos = visaArr[a].SOS === 0 && visaArr[a].VIZA === 1 ? true : false;

                                if ($scope.chkArr[parseInt(i)] === visaArr[a].ID && sos) {
                                    checked.push($scope.visaModel(visaArr[a]));
                                    //console.log(checked);
                                } else if ($scope.chkArr[parseInt(i)] === visaArr[a].ID && !sos) {
                                    arrErr.push($scope.visaModel(visaArr[a]));
                                }
                            }
                        }
                    }
                   
                    if (arrErr.length > 0 && checked.length > 0) {
                        bars.ui.confirm({
                            text: "У переліку заявок на візування є ті, що мають стан \"Незавізовано валютним контролем\" (кіл-ть: " + arrErr.length + ")!<br/>Відповідні " +
                                "заявки не будуть завізовані, бажаєте продовжити?"
                        }, function () {
                            sendVisaRequest(checked);
                        });
                        transport.activeTabGrid.dataSource.read();
                    } else if (arrErr.length > 0 && checked.length === 0) {
                        bars.ui.error({ text: 'Неможливо завізувати заявки, що не завізовані валютним контролем!' });
                        transport.activeTabGrid.dataSource.read();
                    } else {
                        sendVisaRequest(checked);
                    }
                } else {
                    bars.ui.error({ text: 'Не обрано зявки на візування!<br/>Операція візування не можлива.' });
                }
            };

            // Buy Grid:
            $scope.buyGridOptions = {
                filterable: true,
                dataSource: {
                    type: 'aspnetmvc-ajax',
                    transport: {
                        read: {
                            type: "GET",
                            dataType: 'json',
                            contentType: "application/json",
                            url: bars.config.urlContent("/api/zayBuy/zay/confirmprimarybuy/GetConfirmPrimaryBuyDataList"),
                            data: {
                                requestType: function () {
                                    return $scope.dk;
                                }
                            }
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        model: {
                            fields: {
                                DK: { type: "number" },
                                ID: { type: "number" },
                                RNK: { type: "number" },
                                NMK: { type: "string" },
                                CUST_BRANCH: { type: "string" },
                                FDAT: { type: "date" },
                                KV2: { type: "number" },
                                LCV: { type: "string" },
                                DIG: { type: "number" },
                                KURS_Z: { type: "number" },
                                S2: { type: "number" },
                                PRIORITY: { type: "number" },
                                PRIORNAME: { type: "string" },
                                KV_CONV: { type: "number" },
                                REQ_TYPE: { type: "number" },
                                CODE_2C: { type: "string" },
                                P12_2C: { type: "string" },
                                VIZA: { type: "number" }
                            }
                        }
                    },
                    serverFiltering: true,
                    pageSize: 20
                },
                //height: 550,
                //groupable: true,
                sortable: true,
                selectable: "row",
                pageable: {
                    //refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                columns: [
                    {
                        template: "<input type='checkbox' class='checkbox' ng-click='onClick($event)' />",
                        field: "VISA",
                        title: "VISA",
                        width: 50
                    },
                    {
                        field: "KV2",
                        title: "Код<br/>валюти",
                        width: 50,
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    }, {
                        field: "KV_CONV",
                        title: "За<br/>валюту",
                        width: 50,
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    }, {
                        field: "ID",
                        title: "Номер<br/>заявки",
                        width: 75,
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    }, {
                        field: "NMK",
                        title: "Клієнт",
                        width: 150
                    }, {
                        field: "CUST_BRANCH",
                        title: "Відділення<br/>клієнта",
                        width: 150
                    }, {
                        field: "PRIORITY",
                        title: "Приоритет<br/>заявки",
                        width: 75
                    }, {
                        field: "S2",
                        title: "Сума<br/>покупки ВАЛ",
                        template: "<div style='text-align: right;'>#=(S2/100).toFixed(2)#</div>",
                        format: "{0:n2}",
                        width: 100
                    }, {
                        field: "KURS_Z",
                        title: "Курс<br/>покупки",
                        width: 75
                    }, {
                        field: "FDAT",
                        title: "Дата<br/>заявки",
                        width: 100,
                        template: "<div>#=kendo.toString(kendo.parseDate(FDAT),'dd/MM/yyyy')#</div>"
                    }, {
                        field: "REQ_TYPE",
                        title: "Назва<br/>типу заявки",
                        width: 100
                    }
                ],
                dataBound: function () {
                    $scope.btnBackRequest = false;
                }
            };

           

            // івент для роботи з формою повернення заявки:
            $scope.handleChange = function (data, dataItem, columns, kendoEvent) {
                $scope.btnBackRequest = true;
                // 
                $scope.data = data;
                $scope.columns = columns;
                $scope.dataItem = dataItem;
                $scope.sender = kendoEvent.sender;

                transport.backReasonModel = {
                    id: data.ID,
                    viza: data.VIZA,
                    reasonType: "",
                    comment: ""
                };

                transport.btnBackRequestOption = $scope.btnBackRequest;
            };

            // ******* Sale ***
            $scope.chkArrSale = [];
            $scope.onClickSale = function (e) {

                var element = $(e.currentTarget);
                var checked = element.is(':checked'),
                    row = element.closest('tr'),
                    grid = $scope.saleGrid,
                    dataItem = grid.dataItem(row);

                $scope.checkedIds[dataItem.ID] = checked;

                if (checked) {
                    $scope.chkArrSale.push(dataItem.ID);
                } else {
                    var index = $scope.chkArrSale.indexOf(dataItem.ID);
                    if (index > -1) {
                        $scope.chkArrSale.splice(index, 1);
                    }
                }

                if (checked) {
                    row.addClass("k-state-selected");
                } else {
                    row.removeClass("k-state-selected");
                }
            };
            $scope.setVisaSale = function () {

                transport.activeTabGrid = $scope.saleGrid;

                var checked = [];
                var arrErr = [];

                var visaArr = $scope.saleGrid._data;
                if ($scope.chkArrSale.length > 0) {
                    for (var i in $scope.chkArrSale) {
                       
                        if ($scope.chkArrSale[parseInt(i)]) {
                            for (var a = 0; a < visaArr.length; a++) {
                                // check if ZAY2 past successed:
                                var sos = visaArr[a].SOS === 0 && visaArr[a].VIZA === 1 ? true : false;

                                if ($scope.chkArrSale[parseInt(i)] === visaArr[a].ID && sos) {
                                    checked.push($scope.visaModel(visaArr[a]));
                                    //console.log(checked);
                                } else if ($scope.chkArrSale[parseInt(i)] === visaArr[a].ID && !sos) {
                                    arrErr.push($scope.visaModel(visaArr[a]));
                                }
                            }
                        }
                    }
                   
                    if (arrErr.length > 0 && checked.length > 0) {
                        bars.ui.confirm({
                            text: "У переліку заявок на візування є ті, що мають стан \"Незавізовано валютним контролем\" (кіл-ть: " + arrErr.length + ")!<br/>Відповідні " +
                                "заявки не будуть завізовані, бажаєте продовжити?"
                        }, function () {
                            sendVisaRequest(checked);
                        });
                        transport.activeTabGrid.dataSource.read();
                    } else if (arrErr.length > 0 && checked.length === 0) {
                        bars.ui.error({ text: 'Неможливо завізувати заявки, що не завізовані валютним контролем!' });
                        transport.activeTabGrid.dataSource.read();
                    } else {
                        sendVisaRequest(checked);
                    }
                } else {
                    bars.ui.error({ text: 'Не обрано зявки на візування!<br/>Операція візування не можлива.' });
                }
            };
            
            // grid reload condition:
            $scope.sDk = 2;
            $scope.gridSaleRefresh = function () {
                $scope.sDk = $scope.sDk === 2 ? 4 : 2;
                //alert($scope.dk);
                $scope.saleGrid.dataSource.read();
            };


            // Sale Toolbar:
            $scope.saleToolbarOptions = {
                items: [
                    {
                        type: "button",
                        text: "Button",
                        template: "<button title='Повернути з візування' class='k-button' ng-disabled='!btnBackRequest' ng-click='backRequest()'><i class='pf-icon pf-16 pf-delete'></i></button>"
                    },
                    {
                        type: "button",
                        text: "Button",
                        template: "<button title='Завізувати' class='k-button' ng-click='setVisaSale()'><i class='pf-icon pf-16 pf-save'></i></button>"
                    },
                    { type: "separator" },
                    {
                        type: "button",
                        id: "currencyUse",
                        text: "За валюту",
                        togglable: true,
                        toggle: $scope.gridSaleRefresh
                    }
                ]
            };
            $scope.saleGridOptions = {
                filterable: true,
                dataSource: {
                    type: 'aspnetmvc-ajax',
                    transport: {
                        read: {
                            type: "GET",
                            dataType: 'json',
                            contentType: "application/json",
                            url: bars.config.urlContent("/api/zaySale/zay/confirmprimarysale/get"),
                            data: {
                                requestType: function () {
                                    return $scope.sDk;
                                }
                            }
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        model: {
                            fields: {
                                DK: { type: "number" },
                                ID: { type: "number" },
                                RNK: { type: "number" },
                                NMK: { type: "string" },
                                CUST_BRANCH: { type: "string" },
                                FDAT: { type: "date" },
                                KV2: { type: "number" },
                                LCV: { type: "string" },
                                DIG: { type: "number" },
                                KURS_Z: { type: "number" },
                                S2: { type: "number" },
                                PRIORITY: { type: "number" },
                                PRIORNAME: { type: "string" },
                                REQ_TYPE: { type: "number" },
                                VIZA: { type: "number" }
                            }
                        }
                    },
                    serverFiltering: true,
                    pageSize: 20
                },
                //height: 550,
                //groupable: true,
                sortable: true,
                selectable: "row",
                pageable: {
                    //refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                columns: [
                    {
                        template: "<input type='checkbox' class='checkbox' ng-click='onClickSale($event)' />",
                        field: "VISA",
                        title: "VISA",
                        width: 50
                    },
                    {
                        field: "KV2",
                        title: "Код<br/>валюти",
                        width: 50,
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    }, {
                        field: "ID",
                        title: "Номер<br/>заявки",
                        width: 75,
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    }, {
                        field: "NMK",
                        title: "Клієнт",
                        width: 100
                    }, {
                        field: "CUST_BRANCH",
                        title: "Відділення<br/>клієнта",
                        width: 100
                    }, {
                        field: "PRIORITY",
                        title: "Приоритет<br/>заявки",
                        width: 75
                    }, {
                        field: "S2",
                        title: "Сума<br/>ВАЛ продажу",
                        template: "<div style='text-align: right;'>#=(S2/100).toFixed(2)#</div>",
                        format: "{0:n2}",
                        width: 75
                    }, {
                        field: "KURS_Z",
                        title: "Курс<br/>покупки",
                        width: 75
                    }, {
                        field: "FDAT",
                        title: "Дата<br/>заявки",
                        width: 100,
                        template: "<div>#=kendo.toString(kendo.parseDate(FDAT),'dd/MM/yyyy')#</div>"
                    }, {
                        field: "REQ_TYPE",
                        title: "Назва<br/>типу заявки",
                        width: 100
                    }
                ],
                dataBound: function () {
                    $scope.btnBackRequest = false;
                }
            };
        }
    ])
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
                    //$scope.buyGrid.dataSource.read();
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
    .directive('backRequest', function () {
        var directive = {};

        directive.restrict = 'EA'; /* restrict this directive to elements */
        directive.templateUrl = "~/Areas/Zay/Views/ConfirmPrimaryZay/htmlTpl/backRequest.html";

        return directive;
    });