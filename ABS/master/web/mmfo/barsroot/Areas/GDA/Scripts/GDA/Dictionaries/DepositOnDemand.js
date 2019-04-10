var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("DepositOnDemand", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];

    var saveAction = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setdepositdemand"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            var grid = $("#depositdemandoptions").data().kendoGrid;
            var selectedRow = grid.select();
            //
            if (selectedRow.length > 0) {
                $scope.sItem = grid.dataItem(grid.select()).Id;
            }
            //
            return data;
        }
    };

    var saveCondition = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setdepositcondition"),
        data: function (data) {
            var grid = $("#depositdemandoptions").data().kendoGrid;
            var selectedRow = grid.select();
            //
            if (selectedRow.length > 0) {
                $scope.sItem = grid.dataItem(grid.select()).Id;
            }
            //
            var selectedDataItem = grid.dataItem(selectedRow);
            data.InterestOptionId = selectedDataItem.Id;
            return data;
        }
    };

    var DemandDepositDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getdepositdemandinfo"),
            },
            create: saveAction,
            update: saveAction
        },
        requestStart: function (e) {
            bars.ui.loader("body", false);
        },
        requestEnd: function (e) {
            if (e.type == "create") {
                bars.ui.notify("Повідомлення", "Новий строк дії умов доданий", 'success', { autoHideAfter: 5 * 1000 });
                bars.ui.loader("body", false);

                var gridOpt = $("#depositdemandoptions").data().kendoGrid;
                var gridCond = $('#depositdemandconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована.", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#depositdemandoptions").data().kendoGrid;
                var gridCond = $('#depositdemandconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            }

        },
        sort: { field: "ValidFrom", dir: "desc" },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                id: "Id",
                fields: {
                    Conditions: [],
                    Id: { type: 'string' },
                    ValidFrom: { type: 'date' },
                    IsActive: { type: 'number', validation: { required: true, min: 0, max: 1 } },
                    AmountFrom: { type: 'number', validation: { min: 0 } },
                    UserId: { type: 'string' },
                    SysTime: { type: 'string' }

                }
            }

        },
        serverFiltering: false, ////!!!!!
        serverPaging: false,
        serverSorting: false
    });

    $scope.DemandDepositGridOptions = $scope.createGridOptions({
        dataSource: DemandDepositDataSource,
        dataBound: function (e) {
            if ($scope.sItem) {
                var dataItem = this.dataSource.get($scope.sItem);
                if (dataItem == null) {
                    return;
                } else {
                    this.select($('[data-uid=' + dataItem.uid + ']'));
                }
            }
            var rows = e.sender.tbody.children();
            for (var j = 0; j < rows.length; j++) {
                var row = $(rows[j]);
                var dataItem = e.sender.dataItem(row);

                if (dataItem.get("IsActive") == "1") {
                    row.addClass("classActive");
                } else {
                    row.addClass("classClose");
                }
            }
        },
        height: 300,
        selectable: "row",
        editable: 'inline',
        sortable: true,
        excel: {
            allPages: true,
            filterable: false,
            proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/")
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            for (var i = 0; i < sheet.columns.length; i++) {
                sheet.columns[i].width = 150;
            }
        },
        columns: [
            {
                field: "ValidFrom",
                title: "Дата від",
                format: "{0:dd-MM-yyyy}"
            },
            {
                field: "IsActive",
                title: "Активна",
                values: activeOptions,
                editor: function (container, options) {
                    var input = $('<input data-text-field="text" data-value-field="value" data-bind="value: ' + options.field + '" name="' + options.field + '"/>');
                    input.appendTo(container);
                    input.kendoDropDownList({
                        dataTextField: "text",
                        dataValueField: "value",
                        dataSource: activeOptions
                    });
                }
            }
        ],
        change: function (e) {
            var data = this.dataItem(this.select());
            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data && data.Conditions != null) {
                var dataArray = $.map(data.Conditions, function (value, index) {
                    return [value];
                });
                //
                var editRow = this.dataItem('tr.k-grid-edit-row');
                if (!editRow) {
                    $('#depositdemandconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#depositdemandconditions').data('kendoGrid').dataSource.data([]);
                $('#depositdemandconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#addConditionDepositDemand', '#depositdemandoptionsEdit'], false);

            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }
            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('depositdemandoptions', ['#saveConditionDepositDemand', '#cancelConditionDepositDemand'], ['#cancelOptionDepositDemand', '#saveOptionDepositDemand'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabDemand', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('depositdemandoptions', ['#saveConditionDepositDemand', '#cancelConditionDepositDemand'], ['#cancelOptionDepositDemand', '#saveOptionDepositDemand'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabDemand', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });

    $("#exportToExcelDepositDemand").click(function () {
        var grid = $("#depositdemandoptions").data("kendoGrid");

        var selectedRow = grid.dataItem(grid.select());
        if (selectedRow == null) {
            bars.ui.alert({ text: "Щоб завантажити дані у Excel оберіть строк дії та ще раз натисніть цю кнопку" });
        } else {
            var rowsOpt = [{
                cells: [
                    { value: "Дата від" },
                    { value: "Статус" }
                ]
            }];
            var rowsCond = [{
                cells: [
                    { value: "Валюта" },
                    { value: "Сума від" },
                    { value: "Ставка" },
                ]
            }];

            if (grid.dataItem(grid.select()).Conditions != null) {
                rowsOpt.push({
                    cells: [
                        { value: grid.dataItem(grid.select()).ValidFrom },
                        { value: grid.dataItem(grid.select()).IsActive ? 'Активна' : 'Неактивна' }
                    ]
                });
                for (var i = 0; i < grid.dataItem(grid.select()).Conditions.length; i++) {
                    rowsCond.push({
                        cells: [
                            { value: grid.dataItem(grid.select()).Conditions[i].Currency },
                            { value: +grid.dataItem(grid.select()).Conditions[i].AmountFrom },
                            { value: +grid.dataItem(grid.select()).Conditions[i].InterestRate, format: "0.00" }
                        ]
                    });
                }
                var newArr = rowsOpt.concat(rowsCond);
            } else {
                rowsOpt.push({
                    cells: [
                        { value: grid.dataItem(grid.select()).ValidFrom },
                        { value: grid.dataItem(grid.select()).IsActive ? 'Активна' : 'Неактивна' }
                    ]
                });
                var newArr = rowsOpt;
            }

            var workbook = new kendo.ooxml.Workbook({
                sheets: [
                    {
                        columns: [
                            { autoWidth: true },
                            { autoWidth: true }
                        ],
                        title: "Процентні ставки по Вкладу на вимогу",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Процентні ставки по Вкладу на вимогу.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") });
        }
    });


    function Cancel() {
        var grid = $("#depositdemandoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#depositdemandconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#depositdemandconditions').data('kendoGrid').refresh();
                $('#depositdemandoptions').data('kendoGrid').dataSource.read();
            }
        }
    }

    $('#addOptionDepositDemand').click(function (e) {
        enableDisableButtons(['#cancelOptionDepositDemand', '#saveOptionDepositDemand'], false);
        enableDisableButtons(['#depositdemandoptionsEdit', '#addConditionDepositDemand', '#depositdemandconditionsEdit', '#saveConditionDepositDemand', '#exportToExcelDepositDemand', '#addOptionDepositDemand'], true);
        var grid = $("#depositdemandoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabDemand', true);
        $('#depositdemandconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#depositdemandoptionsEdit,#depositdemandconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isDepositOptions = id === 'depositdemandoptions';
        if (selected.length == 0) {
            var toDisableIds = isDepositOptions ? ['#cancelOptionDepositDemand'] : ['#cancelConditionDepositDemand'];
            var toEnableIds = isDepositOptions ? ['#addOptionDepositDemand'] : ['#addConditionDepositDemand'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {

            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isDepositOptions ? ['#cancelOptionDepositDemand', '#saveOptionDepositDemand'] : ['#addConditionDepositDemand', '#addOptionDepositDemand', '#depositdemandoptionsEdit', '#saveOptionDepositDemand', '#depositdemandconditionsEdit', '#cancelOptionDepositDemand'];
            var toEnableIds = isDepositOptions ? ['#addOptionDepositDemand', '#depositdemandconditionsEdit', '#saveConditionDepositDemand', '#addConditionDepositDemand', '#depositdemandoptionsEdit', '#exportToExcelDepositDemand'] : ['#cancelConditionDepositDemand', '#saveConditionDepositDemand'];

            if (isDepositOptions) {
                if (checkEdit('depositdemandoptions', ['#saveConditionDepositDemand', '#cancelConditionDepositDemand'], ['#cancelOptionDepositDemand', '#saveOptionDepositDemand'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabDemand', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabDemand', true);
                }
            }
            else {
                if (checkEdit('depositdemandoptions', ['#saveConditionDepositDemand', '#cancelConditionDepositDemand'], ['#cancelOptionDepositDemand', '#saveOptionDepositDemand'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabDemand', true);
                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabDemand', true);
                }
            }
        }
    });
    $('#saveOptionDepositDemand').click(function () {
        enableDisableButtons(['#cancelOptionDepositDemand', '#depositdemandoptionsEdit', '#addConditionDepositDemand', '#saveOptionDepositDemand'], true);
        enableDisableButtons(['#addOptionDepositDemand', '#exportToExcelDepositDemand'], false);
        var grid = $("#depositdemandoptions").data("kendoGrid");
        grid.saveRow();
        $('#depositdemandoptions').data('kendoGrid').dataSource.read();
        $('#depositdemandoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabDemand', false);
    });

    $('#cancelOptionDepositDemand').click(function () {
        var grid = $("#depositdemandoptions").data("kendoGrid");
        grid.cancelRow();
        grid.dataSource.read();
        enableDisableButtons(['#cancelOptionDepositDemand', '#addConditionDepositDemand', '#saveConditionDepositDemand', '#cancelConditionDepositDemand', '#saveOptionDepositDemand'], true);
        enableDisableButtons(['#addOptionDepositDemand', '#depositdemandoptionsEdit', '#exportToExcelDepositDemand'], false);
        $('#depositdemandconditions').data('kendoGrid').dataSource.data([]);
        $("#depositdemandconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabDemand', false);
    });

    $('#addConditionDepositDemand').click(function (e) {
        enableDisableButtons(['#depositdemandconditionsEdit', '#addOptionDepositDemand', '#depositdemandoptionsEdit', '#saveOptionDepositDemand', '#cancelOptionDepositDemand', '#exportToExcelDepositDemand', '#addConditionDepositDemand'], true);
        enableDisableButtons(['#cancelConditionDepositDemand', '#saveConditionDepositDemand'], false);

        if (checkEdit('depositdemandoptions', ['#saveConditionDepositDemand', '#cancelConditionDepositDemand'], ['#cancelOptionDepositDemand', '#saveOptionDepositDemand'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
            disableTabsInEditMode('tabDemand', true);
        } else {
            var grid = $("#depositdemandconditions").data("kendoGrid");
            var gridOpt = $("#depositdemandoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
        }
    });
    $('#saveConditionDepositDemand').click(function () {
        var gridOpt = $("#depositdemandoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionDepositDemand', '#addOptionDepositDemand', '#depositdemandoptionsEdit', '#addConditionDepositDemand', '#exportToExcelDepositDemand'], false);
            enableDisableButtons(['#cancelConditionDepositDemand', '#saveConditionDepositDemand', '#cancelOptionDepositDemand', '#saveOptionDepositDemand'], true);
            var grid = $("#depositdemandconditions").data("kendoGrid");
            grid.saveRow();
            disableTabsInEditMode('tabDemand', false);
        } else {
            return;
        }
    });
    $('#cancelConditionDepositDemand').click(function () {
        var gridOpt = $("#depositdemandoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionDepositDemand', '#depositdemandoptionsEdit', '#addOptionDepositDemand', '#depositdemandoptionsEdit', '#addConditionDepositDemand'], false);
            enableDisableButtons(['#cancelConditionDepositDemand', '#saveConditionDepositDemand'], true);
            var grid = $("#depositdemandconditions").data("kendoGrid");
            grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabDemand', false);
        } else {
            return;
        }
    });

    var DepositDemandConditionsDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            create: saveCondition,
            update: saveCondition
        },
        requestEnd: function (e) {

            bars.ui.loader('body', false);
            if (e.type == "create") {
                bars.ui.notify("Повідомлення", "Створена нова умова для обраного запису", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#depositdemandoptions").data().kendoGrid;
                var gridCond = $('#depositdemandconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#depositdemandoptions").data().kendoGrid;
                var gridCond = $('#depositdemandconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#depositdemandoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#depositdemandoptionsEdit', '#saveOptionDepositDemand', '#addConditionDepositDemand', '#depositdemandconditionsEdit'], true);
                    if (checkEdit('depositdemandconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabDemand', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#depositdemandoptionsEdit', '#saveOptionDepositDemand', '#addConditionDepositDemand', '#depositdemandconditionsEdit', '#addOptionDepositDemand'], true);
                    enableDisableButtons(['#cancelConditionDepositDemand', '#saveConditionDepositDemand'], false);
                }
            }
        },
        schema: {
            model: {
                id: "Id",
                fields: {
                    Id: { type: 'string' },
                    InterestOptionId: { type: 'string' },
                    CurrencyId: { type: 'number' },
                    Currency: { type: 'string' },
                    AmountFrom: { type: 'number', validation: { min: 0 } },
                    InterestRate: { type: 'number', validation: { min: 0, max: 100 } }
                }
            }
        },
        serverFiltering: false,
        serverPaging: true,
        serverSorting: false
    });
    //var secondDatasource = new kendo.data.DataSource();

    $scope.numberWithSpaces = function (x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
    }
    $scope.DepositDemandConditionsGridOptions = $scope.createGridOptions({
        dataSource: DepositDemandConditionsDataSource,
        height: 300,
        selectable: "row",
        editable: 'inline',
        sortable: true,
        columns: [
            {
                field: "CurrencyId",
                title: "Валюта",
                template: "#=Currency# | #=CurrencyId# ",
                width: 180,
                editor: function (container, options) {
                    var input = $('<input data-text-field="lcv" data-value-field="kv" data-bind="value: ' + options.field + '" name="' + options.field + '"/>');
                    input.appendTo(container);
                    //init drop
                    input.kendoDropDownList({
                        autoBind: true,
                        dataTextField: "lcv",
                        dataValueField: "kv",
                        filter: 'contains',
                        template: '#: kv # | #: lcv #',
                        dataSource: {
                            transport: {
                                read: {
                                    type: "GET",
                                    dataType: "json",
                                    url: bars.config.urlContent("/api/gda/gda/getcurrency")
                                }
                            },
                            schema: {
                                data: "Data",
                                model: {
                                    fields: {
                                        kv: { type: 'string' }
                                    }
                                }
                            }
                        },
                        filtering: function (ev) {
                            var filterValue = ev.filter != undefined ? ev.filter.value : "";
                            ev.preventDefault();
                            var intval = parseInt(filterValue);
                            this.dataSource.filter({
                                logic: "or",
                                filters: [
                                    { field: 'kv', operator: 'startswith', value: intval.toString() },
                                    { field: 'lcv', operator: 'contains', value: filterValue }
                                ]
                            });
                        },
                        optionLabel: {
                            lcv: "Оберіть валюту",
                            kv: null
                        }
                    });
                },
                sortable: {
                    compare: function (a, b) {
                        return a.CurrencyId - b.CurrencyId;
                    }
                }
            },
            {
                field: "AmountFrom",
                title: "Сума від",
                sortable: {
                    compare: function (a, b) {
                        return a.AmountFrom - b.AmountFrom;
                    }
                },
                template: function (dataItem) {
                    if (dataItem.AmountFrom < 0) {
                        dataItem.AmountFrom = dataItem.AmountFrom.toString();
                        var arr = dataItem.AmountFrom.split("");
                        if (arr[1] == '.') {
                            arr.splice(1, 0, '0');
                            var newArr = arr.join('');
                            return "<span>" + newArr + "</span>";
                        } else if (arr[1] != ".") {
                            var newArr = arr.join('');
                            return "<span>" + newArr + "</span>"
                        } else {
                            return "<span>" + dataItem.AmountFrom + "</span>"
                        }
                    } else if (dataItem.AmountFrom < 1 && dataItem.AmountFrom > 0) {
                        return "<span>" + "0" + dataItem.AmountFrom + "</span>";
                    } else {
                        return "<span>" + dataItem.AmountFrom + "</span>";
                    }
                }
            },
            {
                field: "InterestRate",
                title: "Ставка",
                sortable: {
                    compare: function (a, b) {
                        return a.InterestRate - b.InterestRate;
                    }
                },
                template: function (dataItem) {
                    if (dataItem.InterestRate < 0) {
                        dataItem.InterestRate = dataItem.InterestRate.toString();
                        var arr = dataItem.InterestRate.split("");
                        if (arr[1] == '.') {
                            arr.splice(1, 0, '0');
                            var newArr = arr.join('');
                            return "<span>" + newArr + "</span>";
                        } else if (arr[1] != ".") {
                            var newArr = arr.join('');
                            return "<span>" + newArr + "</span>"
                        } else {
                            return "<span>" + dataItem.InterestRate + "</span>"
                        }
                    } else if (dataItem.InterestRate < 1 && dataItem.InterestRate > 0) {
                        return "<span>" + "0" + dataItem.InterestRate + "</span>";
                    } else {
                        return "<span>" + dataItem.InterestRate + "</span>";
                    }
                }
            }
        ],
        save: function (e) {
            var model = e.model;
            var ddl = $("input[name=CurrencyId]").data("kendoDropDownList");
            model.Currency = ddl.text();
        },
        filterMenuInit: function (e) {
            var filterButton = $(e.container).find('.k-primary'),
                resetButton = $(e.container).find('.k-button');

            //очистити
            $(resetButton).click(function (e) {
                setTimeout("$('#depositdemandoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#depositdemandoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {
            var data = this.dataItem(this.select());
            var currency = data.Currency;
            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (currency === null || currency === '') {
                enableDisableButtons(['#saveOptionDepositDemand', '#cancelOptionDepositDemand'], false);
                enableDisableButtons(['#depositdemandoptionsEdit'], true);
            } else {
                enableDisableButtons(['#depositdemandoptionsEdit'], true);
                enableDisableButtons(['#depositdemandconditionsEdit', '#addConditionDepositDemand'], false);
            }

            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('depositdemandconditions', ['#addConditionDepositDemand', '#depositdemandconditionsEdit', '#saveOptionDepositDemand', '#cancelOptionDepositDemand'], ['#saveConditionDepositDemand', '#cancelConditionDepositDemand'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabDemand', true);

                    } else if (checkEdit('depositdemandoptions', ['#saveConditionDepositDemand', '#cancelConditionDepositDemand'], ['#cancelOptionDepositDemand', '#saveOptionDepositDemand'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabDemand', true);
                    }
                }
            } else {
                return;
            }

        }
    });

    $("#depositdemandconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#depositdemandoptions').data('kendoGrid').trigger('change')", 1);
    });
});

// disabled = true - заблокировать кнопку
// array - список ИД кнопок
function enableDisableButtons(array, disable) {
    if (Array && Array.isArray && Array.isArray(array) || Object.prototype.toString.call(array) === '[object Array]') {
        if (disable) {
            for (var i = 0; i < array.length; ++i)
                $(array[i]).prop('disabled', 'disabled');
        }
        else {
            for (var i = 0; i < array.length; ++i)
                $(array[i]).prop('disabled', false);
        }
    }
}

function checkEdit(grid, disableBtn, enableBtn, e) {

    var grid = $('#' + grid).closest(".k-grid");
    var editRow = grid.find(".k-grid-edit-row");
    if (editRow.length > 0) {
        enableDisableButtons(enableBtn, false);
        enableDisableButtons(disableBtn, true);
        e.preventDefault();
        return true;
    } else {
        return false;
    }

}

//action - true - disabled, false - enabled
function disableTabsInEditMode(tabActive, action) {
    var tabStrip = $("#tabStripDictDemand").kendoTabStrip().data("kendoTabStrip");
    var index = {
        'tabDemand': '0',
        'tabDemandCalc': '1',

    };
    delete index[tabActive];

    var count = 0;
    for (a in index) {
        if (index.hasOwnProperty(a)) {
            count++;
        }
    }
    for (var key in index) if (index.hasOwnProperty(key)) break;
    var f = index[key];

    for (i = f; i <= count; i++) {
        if (action == true) {
            tabStrip.disable(tabStrip.tabGroup.children().eq(i));
        } else {
            tabStrip.enable(tabStrip.tabGroup.children().eq(i));
        }
    }
}