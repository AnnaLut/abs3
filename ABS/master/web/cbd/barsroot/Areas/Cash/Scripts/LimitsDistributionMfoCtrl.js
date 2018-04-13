angular.module('BarsWeb.Controllers')
    .controller('Cash.LimitsDistributionMfo', ['$scope', '$http', function ($scope, $http) {
        $scope.Title = 'Розподіл лімітів на МФО';

        var date = new Date();

        var tempDate = new Date((new Date()).setHours(0, 0, 0, 0));
        var minDate = new Date(tempDate.setDate(date.getDate() - 365));

        $scope.dateNawObject = date;
        $scope.dateObject = date;

        $scope.date = (date.getDate() < 9 ? '0' + date.getDate() : date.getDate()) +
                '/' + ((parseInt(date.getMonth(), 10) + 1) < 9 ? '0' + (parseInt(date.getMonth(), 10) + 1) : (parseInt(date.getMonth(), 10) + 1)) +
                '/' + date.getFullYear();

        var dataSource = {
            url: bars.config.urlContent('/api/cash/limits/'),
            get: function (id, func) {
                if (id) {
                    $http.get(this.url + '?id=' + id)
                        .success(function (request) {
                            $scope.treshold = request;
                            if (func) {
                                func.call();
                            }
                        });
                    return null;
                } else {
                    return {
                        Id: null,
                        LimitType: "CASH",
                        DeviationPercent: null,
                        ViolationDeys: null,
                        MaxLoadLimit: null,
                        ViolationColor: '#FF0000',
                        DateStart: new Date(),
                        DateStop: new Date(),
                        Mfo: null,
                        DateSet: null,
                        DateUpdate: null
                    }
                }
            },
            add: function (object, func) {
                $http.post(this.url, object)
                    .success(function (request) {
                        if (func) {
                            func.apply(null, [request]);
                        }
                    });
            },
            edit: function (object, func) {
                $http.put(this.url, object)
                    .success(function (request) {
                        if (func) {
                            func.apply(null, [request]);
                        }
                    });
            },
            remove: function (mfo, kv, dateStart, limitType, func) {
                $http({
                    method: 'DELETE',
                    url: this.url + '?mfo=' + mfo + '&kv=' + kv + '&date=' + dateStart + '&limitType=' + limitType
                }).success(function (request) {
                    if (func) {
                        func.apply(null, [request]);
                    }
                });
            }
        }

        var refreshlimDistGrid = function () {
            $scope.limDistGrid.dataSource.read();
            $scope.limDistGrid.refresh();
        }

        $scope.dateOptions = {
            format: '{0:dd/MM/yyyy}',
            change: function () {
                refreshlimDistGrid();
            }
        }
        var historyGridRefresh = function (url) {
            if (url) {
                $scope.historyGrid.dataSource.transport.options.read.url = url;
                $scope.historyGrid.dataSource.transport.options.read.cache = false;
            }
            $scope.historyGrid.dataSource.read();
            $scope.historyGrid.refresh();
        }

        $scope.toolbarFilterOptions = {
            resizable: false,
            items: [
                {
                    template: '<label>Дата: </label><input type="text" k-ng-model="dateObject" ng-model="date" kendo-date-picker="" k-options="dateOptions" />'
                }, {
                    type: 'separator'
                }
            ]
        };

        var showUploadWindow = function () {
            bars.ui.dialog({
                content: bars.config.urlContent('/cash/limitsdistribution/fileupload/') + '?date=' + $scope.date + '&type=MFO',
                iframe: true,
                width: '450px',
                height: '300px'
            });
            $scope.$apply();
        }

        $scope.toolbarOptions = {
            resizable: false,
            items: [
                {
                    type: "button",
                    text: '<i class="pf-icon pf-16 pf-exel"></i> Вигрузити в EXCEL',
                    click: function () {
                        $scope.limDistGrid.saveAsExcel();
                    }
                }, {
                    type: "button",
                    text: '<i class="pf-icon pf-16 pf-arrow_download"></i> Завантажити файл',
                    click: function () {
                        showUploadWindow();
                    }
                }
            ]
        };

        $scope.uploadOptions = {
            async: {
                saveUrl: "save",
                removeUrl: "remove",
                autoUpload: true
            }
        }

        function onLimitsDataBound(e) {
            bars.ext.kendo.grid.noDataRow(e);

            var grid = this;
            var currentRecords = grid.dataSource.view();

            for (var i = 0; i < currentRecords.length; i++) {
                if (currentRecords[i].SumOverLimit > 0) {
                    grid.tbody.find('tr[data-uid="' + currentRecords[i].uid + '"]').addClass('red');
                }
            }
        }

        $scope.limitsGridOptions = {
            dataBound: onLimitsDataBound,
            dataSource: {
                type: 'webapi',
                sort: {
                    field: "Kf",
                    dir: "asc"
                },
                transport: {
                    dataType: "json",
                    read: {
                        url: bars.config.urlContent('/api/cash/limits/'),
                        data: { date: function () { return $scope.date; } }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        fields: {
                            Kf: { type: 'string', editable: false },
                            MfoName: { type: 'string', editable: false },
                            Kv: { type: 'number', editable: false },
                            LimCurrent: { type: 'number', editable: false },
                            LimMax: { type: 'number', editable: false },
                            AccLimCurrent: { type: 'number', editable: false },
                            AccLimMax: { type: 'number', editable: false },
                            SumOverLimit: { type: 'number', editable: false },
                            SumOverMaxLimit: { type: 'number', editable: false }
                        }
                    }
                },
                pageSize: 20,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true
            },
            sortable: true,
            filterable: true,
            resizable: true,
            selectable: "single",
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100, 200],
                buttonCount: 5
            },
            columns: [
                {
                    field: "Kf",
                    title: "МФО",
                    width: "80px"
                }, {
                    field: "MfoName",
                    title: "Назва РУ",
                    width: "100px"
                }, {
                    field: "Kv",
                    title: "Код валюти",
                    width: "80px",
                    filterable: bars.ext.kendo.grid.uiNumFilter
                }, {
                    field: "LimCurrent",
                    title: "Поточний ліміт",
                    template: '#=kendo.toString(LimCurrent,"n")#',
                    format: '{0:n}',
                    attributes: { "class": "money" },
                    width: "150px"
                }, {
                    field: "LimMax",
                    title: "Максимальний ліміт",
                    template: '#=kendo.toString(LimMax,"n")#',
                    format: '{0:n}',
                    attributes: { "class": "money" },
                    width: "150px"
                }, {
                    command: [
                    {
                        name: "edit",
                        imageClass: 'pf-icon pf-16 pf-tool_pencil'
                    }, {
                        name: "Видалити",
                        imageClass: 'pf-icon pf-16 pf-delete_button_error',
                        click: function (e) {
                            e.preventDefault();
                            if ($scope.dateObject <= $scope.dateNawObject) {
                                return false;
                            } else {
                                var dataItem = this.dataItem($(e.target).closest("tr"));
                                bars.ui.confirm({
                                    text: 'Видалити розподіл за ' + $scope.date,
                                    func: function () {
                                        dataSource.remove(dataItem.Id, $scope.date, function () {
                                            refreshlimDistGrid();
                                        });
                                    }
                                });
                            }
                            return true;
                        }
                    }],
                    title: "&nbsp;",
                    width: "250px",
                    attributes: { 'class': 'editing-controls' }
                }, {
                    command: [
                        {
                            name: "Історія",
                            imageClass: 'pf-icon pf-16 pf-report_open',
                            click: function (e) {
                                var tr = $(e.target).closest("tr");
                                var data = $scope.limDistGrid.dataItem(tr);

                                $scope.historyWindowTitle = 'План розподілу по рах № ' + data.AccNumber + '(' + data.Currency + ')';
                                $scope.historyGridOptions.dataSource.id = data.Id;
                                historyGridRefresh(dataSource.url + '?id=' + data.Id);

                                $scope.historyWindow.center().open();
                            }
                        }
                    ],
                    title: "&nbsp;",
                    width: "100px"
                }
            ]
        }

        var currentLimValidation = function (input) {
            if (input.is("[name='LimCurrent']") && input.val() !== "") {
                var maxLim = input.parentsUntil('tr').parent().find('[name="LimMax"]').val();
                if (parseInt(input.val(), 10) > parseInt(maxLim, 10)) {
                    input.attr("validationMessage", "перевищення макс. ліміту");
                    return false;
                } else {
                    return true;
                }
            }
            return true;
        };
        var maxLimValidation = function (input) {
            if (input.is('[name="LimMax"]') && input.val() !== "") {
                var currLim = input.parentsUntil('tr').parent().find('[name="LimCurrent"]').val();
                if (parseInt(input.val(), 10) < parseInt(currLim, 10)) {
                    input.attr("validationMessage", "макс. ліміт < поточного");
                    return false;
                } else {
                    return true;
                }
            }
            return true;
        };

        var currentHistoryLimValidation = function (input) {
            if (input.is("[name='LimCurrent']") && input.val() !== "") {
                var maxLim = input.parentsUntil('tr').parent().find('[name="LimMax"]').val();
                if (parseInt(input.val(), 10) > parseInt(maxLim, 10)) {
                    input.attr("validationMessage", "перевищення макс. ліміту");
                    return false;
                } else {
                    return true;
                }
            }
            return true;
        };
        var maxHistoryLimValidation = function (input) {
            if (input.is('[name="LimMax"]') && input.val() !== "") {
                var currLim = input.parentsUntil('tr').parent().find('[name="LimCurrent"]').val();
                if (parseInt(input.val(), 10) < parseInt(currLim, 10)) {
                    input.attr("validationMessage", "макс. ліміт < поточного");
                    return false;
                } else {
                    return true;
                }
            }
            return true;
        };

        var startdatevalidation = function (input) {
            if (input.is('[name="StartDate"]') && input.val() !== "") {
                var dateThis = input.data("kendoDatePicker").value();


                if (minDate > dateThis) {
                    input.attr("validationMessage", "невірна дата");
                    return false;
                } else {
                    return true;
                }
            }
            return true;
        };

        $scope.limDistGridOptions = {
            excel: {
                fileName: "CashLimitsDistributionMfo.xlsx",
                proxyURL: bars.config.urlContent('/cash/limitsdistribution/convertBase64toFile/'),
                filterable: false,
                pagenable: false
            },
            dataBound: function (e) {
                bars.ext.kendo.grid.noDataRow(e);
            },
            dataSource: {
                type: 'webapi',
                sort: {
                    field: "Kf",
                    dir: "asc"
                },
                transport: {
                    dataType: "json",
                    read: {
                        url: dataSource.url,
                        data: { date: function () { return $scope.date; } }
                    },
                    update: {
                        url: dataSource.url,
                        type: 'PUT',
                        dataType: 'json',
                        data: { date: function () { return $scope.date; } },
                        complete: function () {
                            refreshlimDistGrid();
                        }
                    },
                    create: {
                        url: dataSource.url,
                        dataType: "json",
                        type: 'POST',
                        data: { date: function () { return $scope.date; } },
                        complete: function () {
                            refreshlimDistGrid();
                        }
                    },
                    destroy: {
                        url: dataSource.url,
                        type: 'DELETE',
                        dataType: 'json',
                        data: { date: function () { return $scope.date; } },
                        complete: function () {
                            refreshlimDistGrid();
                        }
                    },
                    parameterMap: function (options, operation) {

                        if (operation !== "read" && options.models) {
                            return { models: 1 }
                        }
                        return { models: 1 }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        id: 'Id',
                        fields: {
                            Id: { type: 'number', editable: false },
                            Kf: { type: 'string', editable: false },
                            MfoName: { type: 'string', editable: false },
                            Kv: { type: 'number', editable: false },
                            LimCurrent: {
                                type: "number",
                                defaultValue: null,
                                validation: {
                                    min: 0,
                                    max: 999999999999999,
                                    required: true,
                                    format: '{0:n}',
                                    currentlimitvalidation: currentLimValidation
                                }
                            },
                            LimMax: {
                                type: "number",
                                defaultValue: null,
                                validation: {
                                    min: 0,
                                    max: 999999999999999,
                                    required: true,
                                    decimals: 0,
                                    format: '{0:n}',
                                    maxlimitvalidation: maxLimValidation
                                }
                            },
                            AccLimCurrent: { type: 'number', editable: false },
                            AccLimMax: { type: 'number', editable: false },
                            SumOverLimit: { type: 'number', editable: false },
                            SumOverMaxLimit: { type: 'number', editable: false }
                        }
                    }
                },
                pageSize: 20,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true
            },
            editable: 'inline',
            sortable: true,
            filterable: true,
            resizable: true,
            reorderable: true,
            selectable: "single",
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100, 200],
                buttonCount: 5
            },
            columns: [
                {
                    field: "Kf",
                    title: "МФО",
                    width: "80px"
                }, {
                    field: "MfoName",
                    title: "Назва РУ",
                    width: "100px"
                }, {
                    field: "Kv",
                    title: "Код валюти",
                    width: "80px",
                    filterable: bars.ext.kendo.grid.uiNumFilter
                }, {
                    field: "LimCurrent",
                    title: "Поточний ліміт",
                    format: '{0:n}',
                    template: '#=kendo.toString(LimCurrent,"n")#',
                    attributes: { "class": "money" },
                    width: "150px"
                }, {
                    field: "LimMax",
                    title: "Максимальний ліміт",
                    decimals: 0,
                    format: '{0:n}',
                    template: '#=kendo.toString(LimMax,"n")#',
                    attributes: { "class": "money" },
                    width: "150px"
                }, {
                    command: [
                    {
                        name: "edit",
                        imageClass: 'pf-icon pf-16 pf-tool_pencil'
                    }, {
                        name: "Видалити",
                        imageClass: 'pf-icon pf-16 pf-delete_button_error',
                        click: function (e) {
                            e.preventDefault();
                            if ($scope.dateObject <= $scope.dateNawObject) {
                                return false;
                            } else {
                                var dataItem = this.dataItem($(e.target).closest("tr"));
                                bars.ui.confirm({
                                    text: 'Видалити розподіл по МФО: ' + dataItem.Kf + ' за ' + $scope.date,
                                    func: function () {
                                        dataSource.remove(dataItem.Kf, dataItem.Kv, $scope.date, dataItem.LimitType, function () {
                                            refreshlimDistGrid();
                                        });
                                    }
                                });
                            }
                            return true;
                        }
                    }],
                    title: "&nbsp;",
                    width: "250px",
                    attributes: { 'class': 'editing-controls' }
                }, {
                    command: [
                        {
                            name: "Історія",
                            imageClass: 'pf-icon pf-16 pf-report_open',
                            click: function (e) {
                                var tr = $(e.target).closest("tr");
                                var data = $scope.limDistGrid.dataItem(tr);

                                $scope.historyWindowTitle = 'План розподілу по МФО № ' + data.Kf + ' валюта: ' + data.Kv + '';
                                $scope.historyGridOptions.dataSource.id = data.Id;
                                $scope.historyGridOptions.dataSource.Kf = data.Kf;
                                $scope.historyGridOptions.dataSource.Kv = data.Kv;
                                historyGridRefresh(dataSource.url + '?kf=' + data.Kf + '&kv=' + data.Kv);

                                $scope.historyWindow.center().open();
                            }
                        }
                    ],
                    title: "&nbsp;",
                    width: "100px"
                }
            ]
        };

        $scope.historyWindowOptions = {
            animation: false,
            visible: false,
            width: "700px",
            actions: ["Maximize", "Minimize", "Close"],
            draggable: true,
            height: "600px",
            modal: true,
            pinned: false,
            resizable: true,
            title: '',
            position: 'center',
            close: function () {
                refreshlimDistGrid();
            },
            iframe: false
        }

        $scope.historyWindowTitle = "";

        $scope.historyGridOptions = {
            edit: function (e) {
                $(e.sender.wrapper)
                    .find('tbody td [name="StartDate"]')
                    .data('kendoDatePicker')
                    .min(minDate);
            },
            autoBind: false,
            toolbar: ['create'],
            dataBound: function (e) {
                bars.ext.kendo.grid.noDataRow(e);
            },
            dataSource: {
                date: '',
                id: 0,
                Kf: '',
                Kv: '',
                type: 'webapi',
                sort: {
                    field: "StartDate",
                    dir: "desc"
                },
                transport: {
                    dataType: "json",
                    read: {
                        url: dataSource.url + '?id='
                    },
                    update: {
                        url: dataSource.url,
                        type: 'PUT',
                        dataType: 'json',
                        data: { date: function () { return $scope.historyGridOptions.dataSource.date; } },
                        complete: function () {
                            historyGridRefresh();
                        }
                    },
                    create: {
                        url: dataSource.url,
                        dataType: "json",
                        type: 'POST',
                        data: { date: function () { return $scope.historyGridOptions.dataSource.date; } },
                        complete: function () {
                            historyGridRefresh();
                        }
                    },
                    destroy: {
                        url: dataSource.url,
                        type: 'DELETE',
                        dataType: 'json',
                        data: { date: function () { return $scope.historyGridOptions.dataSource.date; } },
                        complete: function () {
                            historyGridRefresh();
                        }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        id: 'StartDate',
                        fields: {
                            Id: {
                                type: 'number', editable: false,
                                defaultValue: function () {
                                    return $scope.historyGridOptions.dataSource.id;
                                }
                            },
                            Kf: {
                                type: 'string', editable: false,
                                defaultValue: function () {
                                    return $scope.historyGridOptions.dataSource.Kf;
                                }
                            },
                            Kv: {
                                type: 'number', editable: false,
                                defaultValue: function () {
                                    return $scope.historyGridOptions.dataSource.Kv;
                                }
                            },
                            LimCurrent: {
                                type: "number",
                                defaultValue: null,
                                validation: {
                                    min: 0,
                                    max: 999999999999999,
                                    required: true,
                                    currentlimitvalidation: currentHistoryLimValidation
                                }
                            },
                            LimMax: {
                                type: "number",
                                defaultValue: null,
                                validation: {
                                    min: 0,
                                    max: 999999999999999,
                                    required: true,
                                    decimals: 0,
                                    maxlimitvalidation: maxHistoryLimValidation
                                }
                            },
                            StartDate: {
                                type: 'date',
                                editable: true,
                                validation: {
                                    required: true,
                                    startdatevalidation: startdatevalidation
                                }
                            }
                        }
                    }
                },
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true
            },
            height: '500px',
            editable: 'inline',
            sortable: true,
            filterable: true,
            resizable: true,
            reorderable: true,
            selectable: "single",
            save: function (e) {
                $scope.historyGridOptions.dataSource.date = kendo.toString(e.model.StartDate, "dd/MM/yyyy");
            },
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100, 200],
                buttonCount: 5
            },
            columns: [
            {
                field: "LimCurrent",
                title: "Поточний ліміт",
                template: '#=kendo.toString(LimCurrent,"n")#',
                attributes: { "class": "money" },
                format: "{0:n}",
                width: "150px"
            }, {
                field: "LimMax",
                title: "Макс. ліміт",
                template: '#=kendo.toString(LimMax,"n")#',
                attributes: { "class": "money" },
                format: "{0:n}",
                decimals: 0,
                width: "150px"
            }, {
                field: "StartDate",
                title: "Дата початку",
                format: "{0:dd/MM/yyyy}",
                width: "150px"
            }, {
                command: [
                {
                    name: "edit",
                    imageClass: 'pf-icon pf-16 pf-tool_pencil'
                },
                {
                    name: "Видалити",
                    imageClass: 'pf-icon pf-16 pf-delete_button_error',
                    click: function (e) {
                        e.preventDefault();
                        var dataItem = this.dataItem($(e.target).closest("tr"));
                        var dateStr = kendo.toString(dataItem.StartDate, "dd/MM/yyyy");
                        bars.ui.confirm({
                            text: 'Видалити розподіл по МФО за ' + dateStr,
                            func: function () {
                                dataSource.remove(dataItem.Kf, dataItem.Kv, dateStr, dataItem.LimitType, function () {
                                    historyGridRefresh();
                                });
                            }
                        });
                        return true;
                    }
                }],
                title: "&nbsp;",
                width: "250px"
            }]
        }
    }]);