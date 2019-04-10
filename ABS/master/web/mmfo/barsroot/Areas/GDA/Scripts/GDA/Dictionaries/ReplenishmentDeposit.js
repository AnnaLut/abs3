var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("ReplenishmentDeposit", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер      

    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }],
        isreplenishmentOptions = [{ value: 1, text: "Так" }, { value: 0, text: "Ні" }];

    var saveGeneral = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setreplenishmentoption"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            data.ValidThough = kendo.toString(data.ValidThough, "yyyy-MM-dd");
            var grid = $("#replenishmentdepositoptions").data().kendoGrid;
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
        url: bars.config.urlContent("/api/gda/gda/setreplenishmentcondition"),
        data: function (data) {
            var grid = $("#replenishmentdepositoptions").data().kendoGrid;
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

    var ReplenishmentDepositDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getreplenishmentinfo")
            },
            create: saveGeneral,
            update: saveGeneral
        },
        requestEnd: function (e) {
            bars.ui.loader("body", false);
            if (e.type == "create") {
                bars.ui.notify("Повідомлення", "Новий строк дії умов доданий", 'success', { autoHideAfter: 5 * 1000 });
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Cтрок дії умов відредагований", 'success', { autoHideAfter: 5 * 1000 });
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                id: "Id",
                fields: {
                    Conditions: [],
                    ValidFrom: { type: 'date' },
                    ValidThough: { type: 'date', validation: { nullable: true } },
                    IsActive: { type: 'number', validation: { required: true, min: 0, max: 1 } },
                    UserId: { type: 'string' },
                    SysTime: { type: 'string' },
                    Id: { type: 'string' }
                }
            }
        },
        serverFiltering: false, ////!!!!!
        serverPaging: false,
        serverSorting: false
    });

    var ReplenishmentDepositConditionDataSource = $scope.createDataSource({
        type: "json",
        pageSize: 100,
        transport: {
            create: saveCondition,
            update: saveCondition
        },
        requestEnd: function (e) {
            bars.ui.loader('body', false);
            if (e.type == "create") {
                bars.ui.notify("Повідомлення", "Створена нова умова для обраного запису", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#replenishmentdepositoptions").data().kendoGrid;
                var gridCond = $('#replenishmentdepositconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#replenishmentdepositoptions").data().kendoGrid;
                var gridCond = $('#replenishmentdepositconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#replenishmentdepositoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#saveOptionReplenishmentDeposit', '#addConditionReplenishmentDeposit', '#replenishmentdepositconditionsEdit'], true);
                    if (checkEdit('replenishmentdepositconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabReplenishment', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#addOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit', '#addConditionReplenishmentDeposit', '#replenishmentdepositconditionsEdit', '#addOptionReplenishmentDeposit','#replenishmentdepositoptionsEdit'], true);
                    enableDisableButtons(['#cancelConditionReplenishmentDeposit', '#saveConditionReplenishmentDeposit'], false);
                }
            }
        },
        schema: {
            model: {
                id: "Id",
                fields: {
                    Id: { type: 'string' },
                    InterestOptionId: { type: 'string' },
                    CurrencyId: { type: 'string' },
                    Currency: { type: 'string' },
                    InterestRate: { type: 'number' },
                    IsReplenishment: { type: 'number' },
                }
            }
        },
        serverFiltering: false,
        serverPaging: true,
        serverSorting: false
    });


    $scope.ReplenishmentDepositGridOptions = $scope.createGridOptions({
        dataSource: ReplenishmentDepositDataSource,
        dataBound: function (e) {
            $('#replenishmentdepositconditions').removeProp('disabled');
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
        selectable: true,
        editable: 'inline',
        filterable: true,
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
                field: "ValidThough",
                title: "Дата до",
                format: "{0:dd-MM-yyyy}"
            },
            {
                field: "IsActive",
                title: "Статус",
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
            if (data && data.Conditions != null) {
                var dataArray = $.map(data.Conditions, function (value, index) {
                    return [value];
                });
                //
                var editRow = this.dataItem('tr.k-grid-edit-row');
                if (!editRow) {
                    $('#replenishmentdepositconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#replenishmentdepositconditions').data('kendoGrid').dataSource.data([]);
                $("#replenishmentdepositconditions").data("kendoGrid").refresh();
            }
            enableDisableButtons(['#addConditionReplenishmentDeposit', "#replenishmentdepositoptionsEdit"], false);
            enableDisableButtons(['#cancelConditionBase'], true);

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }
            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('replenishmentdepositoptions', ['#saveConditionReplenishmentDeposit', '#cancelConditionReplenishmentDeposit'], ['#cancelOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabReplenishment', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('replenishmentdepositoptions', ['#saveConditionReplenishmentDeposit', '#cancelConditionReplenishmentDeposit'], ['#cancelOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabReplenishment', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });

    $("#exportToExcelReplenishmentDeposit").click(function () {
        var grid = $("#replenishmentdepositoptions").data("kendoGrid");

        var selectedRow = grid.dataItem(grid.select());
        if (selectedRow == null) {
            bars.ui.alert({ text: "Щоб завантажити дані у Excel оберіть строк дії та ще раз натисніть цю кнопку" });
        } else {
            var rowsOpt = [{
                cells: [
                    { value: "Дата від" },
                    { value: "Дата до" },
                    { value: "Статус" },
                ]
            }];
            var rowsCond = [{
                cells: [
                    { value: "Валюта" },
                    { value: "Поповнення" },
                    { value: "Ставка" },
                ]
            }];

            if (grid.dataItem(grid.select()).Conditions != null) {
                rowsOpt.push({
                    cells: [
                        { value: grid.dataItem(grid.select()).ValidFrom },
                        { value: grid.dataItem(grid.select()).ValidThough },
                        { value: grid.dataItem(grid.select()).IsActive ? 'Активна' : 'Неактивна' }
                    ]
                });
                for (var i = 0; i < grid.dataItem(grid.select()).Conditions.length; i++) {
                    rowsCond.push({
                        cells: [
                            { value: grid.dataItem(grid.select()).Conditions[i].Currency },
                            { value: +grid.dataItem(grid.select()).Conditions[i].IsReplenishment ? 'Так' : 'Ні' },
                            { value: +grid.dataItem(grid.select()).Conditions[i].InterestRate, format: "0.00" }
                        ]
                    });
                }
                var newArr = rowsOpt.concat(rowsCond);
            } else {
                rowsOpt.push({
                    cells: [
                        { value: grid.dataItem(grid.select()).ValidFrom },
                        { value: grid.dataItem(grid.select()).ValidThough },
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
                        title: "Поповнення по депозиту ММСБ",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Поповнення по депозиту ММСБ.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") });
        }
    });

    function Cancel() {
        var grid = $("#replenishmentdepositoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#replenishmentdepositconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#replenishmentdepositconditions').data('kendoGrid').refresh();
                $('#replenishmentdepositoptions').data('kendoGrid').dataSource.read();
            }
        }
    }

    $('#addOptionReplenishmentDeposit').click(function () {
        enableDisableButtons(['#cancelOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit'], false);
        enableDisableButtons(['#replenishmentdepositoptionsEdit', '#addConditionReplenishmentDeposit', '#replenishmentdepositconditionsEdit', '#saveConditionReplenishmentDeposit', '#exportToExcelReplenishmentDeposit', '#addOptionReplenishmentDeposit'], true);
        var grid = $("#replenishmentdepositoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabReplenishment', true);
        $('#replenishmentdepositconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#saveOptionReplenishmentDeposit').click(function () {
        enableDisableButtons(['#cancelOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit', '#replenishmentdepositoptionsEdit', '#addConditionReplenishmentDeposit'], true);
        enableDisableButtons(['#addOptionReplenishmentDeposit', '#exportToExcelReplenishmentDeposit'], false);
        var grid = $("#replenishmentdepositoptions").data("kendoGrid");
        grid.saveRow();

        $('#replenishmentdepositoptions').data('kendoGrid').dataSource.read();
        $('#replenishmentdepositoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabReplenishment', false);
    });
    $('#cancelOptionReplenishmentDeposit').click(function () {
        enableDisableButtons(['#cancelOptionReplenishmentDeposit', '#addConditionReplenishmentDeposit', '#saveConditionReplenishmentDeposit', '#cancelConditionReplenishmentDeposit', '#replenishmentdepositconditions', '#saveOptionReplenishmentDeposit'], true);
        enableDisableButtons(['#addOptionReplenishmentDeposit', '#replenishmentdepositoptionsEdit','#exportToExcelReplenishmentDeposit'], false);
        var grid = $("#replenishmentdepositoptions").data("kendoGrid");
        grid.cancelRow();
        grid.dataSource.read();
        $('#replenishmentdepositconditions').data('kendoGrid').dataSource.data([]);
        $("#replenishmentdepositconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabReplenishment', false);
    });

    $('#addConditionReplenishmentDeposit').click(function (e) {
        enableDisableButtons(['#replenishmentdepositconditionsEdit', '#addOptionReplenishmentDeposit', '#replenishmentdepositoptionsEdit', '#saveOptionReplenishmentDeposit', '#cancelOptionReplenishmentDeposit', '#addConditionReplenishmentDeposit', '#exportToExcelReplenishmentDeposit'], true);
        enableDisableButtons(['#cancelConditionReplenishmentDeposit', '#saveConditionReplenishmentDeposit'], false);
        if (checkEdit('replenishmentdepositoptions', ['#saveConditionReplenishmentDeposit', '#cancelConditionReplenishmentDeposit'], ['#cancelOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#replenishmentdepositconditions").data("kendoGrid");
            var gridOpt = $("#replenishmentdepositoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabReplenishment', true);
        }
    });

    $('#replenishmentdepositoptionsEdit,#replenishmentdepositconditionsEdit').click(function (event) {

        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isGeneralOptions = id === 'replenishmentdepositoptions';
        if (selected.length == 0) {
            var toDisableIds = isGeneralOptions ? ['#cancelOptionReplenishmentDeposit'] : ['#cancelConditionReplenishmentDeposit'];
            var toEnableIds = isGeneralOptions ? ['#addOptionReplenishmentDeposit'] : ['#addConditionReplenishmentDeposit'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isGeneralOptions ? ['#cancelOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit'] : ['#addConditionReplenishmentDeposit', '#addOptionReplenishmentDeposit', '#replenishmentdepositoptionsEdit', '#saveOptionReplenishmentDeposit', '#cancelOptionReplenishmentDeposit'];
            var toEnableIds = isGeneralOptions ? ['#addOptionReplenishmentDeposit', '#replenishmentdepositconditionsEdit', '#saveConditionReplenishmentDeposit', '#addConditionReplenishmentDeposit', '#exportToExcelReplenishmentDeposit'] : ['#cancelConditionReplenishmentDeposit', '#saveConditionReplenishmentDeposit'];

            if (isGeneralOptions) {
                if (isGeneralOptions) {
                    if (checkEdit('replenishmentdepositoptions', ['#saveConditionReplenishmentDeposit', '#cancelConditionReplenishmentDeposit'], ['#cancelOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit'], event) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabReplenishment', true);
                    } else {
                        enableDisableButtons(toDisableIds, inEdit);
                        enableDisableButtons(toEnableIds, !inEdit);
                        grid.editRow(selected);
                        disableTabsInEditMode('tabReplenishment', true);
                    }
                }
            } else {
                    if (checkEdit('replenishmentdepositoptions', ['#saveConditionReplenishmentDeposit', '#cancelConditionReplenishmentDeposit'], ['#cancelOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit'], event) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabReplenishment', true);
                    } else {
                        enableDisableButtons(toDisableIds, !inEdit);
                        enableDisableButtons(toEnableIds, inEdit);
                        grid.editRow(selected);
                        disableTabsInEditMode('tabReplenishment', true);
                    }
                }
        }
    });
    $('#saveConditionReplenishmentDeposit').click(function () {
        var gridOpt = $("#replenishmentdepositoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionReplenishmentDeposit', '#replenishmentdepositoptionsEdit', '#addConditionReplenishmentDeposit', '#exportToExcelReplenishmentDeposit'], false);
            enableDisableButtons(['#cancelConditionReplenishmentDeposit', '#saveOptionReplenishmentDeposit', '#cancelOptionReplenishmentDeposit', '#saveConditionReplenishmentDeposit', '#replenishmentdepositconditionsEdit'], true);
            var grid = $("#replenishmentdepositconditions").data("kendoGrid");
            grid.saveRow();
            disableTabsInEditMode('tabReplenishment', false);
        } else {
            return;
        }
    });
    $('#cancelConditionReplenishmentDeposit').click(function () {
        var gridOpt = $("#replenishmentdepositoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionReplenishmentDeposit', '#replenishmentdepositoptionsEdit', '#addConditionReplenishmentDeposit', '#replenishmentdepositconditionsEdit', '#exportToExcelReplenishmentDeposit'], false);
            enableDisableButtons(['#cancelConditionReplenishmentDeposit', '#saveConditionReplenishmentDeposit'], true);
            var grid = $("#replenishmentdepositconditions").data("kendoGrid");
            grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabReplenishment', false);
        } else {
            return;
        }
    });


    $scope.ReplenishmentDepositConditionsGridOptions = $scope.createGridOptions({
        dataSource: ReplenishmentDepositConditionDataSource,
        height: 300,
        selectable: "row",
        editable: 'inline',
        sortable: true,
        columns: [
            {
                field: "CurrencyId",
                title: "Валюта",
                width: 180,
                template: "#=Currency# | #=CurrencyId# ",
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
                field: "IsReplenishment",
                headerAttributes: { style: "text-align:center" },
                title: "Поповнення",
                width: 125,
                values: isreplenishmentOptions,
                editor: function (container, options) {
                    var input = $('<input data-text-field="text" data-value-field="value" data-bind="value: ' + options.field + '" name="' + options.field + '"/>');
                    input.appendTo(container);
                    input.kendoDropDownList({
                        dataTextField: "text",
                        dataValueField: "value",
                        dataSource: isreplenishmentOptions
                    });
                },
                sortable: {
                    compare: function (a, b) {
                        return a.IsReplenishment - b.IsReplenishment;
                    }
                }
            },
            {
                field: "InterestRate",
                headerAttributes: { style: "text-align:center" },
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
            //{ command: ["edit"], title: "&nbsp;", width: "250px" }
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
                setTimeout("$('#replenishmentdepositoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#replenishmentdepositoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {
            var data = this.dataItem(this.select());
            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#saveOptionReplenishmentDeposit', '#cancelOptionReplenishmentDeposit'], false);
                enableDisableButtons(['#replenishmentdepositoptionsEdit'], true);
            } else {
                enableDisableButtons(['#replenishmentdepositoptionsEdit'], true);
                enableDisableButtons(['#replenishmentdepositconditionsEdit', '#addConditionReplenishmentDeposit'], false);
            }
            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('replenishmentdepositconditions', ['#saveOptionReplenishmentDeposit', '#cancelOptionReplenishmentDeposit', '#addConditionReplenishmentDeposit', '#replenishmentdepositconditionsEdit'], ['#saveConditionReplenishmentDeposit', '#cancelConditionReplenishmentDeposit'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabReplenishment', true);

                    } else if (checkEdit('replenishmentdepositoptions', ['#saveConditionReplenishmentDeposit', '#cancelConditionReplenishmentDeposit'], ['#cancelOptionReplenishmentDeposit', '#saveOptionReplenishmentDeposit'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabReplenishment', true);
                    }
                }
            } else {
                return;
            }

        }
    });

    $("#replenishmentdepositconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#replenishmentdepositoptions').data('kendoGrid').trigger('change')", 1);
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