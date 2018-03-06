angular.module('BarsWeb.Controllers')
    .controller('Zay.RateCtrl', [
        '$scope', '$http', function($scope, $http) {

            $scope.value = 1;
            $scope.allKurs = 1;
            $scope.AllConversion = 1;

            $scope.showAll = function() {
                 
                if (parseInt($scope.value) === 1) {
                    $scope.allKurs = $scope.allKurs === 1 ? 0 : 1;
                    $scope.rateGrid.dataSource.read({ mode: function() { return $scope.allKurs; } });
                } else if (parseInt($scope.value) === 2) {
                    $scope.AllConversion = $scope.AllConversion === 1 ? 0 : 1;
                    $scope.conversionGrid.dataSource.read({ mode: function() { return $scope.AllConversion; } });
                }
            };

            $scope.refreshData = function() {
                if (parseInt($scope.value) === 1) {
                    $scope.rateGrid.dataSource.read({ mode: function() { return $scope.allKurs; } });
                } else if (parseInt($scope.value) === 2) {
                    $scope.conversionGrid.dataSource.read({ mode: function() { return $scope.AllConversion; } });
                }
            }

            // rate toolbar

            $scope.rateToolbarOptions = {
                items: [
                    {
                        template: "<button title='Поточні/За всі дні' class='k-button' ng-click='showAll()'><i class='pf-icon pf-16 pf-application-update'></i></button>"
                    },
                    {
                        template: "<button title='Перечитати записи таблиці' class='k-button' ng-click='refreshData()'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>"
                    },
                    { type: "separator" },
                    { template: "<label>Таблиця курсів:</label>" },
                    {
                        template: "<input kendo-drop-down-list k-options='formatOptions' ng-model='value' style='width: 200px;' />",
                        overflow: "never"
                    }
                ]
            };

            $scope.formatOptions = {
                dataTextField: "text",
                dataValueField: "value",
                dataSource: [
                    { text: "Покупки-продажу", value: 1 },
                    { text: "Конверсії", value: 2 }
                ]
            };


// rateGridOptions

            $scope.rateGridOptions = {
                selectable: 'row',
                filterable: true,
                sortable: true,
                //groupable: true,
                pageable: {
                    refresh: true,
                    buttonCount: 3
                },
                dataSource: new kendo.data.DataSource({
                    type: 'webapi',
                    transport: {
                        read: {
                            type: "GET",
                            url: bars.config.urlContent('/api/zay/dilerkurs/get/'),
                            dataType: 'json',
                            data: { mode: function() { return $scope.allKurs; } }
                        }
                    },
                    schema: {
                        data: function(result) {
                            return result.Data || (function() { return bars.ui.error({ text: 'Помилка отримання значень курсів дилера:<br/>' + result.Msg }); })();
                        },
                        total: function(result) {
                            return result.Total || result.length || 0;
                        },
                        model: {
                            fields: {
                                type: { type: "string" },
                                dat: { type: "date" },
                                kv: { type: "number" },
                                id: { type: "number" },
                                kurs_b: { type: "number" },
                                kurs_s: { type: "number" },
                                vip_b: { type: "number" },
                                vip_s: { type: "number" },
                                fio: { type: "string" },
                                name: { type: "string" },
                                blk: { type: "number" }
                            }
                        }
                    },
                    pageSize: 5,
                    serverPaging: true,
                    serverSorting: true,
                    serverFiltering: true,
                    pageable: true,
                    sortable: true
                }),
                columns: [
                    {
                        field: 'type',
                        title: 'Назва<br/>курсу',
                        width: 120
                    },
                    {
                        field: 'name',
                        title: 'Назва<br/>валюти',
                        width: 120
                    },
                    {
                        field: 'kv',
                        title: 'Код<br/>валюти',
                        width: 120,
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    },
                    {
                        field: 'dat',
                        title: 'Дата<br/>встановлення',
                        template: "<div>#=kendo.toString(kendo.parseDate(dat),'dd/MM/yyyy')#</div>",
                        width: 150
                    },
                    {
                        field: 'blk',
                        title: 'Флаг<br/>блок.',
                        template: "<div style='text-align:center'>" +
                            "<input name='blk' type='checkbox' disabled='disabled' data-bind='checked: blk' #= blk !== 0 ? checked='checked' : '' #/>" +
                            "</div>",
                        width: 50,
                        filterable: false
                    },
                    {
                        field: 'kurs_b',
                        title: 'Курс<br/>покупки',
                        attributes: { 'class': "text-right" },
                        width: 120,
                        filterable: {
                            cell: {
                                //showOperators: false,
                                template: function(args) {
                                    args.element.kendoNumericTextBox({
                                        spinners: false
                                    });
                                }
                            }
                        }
                    },
                    {
                        field: 'kurs_s',
                        title: 'Курс<br/>продажу',
                        attributes: { 'class': "text-right" },
                        width: 120,
                        filterable: {
                            cell: {
                                template: function(args) {
                                    args.element.kendoNumericTextBox({
                                        spinners: false
                                    });
                                }
                            }
                        }
                    },
                    {
                        field: 'vip_b',
                        title: 'VIP. Курс<br/>покупки',
                        attributes: { 'class': "text-right" },
                        width: 120,
                        filterable: {
                            cell: {
                                template: function(args) {
                                    args.element.kendoNumericTextBox({
                                        spinners: false
                                    });
                                }
                            }
                        }
                    },
                    {
                        field: 'vip_s',
                        title: 'VIP. Курс<br/>продажу',
                        attributes: { 'class': "text-right" },
                        width: 120,
                        filterable: {
                            cell: {
                                template: function(args) {
                                    args.element.kendoNumericTextBox({
                                        spinners: false
                                    });
                                }
                            }
                        }
                    },
                    {
                        field: 'fio',
                        title: 'Користувач',
                        width: 150
                    }
                ]
            };


// conversionGridOptions

            $scope.conversionGridOptions = {
                selectable: 'row',
                filterable: {
                    mode: "row"
                },
                sortable: true,
                pageable: {
                    refresh: true,
                    buttonCount: 3
                },
                dataSource: new kendo.data.DataSource({
                    type: 'webapi',
                    transport: {
                        read: {
                            type: 'GET',
                            url: bars.config.urlContent('/api/zay/dilerkursconversion/get/'),
                            dataType: 'json',
                            data: { mode: function() { return $scope.AllConversion; } }
                        }
                    },
                    schema: {
                        data: function(result) {
                            return result.Data || (function() { return bars.ui.error({ text: 'Помилка отримання значень курсів конверсії:<br/>' + result.Msg }); })();
                        },
                        total: function(result) {
                            return result.Total || result.length || 0;
                        },
                        model: {
                            fields: {
                                kv1: { type: "number" },
                                kv2: { type: "number" },
                                dat: { type: "date" },
                                kurs_i: { type: "number" },
                                kurs_f: { type: "number" }
                            }
                        }
                    },
                    pageSize: 10,
                    serverPaging: true,
                    serverSorting: true,
                    serverFiltering: true,
                    pageable: true,
                    sortable: true
                }),
                columns: [
                    {
                        field: 'kv1',
                        title: 'Код валюти',
                        filterable: {
                            cell: {
                                template: function(args) {
                                    args.element.kendoNumericTextBox({
                                        spinners: false
                                    });
                                }
                            }
                        }
                    },
                    {
                        field: 'kv2',
                        title: 'Код валюти 2',
                        filterable: {
                            cell: {
                                template: function(args) {
                                    args.element.kendoNumericTextBox({
                                        spinners: false
                                    });
                                }
                            }
                        }
                    },
                    {
                        field: 'dat',
                        title: 'Дата встановлення',
                        template: "<div>#=kendo.toString(kendo.parseDate(dat),'dd/MM/yyyy')#</div>"
                    },
                    {
                        field: 'kurs_i',
                        title: 'Індикативний курс',
                        attributes: { 'class': "text-right" },
                        filterable: {
                            cell: {
                                template: function(args) {
                                    args.element.kendoNumericTextBox({
                                        spinners: false
                                    });
                                }
                            }
                        }
                    },
                    {
                        field: 'kurs_f',
                        title: 'Фактичний курс',
                        attributes: { 'class': "text-right" },
                        filterable: {
                            cell: {
                                template: function(args) {
                                    args.element.kendoNumericTextBox({
                                        spinners: false
                                    });
                                }
                            }
                        }
                    }
                ]
            };
        }
    ]);