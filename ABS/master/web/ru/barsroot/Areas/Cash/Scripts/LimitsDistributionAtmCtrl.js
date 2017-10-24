angular.module('BarsWeb.Controllers').controller('Cash.LimitsDistributionAtm', ['$scope', '$http', function ($scope, $http) {
    $scope.Title = 'Розподіл лімітів залишків готівки (Банкомати)';

    var date = new Date();

    var tempDate = new Date((new Date()).setHours(0, 0, 0, 0));
    var minDate = new Date(tempDate.setDate(date.getDate() + 1));

    $scope.dateNawObject = date;
    $scope.dateObject = date;

    $scope.date = (date.getDate() < 9 ? '0' + date.getDate() : date.getDate()) +
            '/' + ((parseInt(date.getMonth(), 10) + 1) < 9 ? '0' + (parseInt(date.getMonth(), 10) + 1) : (parseInt(date.getMonth(), 10) + 1)) +
            '/' + date.getFullYear();

    var dataSource = {
        url: bars.config.urlContent('/api/cash/limitsdistributionAtm/'),
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
        remove: function (id, dateStart, func) {
            $http({
                method: 'DELETE',
                url: this.url + '?id=' + id + '&date=' + dateStart
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

    var refreshLimitsGrid = function () {
        
    }

    $scope.dateOptions = {
        format: '{0:dd/MM/yyyy}',
        change: function () {
            refreshlimDistGrid();
            refreshLimitsGrid();
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
    var exportToExel = function () {
        document.location.href = dataSource.url + '?date=' + $scope.date + '&type=xls';
    }
    var exportToExelUpload = function () {
        document.location.href = dataSource.url + '?date=' + $scope.date + '&type=XLSUPLOAD';
    }
    $scope.uploadOptions = {
        async: {
            saveUrl: "save",
            removeUrl: "remove",
            autoUpload: true
        }
    }

    var showUploadWindow = function () {

        bars.ui.dialog({
            content: bars.config.urlContent('/cash/limitsdistribution/fileupload/') + '?date=' + $scope.date + '&type=ATM',
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
                    exportToExel();
                }
            },{
                type: "button",
                text: '<i class="pf-icon pf-16 pf-exel"></i> Файл EXCEL для завантаження',
                click: function () {
                    exportToExelUpload();
                }
            },{
                type: "button",
                text: '<i class="pf-icon pf-16 pf-arrow_download"></i> Завантажити файл',
                click: function () {
                    showUploadWindow();
                }
            }
        ]
    };

    var startdatevalidation = function (/*input*/) {
        /*if (input.is('[name="StartDate"]') && input.val() !== "") {
            var dateThis = input.data("kendoDatePicker").value();


            if (minDate > dateThis) {
                input.attr("validationMessage", "невірна дата");
                return false;
            } else {
                return true;
            }
        }*/
        return true;
    };

    $scope.limDistGridOptions = {
        heidht: 100,
        dataBound: function (e) {
            bars.ext.kendo.grid.noDataRow(e);
        },
        dataSource: {
            type: 'webapi',
            sort: {
                field: "Branch",
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
                        refreshLimitsGrid();
                    }
                },
                create: {
                    url: dataSource.url,
                    dataType: "json",
                    type: 'POST',
                    data: { date: function () { return $scope.date; } },
                    complete: function () {
                        refreshLimitsGrid();
                    }
                },
                destroy: {
                    url: dataSource.url,
                    type: 'DELETE',
                    dataType: 'json',
                    data: { date: function () { return $scope.date; } },
                    complete: function () {
                        refreshlimDistGrid();
                        refreshLimitsGrid();
                    }
                },
                parameterMap: function (options, operation) {
                    console.log('test');
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
                        AtmCode: { type: 'string', editable: false },
                        Branch: { type: 'string', editable: false },
                        Kf: { type: 'string', editable: false },
                        MfoName: { type: 'string', editable: false },
                        AccNumber: { type: 'string', editable: false },
                        Name: { type: 'string', editable: false },
                        Currency: { type: 'number', editable: false },
                        Balance: { type: 'number', editable: false },
                        AccMaxLoad: { type: 'number' },
                        LimitMaxLoad: {
                            type: 'number',
                            defaultValue: null,
                            validation: {
                                min: 0,
                                max: 999999999999999,
                                required: true
                            }
                        },
                        CashType: { type: 'string', editable: false }
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
            },{
                field: "MfoName",
                title: "Назва РУ",
                width: "100px"
            },{
                field: "Branch",
                title: "Відділення",
                width: "170px"
            }, {
                field: "AtmCode",
                title: "Код банкомату",
                width: "170px"                
            }, {
                field: "CashType",
                title: "Тип рахунку",
                width: "80px"
            }, {
                field: "AccNumber",
                title: "Рахунок",
                width: "120px"
            }, {
                field: "Name",
                title: "Назва рахунку",
                width: "210px"
            }, {
                field: "Currency",
                title: "Код валюти",
                width: "60px",
                filterable: bars.ext.kendo.grid.uiNumFilter
            }, {
                field: "Balance",
                title: "Баланс рахунку",
                template: '#=kendo.toString(Balance,"n")#',
                attributes: { "class": "money" },
                format: "{0:n}",
                width: "170px"
            }, {
                field: "LimitMaxLoad",
                title: "Ліміт макс. загрузки",
                template: '#=kendo.toString(LimitMaxLoad,"n")#',
                format: "{0:n}",
                attributes: { "class": "money" },
                width: "170px"
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
            refreshLimitsGrid();
        },
        iframe: false
    }

    $scope.historyWindowTitle = "";

    $scope.historyGridOptions = {
        edit: function (e) {
            $(e.sender.wrapper)
                .find('tbody td [name="StartDate"]')
                .data('kendoDatePicker');
        },
        autoBind: false,
        toolbar: ['create'],
        dataSource: {
            date: '',
            id: 0,
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
                    data: { date: function() { return $scope.historyGridOptions.dataSource.date; } },
                    complete: function() {
                        historyGridRefresh();
                    }
                },
                create: {
                    url: dataSource.url,
                    dataType: "json",
                    type: 'POST',
                    data: { date: function() { return $scope.historyGridOptions.dataSource.date; } },
                    complete: function() {
                        historyGridRefresh();
                    }
                },
                destroy: {
                    url: dataSource.url,
                    type: 'DELETE',
                    dataType: 'json',
                    data: { date: function() { return $scope.historyGridOptions.dataSource.date; } },
                    complete: function() {
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
                        Id: { type: 'number', editable: false, defaultValue: function() { return $scope.historyGridOptions.dataSource.id; } },
                        LimitMaxLoad: {
                            type: 'number',
                            editable: true,
                            defaultValue: null,
                            validation: {
                                min: 0,
                                max: 999999999999999,
                                required: true
                            }
                        },
                        StartDate: {
                            type: 'date',
                            editable: true,
                            defaultValue: minDate,
                            validation: {
                                required: true,
                                startdatevalidation: startdatevalidation
                            }
                        },
                        CashType: { type: 'string', editable: false }
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
                field: "LimitMaxLoad",
                title: "Макс. ліміт зав.",
                template: '#=kendo.toString(LimitMaxLoad,"n")#',
                attributes: { "class": "money" },
                format: "{0:n}",
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
                            text: 'Видалити розподіл за ' + dateStr,
                            func: function () {
                                dataSource.remove(dataItem.Id, dateStr, function () {
                                    historyGridRefresh();
                                });
                            }
                        });
                    }
                }],
                title: "&nbsp;",
                width: "250px"
            }
        ]
    }
}]);