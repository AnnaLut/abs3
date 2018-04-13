angular.module('BarsWeb.Controllers')
    .controller('Cash.Treshold',
            ['$scope', '$http',
        function ($scope, $http) {
            var date = new Date();

            var tempDate = new Date((new Date()).setHours(0, 0, 0, 0));
            var minDate = new Date(tempDate.setDate(date.getDate() - 99));

            $scope.dateNawObject = date;
            $scope.dateObject = date;

            $scope.date = (date.getDate() < 9 ? '0' + date.getDate() : date.getDate()) +
                    '/' + ((parseInt(date.getMonth(), 10) + 1) < 9 ? '0' + (parseInt(date.getMonth(), 10) + 1) : (parseInt(date.getMonth(), 10) + 1)) +
                    '/' + date.getFullYear();

            $scope.treshold = {
                Id: null,
                LimitType: null,
                DeviationPercent: null,
                ViolationDeys: null,
                MaxLoadLimit: null,
                ViolationColor: '#FF0000',
                DateStart: new Date(1900, 0, 1),
                NacCurrencyFlag: '0',
                Mfo: null,
                DateSet: null,
                DateUpdate: null
            }

            var dataSource = {
                url: bars.config.urlContent('/api/Cash/Treshold/'),
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
                            LimitType: null,
                            DeviationPercent: null,
                            ViolationDeys: null,
                            MaxLoadLimit: null,
                            ViolationColor: '#FF0000',
                            DateStart: new Date(),
                            NacCurrencyFlag: '0',
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
                remove: function (id, func) {
                    $http({
                        method: 'DELETE',
                        url: this.url + '?id=' + id
                    }).success(function (request) {
                        if (func) {
                            func.apply(null, [request]);
                        }
                    });
                }
            }
            $scope.limitTypeDropDownListOptions = {
                select: function (e) {
                    e.preventDefault();
                    var data = this.dataItem(e.item.index());
                    var selectedType = data.value; //this will have the new selected value
                    if ($scope.tresholdWindow.type !== 'GLOBAL' && selectedType !== 'ATM') {
                        $scope.treshold.LimitType = selectedType;
                        $scope.limitTypeDropDownList.select(e.item.index());
                    }
                }
            };
            $scope.showMfoHandBook = function () {
                bars.ui.handBook('CLIM_MFO', function (data) {
                    $scope.treshold.Mfo = $(data).map(function () {
                        return this.MFO;
                    }).get().toString();
                    $scope.$apply();
                },
                {
                    multiSelect: true,
                    columns: "MFO,NAME"
                });
            }

            $scope.editorTitle = function () {
                if ($scope.treshold.Id == null) {
                    return 'Створення нового параметра';
                } else {
                    return 'Редагування параметра № ' + $scope.treshold.Id;
                }
            }

            $scope.toolbarOptions = {
                resizable: false,
                items: [
                    {
                        template: '<label>Дата: </label><input type="text" ng-model="report.date" kendo-date-picker="" k-options="dateOptions" />'
                    }, {
                        type: 'separator'
                    }, {
                        template: '<label>Підрозділ: </label>'
                    }
                ]
            };

            var historyGridRefresh = function (url) {
                if (url) {
                    $scope.historyGrid.dataSource.transport.options.read.url = url;
                    $scope.historyGrid.dataSource.transport.options.read.cache = false;
                }
                $scope.historyGrid.dataSource.read();
                $scope.historyGrid.refresh();
            }

            var selectedRow = function () {
                return $scope.tresholdGrid.dataItem($scope.tresholdGrid.select());
            };

            var selectedRowGlobal = function () {
                return $scope.tresholdGlobalGrid.dataItem($scope.tresholdGlobalGrid.select());
            };

            $scope.historyWindowTitle = 'Історія зміни параметрів';
            var showHistoryWindow = function () {
                var data = selectedRow();
                if (!data) {
                    bars.ui.error({ text: 'Виберіть рядок для перегляду історії' });
                } else {

                    $scope.historyWindowTitle = 'Історія зміни параметрів типу ' + data.LimitType + ' по МФО ' + data.Mfo + '';
                    $scope.historyGridOptions.dataSource.Mfo = data.Mfo;
                    $scope.historyGridOptions.dataSource.LimitType = data.LimitType;
                    historyGridRefresh(dataSource.url + '?type=' + data.LimitType + '&mfo=' + data.Mfo + '&date=' + $scope.date + '&curFlag' + data.NacCurrencyFlag);

                    $scope.historyWindow.center().open();
                    $scope.$apply();
                }
            }

            var tresholdGridRefresh = function () {
                $scope.tresholdGrid.dataSource.read();
                $scope.tresholdGrid.refresh();
            }

            var tresholdGlobalGridRefresh = function () {
                $scope.tresholdGlobalGrid.dataSource.read();
                $scope.tresholdGlobalGrid.refresh();
            }

            var toolbarWindows = {
                add: function (type) {
                    $scope.tresholdWindow.type = type;
                    $scope.treshold = dataSource.get();
                    if (type === 'GLOBAL') {

                        $scope.limitTypeDropDownList.enable(false);
                        $scope.treshold.LimitType = 'ATM';

                    } else {
                        $scope.limitTypeDropDownList.enable();
                        $scope.treshold.LimitType = 'CASH';
                    }

                    $scope.tresholdWindow.center().open();
                    $scope.$apply();
                },
                edit: function (type) {
                    $scope.tresholdWindow.type = type;
                    var data;
                    if (type === 'GLOBAL') {
                        data = selectedRowGlobal();
                    } else {
                        data = selectedRow();
                    }
                    if (!data) {
                        bars.ui.error({ text: 'Не вибрано жодного рядка для редагування' });
                    } else {
                        $scope.treshold = dataSource.get();

                        if (data.Id) {
                            dataSource.get(data.Id, function() {
                                bars.ui.loader('#tresholdWindow', false);
                            });
                        } else {
                            $scope.treshold = data;
                        }


                        if (type === 'GLOBAL') {
                            $scope.limitTypeDropDownList.enable(false);
                        } else {
                            $scope.limitTypeDropDownList.enable();
                        }

                        $scope.tresholdWindow.center().open();
                    }
                    $scope.$apply();
                },
                remove: function (type) {
                    $scope.tresholdWindow.type = type;
                    var data;
                    if (type === 'GLOBAL') {
                        data = selectedRowGlobal();
                    } else {
                        data = selectedRow();
                    }
                    if (!data) {
                        bars.ui.error({ text: 'Не вибрано жодного рядка для видалення' });
                    } else {
                        bars.ui.confirm({ text: 'Ви дійсно бажаєте видалити параметр №' + data.Id },
                            function () {
                                dataSource.remove(data.Id, function () {
                                    bars.ui.notify('Параметр № ' + data.Id + ' видалено', '', 'success');
                                    if (type === 'GLOBAL') {
                                        tresholdGlobalGridRefresh();
                                    } else {
                                        tresholdGridRefresh();
                                    }

                                });
                            });
                    }
                }
            };

            $scope.clorPickerOptions = {
                width: '55px',
                palette: 'websafe'
            }
            $scope.tresholdGridGlobalToolbar = {
                resizable: false,
                items: [
                    {
                        type: "button",
                        text: '<i class="pf-icon pf-16 pf-add_button"></i>Створити',
                        click: function () {
                            toolbarWindows.add('GLOBAL');
                        }
                    },
                    {
                        type: "button",
                        text: '<i class="pf-icon pf-16 pf-tool_pencil"></i>Редагувати',
                        click: function () {
                            toolbarWindows.edit('GLOBAL');
                        }
                    },
                    {
                        type: "button",
                        text: '<i class="pf-icon pf-16 pf-delete_button_error"></i>Видалити',
                        click: function () {
                            toolbarWindows.remove('GLOBAL');
                        }
                    }
                ]
            }

            $scope.tresholdGridToolbar = {
                resizable: false,
                items: [
                    {
                        type: "button",
                        text: '<i class="pf-icon pf-16 pf-add_button"></i>Створити',
                        click: function () {
                            toolbarWindows.add('MFO');
                        }
                    },
                    {
                        type: "button",
                        text: '<i class="pf-icon pf-16 pf-tool_pencil"></i>Редагувати',
                        click: function () {
                            toolbarWindows.edit('MFO');
                        }
                    },
                    {
                        type: "button",
                        text: '<i class="pf-icon pf-16 pf-delete_button_error"></i>Видалити',
                        click: function () {
                            toolbarWindows.remove('MFO');
                        }
                    },
                    {
                        type: 'separator'
                    },
                    {
                        type: "button",
                        text: '<i class="pf-icon pf-16 pf-report_open"></i> Історія',
                        click: function () {
                            showHistoryWindow();
                        }
                    }

                ]
            }

            $scope.tresholdWindowOptions = {
                animation: false,
                visible: false,
                width: "500px",
                actions: ["Maximize", "Minimize", "Close"],
                draggable: true,
                height: "500px",
                modal: true,
                pinned: false,
                resizable: true,
                title: '',
                position: 'center',
                activate: function () {
                    this.wrapper.addClass('with-footer');
                    this.wrapper.append(this.wrapper.find('.k-window-footer').addClass('k-content'));
                },
                buttons: [
                    {
                        text: 'Відмінити',
                        click: function () { this.close(); }
                    },
                    {
                        text: '<span class="k-icon k-i-tick"></span> Ok',
                        click: function () {
                            if (func) {
                                func.apply();
                                this.close();
                            }
                        },
                        cssClass: 'k-primary'
                    }
                ],
                close: function () {
                    if ($scope.tresholdWindow.type === 'GLOBAL') {
                        tresholdGlobalGridRefresh();
                    } else {
                        tresholdGridRefresh();
                    }
                },
                iframe: false
            };

            $scope.saveTreshold = function () {
                if ($scope.validate()) {
                    if ($scope.treshold.Id == null) {
                        dataSource.add($scope.treshold, function (request) {
                            bars.ui.notify('Параметр збережено.', '№ ' + request.Id, 'success');
                            $scope.tresholdGrid.dataSource.read();
                            $scope.tresholdGrid.refresh();
                            $scope.tresholdWindow.close();
                        });
                    } else {
                        dataSource.edit($scope.treshold, function () {
                            bars.ui.notify('Параметр № ' + $scope.treshold.Id + ' збережено.', '', 'success');
                            $scope.tresholdGrid.dataSource.read();
                            $scope.tresholdGrid.refresh();
                            $scope.tresholdWindow.close();
                        });
                    }
                }

            }

            $scope.dateStartOptions = {
                format: '{0:dd/MM/yyyy HH:mm}',
                mask: '00/00/0000 00:00',
                min: new Date(1900, 0, 1)
            }
            $scope.dateStopOptions = {
                format: '{0:dd/MM/yyyy HH:mm}',
                min: new Date(1900, 0, 1),
                change: function () {
                    $scope.dateStart.max(this.value());
                }
            }

            $scope.tresholdGridOptions = {
                dataSource: {
                    group: {
                        field: "Mfo",
                        dir: "asc"
                    },
                    pageSize: 10,
                    serverPaging: true,
                    serverSorting: true,
                    type: 'webapi',
                    sort: {
                        field: "Mfo",
                        dir: "asc"
                    },
                    transport: {
                        read: {
                            url: dataSource.url,
                            dataType: 'json',
                            data: { date: function () { return $scope.date; } }
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: {
                            fields: {
                                Id: { type: 'number' },
                                LimitType: { type: 'string' },
                                DeviationPercent: { type: 'number' },
                                ViolationDeys: { type: 'number' },
                                ViolationColor: { type: 'string' },
                                DateStart: { type: 'date' },
                                Mfo: { type: 'number' },
                                DateSet: { type: 'date' },
                                DateUpdate: { type: 'date' },
                                NacCurrencyFlag: {type: 'number'}
                            }
                        }
                    }
                },
                columns: [
                    {
                        field: "Mfo",
                        title: "МФО",
                        width: "80px",
                        groupHeaderTemplate: "МФО: #= data.value # "
                    }, {
                        field: "LimitType",
                        title: "Тип ліміту",
                        template: function(dataItem) {
                            if (dataItem.LimitType === 'CASH') {
                                return 'Каса МФО';
                            }
                            if (dataItem.LimitType === 'BRANCH') {
                                return 'Каса ТВБВ';
                            }
                            return '';
                        },
                        width: "100px"
                    }, {
                        field: "NacCurrencyFlag",
                        title: "Приизнак нац. вал.",
                        filterable: false,
                        template: function (dataItem) {
                            if (typeof dataItem.NacCurrencyFlag === "undefined") {
                                return '';
                            }
                            if (dataItem.NacCurrencyFlag == 0) {
                                return '<input type="checkbox" disabled checked />';
                            } else {
                                return '<input type="checkbox" disabled />';
                            }
                        },
                        width: "120px" 
                    },{
                        field: "DeviationPercent",
                        title: "Допустимий % порушення",
                        width: "120px"
                    }, {
                        field: "ViolationDeys",
                        title: "К-ть допустимих <br> днів порушення",
                        template: '#= ViolationDeys && LimitType != "ATM" ? ViolationDeys : "" #',
                        width: "120px"
                    }, {
                        field: "DateStart",
                        title: "Початок<br> дії",
                        format: '{0:dd/MM/yyyy HH:mm}',
                        width: "120px"
                    }, {
                        field: "DateSet",
                        title: "Дата<br> створення",
                        format: '{0:dd/MM/yyyy HH:mm}',
                        width: "120px"
                    }, {
                        field: "ViolationColor",
                        title: "Колір при<br> порушенні",
                        template: '<div style="font-weight: bold;color:#=ViolationColor#">#= ViolationColor ? ViolationColor : "" #</div>',
                        width: "120px"
                    } 
                ],
                sortable: true,
                filterable: true,
                resizable: true,
                selectable: "single",
                pageable: {
                    refresh: true,
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 5
                }
            };


            var tresholgGridOptionsBase = {
                fields: {
                    Id: { type: 'number' },
                    LimitType: { type: 'string' },
                    DeviationPercent: { type: 'number' },
                    ViolationDeys: { type: 'number' },
                    ViolationColor: { type: 'string' },
                    DateStart: { type: 'date' },
                    Mfo: { type: 'number' },
                    MfoName: { type: 'string' },
                    DateSet: { type: 'date' }
                }
            };


            $scope.tresholdGlobalGridOptions = {
                dataSource: {
                    pageSize: 10,
                    serverPaging: true,
                    serverSorting: true,
                    type: 'webapi',
                    sort: {
                        field: "Id",
                        dir: "desc"
                    },
                    transport: {
                        read: {
                            url: dataSource.url,
                            dataType: 'json',
                            data: { type: 'ATM', date: function () { return $scope.date; } }
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: {
                            fields: tresholgGridOptionsBase.fields
                        }
                    }
                },
                columns: [
                    {
                        field: "LimitType",
                        title: "Тип<br> ліміту",
                        width: "100px"
                    }, {
                        field: "ViolationDeys",
                        title: "К-ть днів за<br> які відоб. пор.",
                        template: '#= LimitType == "ATM" ? ViolationDeys : "" #',
                        width: "120px"
                    }, {
                        field: "ViolationColor",
                        title: "Колір при<br> порушенні",
                        template: '<div style="font-weight: bold;color:#=ViolationColor#">#=ViolationColor#</div>',
                        width: "120px"
                    }, {
                        field: "DateStart",
                        title: "Початок дії",
                        format: '{0:dd/MM/yyyy HH:mm}',
                        width: "120px"
                    },{
                        field: "DateSet",
                        title: "Дата створення",
                        format: '{0:dd/MM/yyyy HH:mm}',
                        width: "120px"
                    }
                ],
                sortable: true,
                filterable: true,
                resizable: true,
                selectable: "single",
                pageable: {
                    refresh: true,
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 5
                }
            };

            $scope.validate = function () {

                //хак для задізейбленого текстареа
                //орегінал - ":input:not(:button,[type=submit],[type=reset],[disabled],[readonly])[data-validate!=false]"
                $scope.validator._inputSelector = ":input:not(:button,[type=submit],[type=reset],[readonly])[data-validate!=false]";

                if ($scope.validator.validate()) {
                    $scope.validationMessage = "";
                    $scope.validationClass = "";
                    return true;
                } else {
                    $scope.validationMessage = "Перевірте правильність заповнення даних";
                    $scope.validationClass = "alert alert-danger";
                    return false;
                }
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
                    tresholdGridRefresh();
                },
                iframe: false
            }

            var datePattern = [
                "dd/MM/yyyy", "dd/MM/yyyy HH:mm", "dd/MM/yyyy HH:mm:ss", "dd/MM/yyyy H:mm:ss",
                "dd.MM.yyyy", "dd.MM.yyyy HH:mm", "dd.MM.yyyy HH:mm:ss", "dd.MM.yyyy H:mm:ss"
            ];

            var transportJsonObject = function(method) {
                this.url = dataSource.url;
                this.dataType = "json";
                this.type = method;
                this.complete = function() {
                    historyGridRefresh();
                };
                this.processData = false;
                this.headers = {
                    'Content-Type': 'application/json'
                };
                this.beforeSend = function() {
                    this.data.DateStart = kendo.parseDate(this.data.DateStart, datePattern);
                    this.data = kendo.stringify(this.data);
                };
            }

            $scope.historyGridOptions = {
                edit: function (e) {
                    $(e.sender.wrapper)
                        .find('tbody td [name="DateStart"]')
                        .data('kendoDatePicker')
                        .min(minDate);
                },
                autoBind: false,
                toolbar: ['create'],
                dataBound: function (e) {
                    $(e.sender.wrapper).find('tbody td.editing-controls.k-state-disabled').find('.k-button').hide();
                    bars.ext.kendo.grid.noDataRow(e);
                },
                dataSource:{
                    Mfo: '',
                    LimitType:'',
                    type: 'webapi',
                    sort: {
                        field: "DateStart",
                        dir: "desc"
                    },
                    transport: {
                        dataType: "json",
                        read: {
                            url: dataSource.url + '?id='
                        },
                        update: new transportJsonObject('POST'),
                        create: new transportJsonObject('POST')
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: {
                            id: 'Id',
                            fields: {
                                Id: { type: 'number', editable: false, defaultValue: null },
                                LimitType: {
                                    type: 'string',
                                    editable: false,
                                    defaultValue: function () { return $scope.historyGridOptions.dataSource.LimitType; }
                                },
                                DeviationPercent: {
                                    type: 'number',
                                    defaultValue: 1,
                                    validation: {
                                        min: 0,
                                        max: 999,
                                        required: true
                                    }
                                },
                                ViolationDeys: {
                                    type: 'number',
                                    defaultValue: 1,
                                    validation: {
                                        min: 0,
                                        max: 99,
                                        required: true
                                    }
                                },
                                ViolationColor: {
                                    type: 'string',
                                    defaultValue: '#FF0000'
                                },
                                DateStart: {
                                    type: 'date',
                                    editable: true,
                                    defaultValue: date,
                                    validation: {
                                        min: minDate,
                                        required: true,
                                        startdatevalidation: startdatevalidation
                                    }
                                },
                                Mfo: {
                                    type: 'number',
                                    editable: false,
                                    defaultValue: function () { return $scope.historyGridOptions.dataSource.Mfo; }
                                },
                                MfoName: { type: 'string', editable: false },
                                DateSet: { type: 'date', editable: false }
                            }
                        }
                    },
                    pageSize: 10,
                    serverPaging: true,
                    serverSorting: true
                },
                height: '500px',
                editable: 'inline',
                sortable: true,
                filterable: true,
                resizable: true,
                reorderable: true,
                selectable: "single",
                save: function (e) {
                    $scope.historyGridOptions.dataSource.date = kendo.toString(e.model.DateStart, "dd/MM/yyyy");
                },
                pageable: {
                    refresh: true,
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 5
                },
                columns: [
                    {
                        command: [
                        {
                            name: "edit",
                            imageClass: 'pf-icon pf-16 pf-tool_pencil'
                        },
                        {
                            name: "Видалити",
                            imageClass: 'pf-icon pf-16 pf-delete_button_error',
                            click: function(e) {
                                e.preventDefault();
                                var dataItem = this.dataItem($(e.target).closest("tr"));
                                var dateStr = kendo.toString(dataItem.DateStart, "dd/MM/yyyy");

                                bars.ui.confirm({
                                    text: 'Видалити параметр за ' + dateStr,
                                    func: function() {
                                        dataSource.remove(dataItem.Id, function() {
                                            historyGridRefresh();
                                        });
                                    }
                                });
                            }
                        }],
                        title: "&nbsp;",
                        width: "220px"
                    }, {
                        field: "DeviationPercent",
                        title: "Відсоток<br> відхилення",
                        format: '{0:n0}',
                        width: "120px"
                    }, {
                        field: "ViolationDeys",
                        title: "К-ть допуст.<br> днів",
                        template: '#= LimitType != "ATM" ? ViolationDeys : "" #',
                        format:'{0:n0}',
                        width: "120px",
                        filterable: bars.ext.kendo.grid.uiNumFilter
                    }, {
                        field: "ViolationColor",
                        title: "Колір при<br> порушенні",
                        template: '<div style="font-weight: bold;color:#=ViolationColor#">#=ViolationColor#</div>',
                        width: "120px",
                        editor: function (container, options) {
                            $("<input type='color' data-bind='value:" + options.field + "' />")
                                .appendTo(container)
                                .kendoColorPicker({
                                    width: '55px',
                                    palette: 'websafe'
                                });
                        }
                    }, {
                        field: "DateStart",
                        title: "Початок дії",
                        format: '{0:dd/MM/yyyy HH:mm}',
                        width: "120px",
                        editor: function (container, options) {
                            $('<input name="' + options.field + '" data-text-field="' + options.field + '" data-value-field="' + options.field + '" data-bind="value:' + options.field + '" data-format="' + options.format + '"/>')
                                    .appendTo(container)
                                    .kendoDatePicker({});
                        }
                    }, {
                        field: "DateSet",
                        title: "Дата створення",
                        format: '{0:dd/MM/yyyy HH:mm}',
                        width: "120px"
                    }
                ]

            }

        }]);