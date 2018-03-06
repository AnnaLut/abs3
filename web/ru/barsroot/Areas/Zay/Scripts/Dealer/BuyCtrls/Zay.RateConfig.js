angular.module('BarsWeb.Controllers')
    .controller('Zay.RateConfig', [
        '$scope', '$http', 'transport', function ($scope, $http, transport) {

            $scope.rateType = 1;
            $scope.viewType = 1;
            $scope.kvCode = null;
            $scope.conType = 1;
            $scope.pair = {};
            $scope.pairData = "";
            $scope.newIndKurs = null;
            $scope.newFactKurs = null;

            $scope.transport = transport;

            transport.defRateConfig = function () {
                $scope.rateType = 1;
                $scope.viewType = 1;
                $scope.kvCode = null;
                $scope.conType = 1;
                $scope.pair = {};
                $scope.pairData = "";
                 
                $scope.rateComfigModel = {
                    kvCode: $scope.kvCode
                }
            }
            
            $scope.rateComfigModel = {
                rateType: $scope.rateType,
                viewType: $scope.viewType,
                kvCode:  $scope.kvCode,
                conType: $scope.conType,
                pairKursF: $scope.pair.kv_f,
                pairKursS: $scope.pair.kv_s,
                pairKvBase: $scope.pair.kv_base,
                indBuy: null,
                indSale: null,
                indBuyVip: null,
                indSaleVip: null,
                fBuy: null,
                fSale: null,
                blk: false,
                newIndKurs: null,
                newFactKurs: null
            };

            $scope.check = function (item) {
                 
                if (typeof item != 'undefined') {
                    return true;
                } else {
                    return false;
                }
            }

            $scope.submit = function (item) {
                 
                var model = {
                    rateType: $scope.rateType,
                    viewType: $scope.viewType,
                    kvCode: $scope.kvCode,
                    conType: $scope.conType,
                    pairKursF: $scope.check(item.pair /*|| $scope.rateComfigModel.pairKursF*/) ? item.pair.kv_f : null,
                    pairKursS: $scope.check(item.pair /*|| $scope.rateComfigModel.pairKursS*/) ? item.pair.kv_s : null,
                    pairKvBase: $scope.check(item.pair /*|| $scope.rateComfigModel.pairKvBase*/) ? item.pair.kv_base : null,
                    indBuy: item.indBuy,
                    indSale: item.indSale,
                    indBuyVip: item.indBuyVip,
                    indSaleVip: item.indSaleVip,
                    fBuy: item.fBuy,
                    fSale: item.fSale,
                    blk: item.blk,
                    newIndKurs: item.newIndKurs,
                    newFactKurs: item.newFactKurs
                }
                
                var rateConfigHttp = $http.post(bars.config.urlContent("/api/zay/dilerkurs/post"), JSON.stringify(model));
                rateConfigHttp.success(function (data) {

                     

                    if (data.ResultMsg)
                        (function () { return bars.ui.alert({ text: data.ResultMsg }); })();

                    if (data.Msg)
                        (function () { return bars.ui.error({ text: 'Курс валют не встановлено:<br/>' + data.Msg }); })();

                    $scope.rateConfigWindow.close();
                });
            };

            $scope.rateSwitcherOptions = {
                dataTextField: "text",
                dataValueField: "rateType",
                dataSource: [
                    { text: "Покупки-продажу", rateType: 1 },
                    { text: "Конверсії", rateType: 2 }
                ],
                select: function (e) {
                     
                    var dataItem = this.dataItem(e.item);
                    if (dataItem.rateType === 1) {
                        $scope.rateComfigModel.conType = 1;
                        $scope.pairData = "";
                        $scope.rateComfigModel.newIndKurs = null;
                        $scope.rateComfigModel.newFactKurs = null;
                    } else {
                        $scope.viewType = 1;
                        $scope.rateComfigModel.kvCode = null;
                        $scope.rateComfigModel.indBuy = null;
                        $scope.rateComfigModel.indSale = null;
                        $scope.rateComfigModel.indBuyVip = null;
                        $scope.rateComfigModel.indSaleVip = null;
                        $scope.rateComfigModel.sBuy = null;
                        $scope.rateComfigModel.sSale = null;
                        $scope.rateComfigModel.blk = false;
                    }
                },
                dataBound: function() {
                    $scope.rateComfigModel.kvCode = null;
                }
            };

            $scope.rateViewOptions = {
                dataTextField: "text",
                dataValueField: "viewType",
                dataSource: [
                    { text: "Індикативні курси", viewType: 1 },
                    { text: "Фактичні курси", viewType: 2 }
                ]
            };

            $scope.rateConverViewOptions = {
                dataTextField: "text",
                dataValueField: "conType",
                dataSource: [
                    { text: "Індикативні курси", conType: 1 },
                    { text: "Фактичні курси", conType: 2 }
                ],
                select: function (e) {
                     
                    var dataItem = this.dataItem(e.item);
                    if (dataItem.conType === 1) {
                        $scope.rateComfigModel.pairFactData = "";
                        $scope.rateComfigModel.newFactKurs = "";
                    } else {
                        $scope.rateComfigModel.pairIndData = "";
                        $scope.rateComfigModel.newIndKurs = "";
                    }
                }
            };

            // перевірка значень курсу згідно бДати
            $scope.checkDilerRate = function (id, kv) {

                var dataRequest =
                    {
                        id: id,
                        kv: kv
                    }

                var rateHttp = $http.post(bars.config.urlContent("/api/zay/checkdilerrate/post"), JSON.stringify(dataRequest));
                rateHttp.success(function (data) {

                     

                    if (data.Msg)
                        (function () { return bars.ui.error({ text: 'Помилка отримання даних курсу:<br/>' + data.Msg }); })();

                    if (id === 1) {
                        $scope.rateComfigModel.indBuy = data.kursB;
                        $scope.rateComfigModel.indSale = data.kursS;
                        $scope.rateComfigModel.indBuyVip = data.vipB;
                        $scope.rateComfigModel.indSaleVip = data.vipS;
                        $scope.rateComfigModel.blk = data.blk;
                        if (data.blk) {
                            $scope.rateComfigModel.blk = data.blk === 1 ? true : false;
                        } else {
                            $scope.rateComfigModel.blk = data.blk;
                        }
                    } else if (id === 2) {
                        $scope.rateComfigModel.fBuy = data.kursB;
                        $scope.rateComfigModel.fSale = data.kursS;
                    }
                });
            };
            // перевірка значень конверсії курсу згідно бДати
            $scope.checkDilerRateConversion= function(id, kvF, kvS) {
                var dataConversionRequest =
                    {
                        id: id,
                        kvF: kvF,
                        kvS: kvS
                    }
                var conversionRateHttp = $http.post(bars.config.urlContent("/api/zay/checkdilerconversionrate/post"), JSON.stringify(dataConversionRequest));
                conversionRateHttp.success(function(data) {
                     
                    if (data.Msg)
                        (function () { return bars.ui.error({ text: 'Помилка отримання даних курсу конверсії:<br/>' + data.Msg }); })();
                    if (id === 1) {
                        if (data.kurs !== 0)
                            $scope.rateComfigModel.newIndKurs = data.kurs;
                    } else if (id === 2) {
                        if (data.kurs !== 0)
                            $scope.rateComfigModel.newFactKurs = data.kurs;
                    }
                });
            };

            $scope.currenciesOptions = {
                dataTextField: "name",
                dataValueField: "kv",
                optionLabel: "-Значення валюти-",
                dataSource: {
                    type: 'webapi',
                    transport: {
                        read: {
                            type: "GET",
                            url: bars.config.urlContent('/api/zay/kurs/get/'),
                            dataType: 'json'
                        }
                    }
                },
                change: function(e) {
                     
                    var dataItem = this.dataItem(e.item);
                    $scope.kvCode = dataItem.kv;

                    $scope.checkDilerRate(parseInt($scope.viewType), dataItem.kv);

                     
                }
            };

            // rates peirs(matches) configurations:

            $scope.openCurrencyPairsWindow = function () {
                $scope.currencyPairsWindow.center().open();
            };

            $scope.pairsData = new kendo.data.DataSource({
                type: 'webapi',
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        url: bars.config.urlContent("/api/zay/currencypairs/get")
                    }
                },
                schema: {
                    data: function(result) {
                        return result.Data || (function() { return bars.ui.error({ text: 'Помилка отримання значень таблиці:<br/>' + result.Msg }); })();
                    },
                    total: function(result) {
                        return result.Total || result.length || 0;
                    },
                    model: {
                        fields: {
                            kv_f: { type: "number" },
                            kv_s: { type: "number" },
                            name_f: { type: "string" },
                            name_s: { type: "string" },
                            kv_base: { type: "number" }
                        }
                    }
                },
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true
            });

            $scope.gridCurrencyPairsOptions = {
                dataSource: $scope.pairsData,
                selectable: "row",
                pageable: {
                    refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                columns: [
                    {
                        field: "kv_f",
                        title: "Вал.1",
                        width: '15%'
                    },
                    {
                        field: "name_f",
                        title: "Назва валюти",
                        width: '35%'
                    },
                    {
                        field: "kv_s",
                        title: "Вал.2",
                        width: '15%'
                    },
                    {
                        field: "name_s",
                        title: "Назва валюти",
                        width: '35%'
                    }
                ],
                dataBound: function () {
                     
                    $scope.disableAddBtn = false;
                }
            };

            $scope.handleGridPairsChange = function (data, dataItem, columns, kendoEvent) {
                 
                $scope.disableAddBtn = true;

                // seed model:
                if (data)
                    $scope.rateComfigModel.pair = data;
            }

            $scope.toolbarCurrencyPairsOptions = {
                items: [
                    {
                        template: "<button title='Додати пару' class='k-button' ng-disabled='!disableAddBtn' ng-click='addPair()'><i class='pf-icon pf-16 pf-add'></i>Додати</button>"
                    }
                ]
            };

            $scope.addPair = function () {
                 
                var id = parseInt($scope.conType);
                $scope.checkDilerRateConversion(id, $scope.rateComfigModel.pair.kv_f, $scope.rateComfigModel.pair.kv_s);

                var str = $scope.rateComfigModel.pair.kv_f + "/" + $scope.rateComfigModel.pair.kv_s + "(базова валюта " + $scope.rateComfigModel.pair.kv_base + ")";
                if (id === 1) {
                    $scope.rateComfigModel.pairIndData = str;
                } else if (id === 2) {
                    $scope.rateComfigModel.pairFactData = str;
                }
                
                $scope.currencyPairsWindow.close();
            };


            /* end ctrl */
        }
    ]);