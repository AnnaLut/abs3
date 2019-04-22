var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("BlockRateDeposit", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];

    var saveAction = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setblockrateoption"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            var grid = $("#blockratedepositoptions").data().kendoGrid;

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
        url: bars.config.urlContent("/api/gda/gda/setblockratecondition"),
        data: function (data) {
            var grid = $("#blockratedepositoptions").data().kendoGrid;
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

    var BlockRateOptionDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getblockrateinfo")
            },
            create: saveAction,
            update: saveAction
        },
        requestEnd: function (e) {
            bars.ui.loader("body", false);
            if (e.type == "create") {
                bars.ui.notify("Повідомлення", "Новий строк дії умов доданий", 'success', { autoHideAfter: 5 * 1000 });
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Cтрок дії умов відредагований", 'success', { autoHideAfter: 5 * 1000 });
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
                    ValidFrom: { type: 'date' },
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



    $scope.BlockRateDepositGridOptions = $scope.createGridOptions({
        dataSource: BlockRateOptionDataSource,
        dataBound: function (e) {
            $('#blockratedepositconditions').removeProp('disabled');
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

            if (data.Conditions != null) {
                var dataArray = $.map(data.Conditions, function (value, index) {
                    return [value];
                });
                //
                var editRow = this.dataItem('tr.k-grid-edit-row');
                if (!editRow) {
                    $('#blockratedepositconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#blockratedepositconditions').data('kendoGrid').dataSource.data([]);
                $('#blockratedepositconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#blockratedepositoptionsEdit', '#addConditionBlockRateDeposit'], false);

            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('blockratedepositoptions', ['#saveConditionBlockRateDeposit', '#cancelConditionBlockRateDeposit'], ['#cancelOptionBlockRateDeposit', '#saveOptionBlockRateDeposit'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('blockratedepositoptions', ['#saveConditionBase', '#cancelConditionBase'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabBlockRate', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });
    $("#exportToExcelBlockRateDeposit").click(function () {
        var grid = $("#blockratedepositoptions").data("kendoGrid");

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
                    { value: "Ставка" }
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
                            { width: 200 },
                            { width: 150 },
                            { width: 150 },
                            { width: 150 }
                        ],
                        title: "Процентна ставка заблокованих траншів по депозиту ММСБ",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Процентна ставка заблокованих траншів по депозиту ММСБ.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") });
        }
    });

    function Cancel() {
        var grid = $("#blockratedepositoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#blockratedepositconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#blockratedepositconditions').data('kendoGrid').refresh();
                $('#blockratedepositoptions').data('kendoGrid').dataSource.read();
            }
        }
    };



    $('#addOptionBlockRateDeposit').click(function () {
        enableDisableButtons(['#cancelOptionBlockRateDeposit', '#saveOptionBlockRateDeposit'], false);
        enableDisableButtons(['#blockratedepositoptionsEdit', '#addConditionBlockRateDeposit', '#blockratedepositconditionsEdit', '#saveConditionBlockRateDeposit', '#exportToExcelBlockRateDeposit'], true);
        var grid = $("#blockratedepositoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabBlockRate', true);
        $('#blockratedepositconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#blockratedepositoptionsEdit,#blockratedepositconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isActionOptions = id === 'blockratedepositoptions';
        if (selected.length == 0) {
            var toDisableIds = isActionOptions ? ['#cancelOptionBlockRateDeposit'] : ['#cancelConditionBlockRateDeposit'];
            var toEnableIds = isActionOptions ? ['#addOptionBlockRateDeposit'] : ['#addConditionBlockRateDeposit'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isActionOptions ? ['#cancelOptionBlockRateDeposit', '#saveOptionBlockRateDeposit'] : ['#addConditionBlockRateDeposit', '#addOptionBlockRateDeposit', '#blockratedepositoptionsEdit', '#saveOptionBlockRateDeposit', '#cancelOptionBlockRateDeposit', '#blockratedepositconditionsEdit', '#exportToExcelBlockRateDeposit'];
            var toEnableIds = isActionOptions ? ['#addOptionBlockRateDeposit', '#blockratedepositconditionsEdit', '#saveConditionBlockRateDeposit', '#addConditionBlockRateDeposit', '#exportToExcelBlockRateDeposit', '#blockratedepositoptionsEdit'] : ['#cancelConditionBlockRateDeposit', '#saveConditionBlockRateDeposit'];

            if (isActionOptions) {
                if (checkEdit('blockratedepositoptions', ['#saveConditionBlockRateDeposit', '#cancelConditionBlockRateDeposit', '#blockratedepositconditionsEdit', '#blockratedepositoptionsEdit'], ['#cancelOptionBlockRateDeposit', '#saveOptionBlockRateDeposit'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabBlockRate', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    disableTabsInEditMode('tabBlockRate', true);
                    grid.editRow(selected);
                }
            }
            else {
                if (checkEdit('blockratedepositoptions', ['#saveConditionBlockRateDeposit', '#cancelConditionBlockRateDeposit', '#blockratedepositconditionsEdit'], ['#cancelOptionBlockRateDeposit', '#saveOptionBlockRateDeposit'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabBlockRate', true);
                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    disableTabsInEditMode('tabBlockRate', true);
                    grid.editRow(selected);
                }
            }

        }
    });
    $('#saveOptionBlockRateDeposit').click(function () {
        enableDisableButtons(['#cancelOptionBlockRateDeposit', '#saveConditionBlockRateDeposit', '#saveOptionBlockRateDeposit', '#blockratedepositconditionsEdit', '#addConditionBlockRateDeposit'], true);
        enableDisableButtons(['#addOptionBlockRateDeposit', '#blockratedepositoptionsEdit', '#exportToExcelBlockRateDeposit'], false);
        var grid = $("#blockratedepositoptions").data("kendoGrid");
        grid.saveRow();
        $('#blockratedepositoptions').data('kendoGrid').dataSource.read();
        $('#blockratedepositoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabBlockRate', false);
    });
    $('#cancelOptionBlockRateDeposit').click(function () {
        enableDisableButtons(['#cancelOptionBlockRateDeposit', '#addConditionBlockRateDeposit', '#saveConditionBlockRateDeposit', '#cancelConditionBlockRateDeposit', '#blockratedepositconditions', '#saveOptionBlockRateDeposit', '#saveConditionBlockRateDeposit'], true);
        enableDisableButtons(['#addOptionBlockRateDeposit', '#exportToExcelBlockRateDeposit'], false);
        var grid = $("#blockratedepositoptions").data("kendoGrid");
        grid.cancelRow();
        grid.dataSource.read();
        $('#blockratedepositconditions').data('kendoGrid').dataSource.data([]);
        $("#blockratedepositconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabBlockRate', false);
    });

    $('#addConditionBlockRateDeposit').click(function (e) {
        enableDisableButtons(['#blockratedepositconditionsEdit', '#addOptionBlockRateDeposit', '#blockratedepositoptionsEdit', '#saveOptionBlockRateDeposit', '#cancelOptionBlockRateDeposit', '#exportToExcelBlockRateDeposit', '#addConditionBlockRateDeposit'], true);
        enableDisableButtons(['#cancelConditionBlockRateDeposit', '#saveConditionBlockRateDeposit'], false);

        if (checkEdit('blockratedepositoptions', ['#saveConditionBlockRateDeposit', '#cancelConditionBlockRateDeposit', '#blockratedepositconditionsEdit'], ['#cancelOptionBlockRateDeposit', '#saveOptionBlockRateDeposit'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#blockratedepositconditions").data("kendoGrid");
            var gridOpt = $("#blockratedepositoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabBlockRate', true);
        }
    });
    $('#saveConditionBlockRateDeposit').click(function () {
        var gridOpt = $("#blockratedepositoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            var grid = $("#blockratedepositconditions").data("kendoGrid");
            grid.saveRow();
            enableDisableButtons(['#addOptionBlockRateDeposit', '#blockratedepositoptionsEdit', '#addOptionBlockRateDeposit', '#blockratedepositoptionsEdit', '#saveOptionBlockRateDeposit', '#addConditionBlockRateDeposit', '#blockratedepositconditionsEdit', '#exportToExcelBlockRateDeposit'], false);
            enableDisableButtons(['#cancelConditionBlockRateDeposit'], true);
            disableTabsInEditMode('tabBlockRate', false);
        } else {
            return;
        }
    });
    $('#cancelConditionBlockRateDeposit').click(function () {
        var gridOpt = $("#blockratedepositoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            var grid = $("#blockratedepositconditions").data("kendoGrid");
            enableDisableButtons(['#addOptionBlockRateDeposit', '#blockratedepositoptionsEdit', '#blockratedepositoptionsEdit', '#saveOptionBlockRateDeposit'], false);
            enableDisableButtons(['#cancelConditionBlockRateDeposit', '#saveConditionBlockRateDeposit', '#blockratedepositconditionsEdit', '#addConditionBlockRateDeposit'], true);
            grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabBlockRate', false);
        } else {
            return;
        }
    });

    var BlockRateConditionsDataSource = $scope.createDataSource({
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
                var gridOpt = $("#blockratedepositoptions").data().kendoGrid;
                var gridCond = $('#blockratedepositconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#blockratedepositoptions").data().kendoGrid;
                var gridCond = $('#blockratedepositconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#blockratedepositoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#blockratedepositoptionsEdit', '#saveOptionBlockRateDeposit', '#addConditionBlockRateDeposit', '#blockratedepositconditionsEdit'], true);
                    if (checkEdit('blockratedepositconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabBlockRate', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#blockratedepositoptionsEdit', '#saveOptionBlockRateDeposit', '#addConditionBlockRateDeposit', '#blockratedepositconditionsEdit', '#addOptionBlockRateDeposit'], true);
                    enableDisableButtons(['#cancelConditionBlockRateDeposit', '#saveConditionBlockRateDeposit'], false);
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
                    TermFrom: { type: 'number', validation: { min: 0 } },
                    AmountFrom: { type: 'number', validation: { min: 0 } },
                    InterestRate: { type: 'number', validation: { min: 0 } }
                }
            }
        },
        serverFiltering: false,
        serverPaging: true,
        serverSorting: false
    });

    $scope.numberWithSpaces = function (x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
    }
    $scope.BlockRateDepositConditionsGridOptions = $scope.createGridOptions({
        dataSource: BlockRateConditionsDataSource,
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
                setTimeout("$('#blockratedepositoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#blockratedepositoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {

            var data = this.dataItem(this.select());

            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#saveConditionBlockRateDeposit', '#cancelConditionBlockRateDeposit'], false);
                enableDisableButtons(['#blockratedepositoptionsEdit'], true);
            } else {
                enableDisableButtons(['#addConditionBlockRateDeposit', '#blockratedepositconditionsEdit'], false);
                enableDisableButtons(['#blockratedepositoptionsEdit'], true);
            }

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('blockratedepositconditions', ['#saveOptionBase', '#cancelOptionBase', '#blockratedepositconditionsEdit', '#addConditionBlockRateDeposit'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabBlockRate', true);
                    } else if (checkEdit('blockratedepositoptions', ['#saveConditionBase', '#cancelConditionBase'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabBlockRate', true);
                    }
                }
            } else {
                return;
            }
        }
    });

    $("#blockratedepositconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#blockratedepositoptions').data('kendoGrid').trigger('change')", 1);
    });
});

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
