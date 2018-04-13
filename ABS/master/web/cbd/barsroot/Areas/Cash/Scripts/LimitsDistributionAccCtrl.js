angular.module('BarsWeb.Controllers').controller('Cash.LimitsDistributionAcc', ['$scope', '$http', function ($scope, $http) {
    $scope.Title = 'Розподіл лімітів залишків готівки (Рахунки)';

    var date = new Date();
    
    var tempDate = new Date((new Date()).setHours(0, 0, 0, 0));
    var minDate = new Date(tempDate.setDate(date.getDate() + 1));

    $scope.dateNawObject = date;
    $scope.dateObject = date;

    $scope.date = (date.getDate() < 9 ? '0' + date.getDate() : date.getDate()) +
            '/' + ((parseInt(date.getMonth(), 10) + 1) < 9 ? '0' + (parseInt(date.getMonth(), 10) + 1) : (parseInt(date.getMonth(), 10) + 1)) +
            '/' + date.getFullYear();

    var dataSource = {
        url: bars.config.urlContent('/api/cash/limitsdistributionAcc/'),
        get: function (id, func) {
            if (id) {
                $http.get(this.url + '?id=' + id)
                    .success(function (request) {
                        $scope.treshold = request;
                        if (func) {
                            func.call();
                            //func.apply(null, [request]);
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
                    if (request.Status === 'ERROR') {
                        bars.ui.error({ text: request.Message });
                    } else {
                        if (func) {
                            func.apply(null, [request]);
                        }
                    }
                });
        },
        edit: function (object, func) {
            $http.put(this.url, object)
                .success(function (request) {
                    if (request.Status === 'ERROR') {
                        bars.ui.error({ text: request.Message });
                        return false;
                    } else {
                        if (func) {
                            func.apply(null, [request]);
                        }
                        return undefined;
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
        $scope.limitsGrid.dataSource.read();
        $scope.limitsGrid.refresh();
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
    var showUploadWindow = function () {

        bars.ui.dialog({
            content: bars.config.urlContent('/cash/limitsdistribution/fileupload/') + '?date=' + $scope.date + '&type=ACC',
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
            }, {
                type: "button",
                text: '<i class="pf-icon pf-16 pf-exel"></i> Файл EXCEL для завантаження',
                click: function () {
                    exportToExelUpload();
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
                        Id: { type: 'string', editable: false},
                        Kf: { type: 'string', editable: false },
                        MfoName: { type: 'string', editable: false },
                        Kv: { type: 'number', editable: false },
                        SumBal:{type: 'number', editable: false},
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
            },{
                field: "Kv",
                title: "Валюта",
                width: "80px",
                filterable: bars.ext.kendo.grid.uiNumFilter
            }, {
                field: "SumBal",
                title: "Баланс",
                template: '#=kendo.toString(SumBal,"n")#',
                format:'{0:n}',
                attributes: { "class": "money" },
                width: "150px"                
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
                field: "AccLimCurrent",
                title: "Сума поточ.лім.<br>(розпод. на рах.)",
                template: '#=kendo.toString(AccLimCurrent,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "150px"
            }, {
                field: "AccLimMax",
                title: "Сума макс.лім.<br>(розпод. на рах.)",
                template: '#=kendo.toString(AccLimMax,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "150px"
            },{
                field: "SumOverLimit",
                title: "Перевищення<br> поточ. ліміту",
                template: '#=kendo.toString(SumOverLimit,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "150px"
            }, {
                field: "SumOverMaxLimit",
                title: "Перевищення<br>макс. ліміту",
                template: '#= kendo.toString(SumOverMaxLimit,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "150px"
            }
        ]
    }

    var currentLimValidation = function (input) {
        if (input.is("[name='LimitCurrent']") && input.val() != "") {
            var maxLim = input.parentsUntil('tr').parent().find('[name="LimitMax"]').val();
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
        if (input.is('[name="LimitMax"]') && input.val() != "") {
            var currLim = input.parentsUntil('tr').parent().find('[name="LimitCurrent"]').val();
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
        /*toolbar: ["excel"],
        excel: {
            fileName: "CashLimitsDistributionAcc.xls",
            proxyURL: bars.config.urlContent('/cash/limitsdistribution/convertBase64toFile/'),
            filterable: false,
            pagenable: false
        },*/
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
                    //dataType: 'json',
                    data: { date: function () { return $scope.date; } }
                },
                update: {
                    url: dataSource.url,// + '?date=' ,
                    type: 'PUT',
                    dataType: 'json',
                    data: { date: function () { return $scope.date; } },
                    complete: function (request) {
                        if (request.responseJSON && request.responseJSON.Status === 'ERROR') {
                            bars.ui.error({ text: request.responseJSON.Message });
                            refreshlimDistGrid();
                        } else {
                            refreshlimDistGrid();
                            refreshLimitsGrid();
                        }
                    }
                },
                create: {
                    url: dataSource.url,
                    dataType: "json",
                    type: 'POST',
                    data: { date: function () { return $scope.date; } },
                    complete: function (request) {
                        if (request.responseJSON && request.responseJSON.Status === 'ERROR') {
                            bars.ui.error({ text: request.responseJSON.Message });
                            refreshlimDistGrid();
                        } else {
                            refreshlimDistGrid();
                            refreshLimitsGrid();
                        }
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
                    /*console.log('test');
                    if (operation !== "read" && options.models) {
                        return { models: 1 }
                        //return{models: { limitDistr: kendo.stringify(options.models),date:  $scope.date}};
                    }
                    return { models: 1 }*/
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
                        Branch: { type: 'string', editable: false },
                        Kf: { type: 'string', editable: false },
                        Ob22:{type: 'string', editable: false},
                        MfoName: { type: 'string', editable: false },
                        AccNumber: { type: 'string', editable: false },
                        Name: { type: 'string', editable: false },
                        Currency: { type: 'number', editable: false },
                        Balance: { type: 'number', editable: false },
                        LimitCurrent: {
                            type: "number",
                            defaultValue: null,
                            validation: {
                                min: 0,
                                max: 999999999999999,
                                required: true,
                                currentlimitvalidation: currentLimValidation
                            }
                        },
                        LimitMax: {
                            type: "number",
                            defaultValue: null,
                            validation: {
                                min: 0,
                                max: 999999999999999,
                                required: true,
                                maxlimitvalidation: maxLimValidation
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
        columns: [ {
                field: "Kf",
                title: "МФО",
                width: "80px"
            },  {
                field: "MfoName",
                title: "Назва РУ",
                width: "100px"
            },{
                field: "Branch",
                title: "Відділення",
                width: "170px"
            },{
                field: "AccNumber",
                title: "Рахунок",
                width: "120px"
            }, {
                field: "Name",
                title: "Назва рахунку",
                width: "210px"
            }, {
                field: "CashType",
                title: "Тип рахунку",
                width: "80px"
            }, {
                field: "Currency",
                title: "Код валюти",
                width: "60px",
                filterable: bars.ext.kendo.grid.uiNumFilter
            }, {
                field: "Ob22",
                title: "ОБ22",
                width: "50px"                
            },/* {
                field: "Balance",
                title: "Баланс",
                template: '#=kendo.toString(Balance,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "170px"
            },*/ {
                field: "LimitCurrent",
                title: "Поточний ліміт",
                template: '#=kendo.toString(LimitCurrent,"n")#',
                format: "{0:n}",
                attributes: { "class": "money" },
                width: "170px"
            }, {
                field: "LimitMax",
                title: "Максимальний ліміт",
                template: '#=kendo.toString(LimitMax,"n")#',
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
                        if ($scope.dateObject <= $scope.dateNawObject) {
                            return false;
                        } else {
                            var dataItem = this.dataItem($(e.target).closest("tr"));
                            bars.ui.confirm({
                                text: 'Видалити розподіл за ' + $scope.date,
                                func: function () {
                                    dataSource.remove(dataItem.Id, $scope.date, function () {
                                        refreshlimDistGrid();
                                        //historyGridRefresh();
                                    });
                                    //$scope.limDistGrid.dataSource.remove(dataItem);
                                    //$scope.limDistGrid.dataSource.sync();
                                }
                            });
                        }
                    }
                }]

                /*command: ["edit", {
                    name: "destroy",
                    //type: "button",
                    //template: '<button><i class="pf-icon pf-16 pf-delete_button_error"></i> Видалити</button>',
                    template: '<a class="k-button" href="\\#"><i class="pf-icon pf-16 pf-delete_button_error"></i> Видалити</a>',
                    //text: "remove",
                    click: function() {
                        bars.ui.confirm({text:'Видалити розподіл за ' +$scope.date});
                    }
                }]*/,
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
                //.min(minDate);
        },
        autoBind: false,
        toolbar: ['create'],
        /*excel: {
        fileName: "CashLimitsDistributionAcHistory.xls",
        proxyURL: bars.config.urlContent('/cash/limitsdistribution/convertBase64toFile/'),
        filterable: false,
        pagenable: false
    },*/
        dataBound: function (e) {
            bars.ext.kendo.grid.noDataRow(e);
            //$(e.sender.wrapper).find('tbody td.editing-controls.k-state-disabled').find('.k-button').hide();
        },
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
                    data: { date: function () { return $scope.historyGridOptions.dataSource.date; } },
                    complete: function (request) {
                        if (request.responseJSON && request.responseJSON.Status === 'ERROR') {
                            bars.ui.error({ text: request.responseJSON.Message });
                            historyGridRefresh();
                        } else {
                            historyGridRefresh();
                        }
                    }
                },
                create: {
                    url: dataSource.url,
                    dataType: "json",
                    type: 'POST',
                    data: { date: function () { return $scope.historyGridOptions.dataSource.date; } },
                    complete: function (request) {
                        if (request.responseJSON && request.responseJSON.Status === 'ERROR') {
                            bars.ui.error({ text: request.responseJSON.Message });
                            historyGridRefresh();
                        } else {
                            historyGridRefresh();
                        }
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
                        Id: { type: 'number', editable: false, defaultValue: function () { return $scope.historyGridOptions.dataSource.id; } },
                        LimitCurrent: {
                            type: "number",
                            defaultValue: null,
                            validation: {
                                min: 0,
                                max: 999999999999999,
                                required: true,
                                currentlimitvalidation: currentLimValidation
                            }
                        },
                        LimitMax: {
                            type: "number",
                            defaultValue: null,
                            validation: {
                                min: 0,
                                max: 999999999999999,
                                required: true,
                                maxlimitvalidation: maxLimValidation
                            }
                        },
                        StartDate: {
                            type: 'date',
                            editable: true,
                            defaultValue: minDate,
                            validation: {
                                //min: date,
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
        /*{
            field: "Id",
            title: "Acc",
            width: "80px"
        }, */{
            field: "LimitCurrent",
            title: "Поточний ліміт",
            template: '#=kendo.toString(LimitCurrent,"n")#',
            attributes: { "class": "money" },
            format: "{0:n}",
            width: "150px"
        }, {
            field: "LimitMax",
            title: "Макс. ліміт",
            template: '#=kendo.toString(LimitMax,"n")#',
            attributes: { "class": "money" },
            format: "{0:n}",
            width: "150px"
        }, {
            field: "StartDate",
            title: "Дата початку",
            format: "{0:dd/MM/yyyy}",
            //min: date,
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
                    /*if (dataItem.StartDate <= date) {
                        return false;
                    } else {*/
                        bars.ui.confirm({
                            text: 'Видалити розподіл за ' + dateStr,
                            func: function () {
                                dataSource.remove(dataItem.Id, dateStr, function () {
                                    historyGridRefresh();
                                });
                                //$scope.historyGridOptions.dataSource.date = dateStr;
                                //$scope.historyGrid.dataSource.remove(dataItem);
                                //$scope.historyGrid.dataSource.sync();
                            }
                        });
                    //}


                }
            }],
            title: "&nbsp;",
            width: "250px"//,
            //attributes: { 'class': 'editing-controls #= StartDate && StartDate <= new Date() ? "k-state-disabled" : "" #' }
        }]
    }
}]);