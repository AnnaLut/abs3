var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("PenaltyDeposit", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];

    var savePenalty = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setpenaltyoption"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            data.ValidThough = kendo.toString(data.ValidThough, "yyyy-MM-dd");
            var grid = $("#penaltyoptions").data().kendoGrid;
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
        url: bars.config.urlContent("/api/gda/gda/setpenaltycondition"),
        data: function (data) {
            var grid = $("#penaltyoptions").data().kendoGrid;
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
    }

    var PenaltyOptionDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getpenaltyinfo")
            },
            create: savePenalty,
            update: savePenalty
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

    $scope.PenaltyOptionGridOptions = $scope.createGridOptions({
        dataSource: PenaltyOptionDataSource,
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
        selectable: true,
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
            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }

            if (data && data.Conditions != null) {
                var dataArray = $.map(data.Conditions, function (value, index) {
                    return [value];
                });
                //
                var editRow = this.dataItem('tr.k-grid-edit-row');
                if (!editRow) {
                    $('#penaltyconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#penaltyconditions').data('kendoGrid').dataSource.data([]);
                $('#penaltyconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#addConditionPenalty', '#penaltyoptionsEdit', '#addOptionPenalty'], false);
            enableDisableButtons(['#cancelConditionPenalty'], true);


            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('penaltyoptions', ['#saveConditionPenalty', '#cancelConditionPenalty'], ['#cancelOptionPenalty', '#saveOptionPenalty'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabPenalty', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('penaltyoptions', ['#saveConditionPenalty', '#cancelConditionPenalty'], ['#cancelOptionPenalty', '#saveOptionPenalty'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabPenalty', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });

    $("#exportToExcelPenalty").click(function () {
        var grid = $("#penaltyoptions").data("kendoGrid");

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
                    { value: "Відсоток строку траншу від дати розміщення траншу" },
                    { value: "Штрафна ставка" },
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
                            { value: +grid.dataItem(grid.select()).Conditions[i].RateFrom },
                            { value: +grid.dataItem(grid.select()).Conditions[i].PenaltyRate, format: "0.00" }]
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
                        title: "Шкала % ставок при достроковому поверненню траншів",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Шкала % ставок при достроковому поверненню траншів.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") });
        }
    });
    function Cancel() {
        var grid = $("#penaltyoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#penaltyconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#penaltyconditions').data('kendoGrid').refresh();
                $('#penaltyoptions').data('kendoGrid').dataSource.read();
            }
        }
    }

    $('#penaltyoptionsEdit,#penaltyconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isPenaltyOptions = id === 'penaltyoptions';
        if (selected.length == 0) {
            var toDisableIds = isPenaltyOptions ? ['#cancelOptionPenalty'] : ['#cancelConditionPenalty'];
            var toEnableIds = isPenaltyOptions ? ['#addOptionPenalty'] : ['#addConditionPenalty'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isPenaltyOptions ? ['#cancelOptionPenalty', '#saveOptionPenalty'] : ['#addConditionPenalty', '#addOptionPenalty', '#penaltyoptionsEdit', '#saveOptionPenalty', '#cancelOptionPenalty', '#penaltyconditionsEdit', '#exportToExcelPenalty'];
            var toEnableIds = isPenaltyOptions ? ['#addOptionPenalty', '#penaltyconditionsEdit', '#saveConditionPenalty', '#addConditionPenalty', '#penaltyoptionsEdit', '#exportToExcelPenalty'] : ['#cancelConditionPenalty', '#saveConditionPenalty'];

            if (isPenaltyOptions) {
                if (checkEdit('penaltyoptions', ['#saveConditionPenalty', '#cancelConditionPenalty'], ['#cancelOptionPenalty', '#saveOptionPenalty'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabPenalty', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    disableTabsInEditMode('tabPenalty', true);
                    grid.editRow(selected);
                }
            }
            else {
                if (checkEdit('penaltyoptions', ['#saveConditionPenalty', '#cancelConditionPenalty'], ['#cancelOptionPenalty', '#saveOptionPenalty'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabPenalty', true);
                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabPenalty', true);
                }

            }
        }
    });

    $('#addOptionPenalty').click(function () {
        enableDisableButtons(['#cancelOptionPenalty', '#saveOptionPenalty'], false);
        enableDisableButtons(['#penaltyoptionsEdit', '#addConditionPenalty', '#penaltyconditionsEdit', '#saveConditionPenalty', '#addOptionPenalty', '#exportToExcelPenalty'], true);
        var grid = $("#penaltyoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabPenalty', true);
        $('#penaltyconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#saveOptionPenalty').click(function () {
        enableDisableButtons(['#cancelOptionPenalty', '#penaltyconditionsEdit', '#saveConditionPenalty', '#saveOptionPenalty', '#addConditionPenalty'], true);
        enableDisableButtons(['#addOptionPenalty'], false);
        var grid = $("#penaltyoptions").data("kendoGrid");
        grid.saveRow();
        $('#penaltyoptions').data('kendoGrid').dataSource.read();
        $('#penaltyoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabPenalty', false);
    });
    $('#cancelOptionPenalty').click(function () {
        enableDisableButtons(['#cancelOptionPenalty', '#addConditionPenalty', '#saveConditionPenalty', '#cancelConditionPenalty', '#generalconditions'], true);
        enableDisableButtons(['#addOptionPenalty', '#penaltyoptionsEdit', '#exportToExcelPenalty'], false);
        var grid = $("#penaltyoptions").data("kendoGrid");
        grid.cancelRow();
        grid.dataSource.read();
        $('#penaltyconditions').data('kendoGrid').dataSource.data([]);
        $("#penaltyconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabPenalty', false);
    });

    $('#addConditionPenalty').click(function (e) {
        enableDisableButtons(['#penaltyconditionsEdit', '#addOptionPenalty', '#penaltyoptionsEdit', '#saveOptionPenalty', '#cancelOptionPenalty', '#addConditionPenalty', '#exportToExcelPenalty'], true);
        enableDisableButtons(['#cancelConditionPenalty', '#saveConditionPenalty'], false);
        if (checkEdit('penaltyoptions', ['#saveConditionPenalty', '#cancelConditionPenalty'], ['#cancelOptionPenalty', '#saveOptionPenalty'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#penaltyconditions").data("kendoGrid");
            var gridOpt = $("#penaltyoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabPenalty', true);
        }
    });

    $('#saveConditionPenalty').click(function () {
        var gridOpt = $("#penaltyoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionPenalty', '#penaltyoptionsEdit', '#addOptionPenalty', '#addConditionPenalty', '#exportToExcelPenalty'], false);
            enableDisableButtons(['#cancelConditionPenalty', '#cancelOptionPenalty', '#saveOptionPenalty', '#saveConditionPenalty'], true);
            var grid = $("#penaltyconditions").data("kendoGrid");
            grid.saveRow();
            disableTabsInEditMode('tabPenalty', false);
        } else {
            return;
        }
    });
    $('#cancelConditionPenalty').click(function () {
        var gridOpt = $("#penaltyoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionPenalty', '#addOptionPenalty', '#penaltyoptionsEdit', '#addConditionPenalty', '#exportToExcelPenalty'], false);
            enableDisableButtons(['#cancelConditionPenalty', '#saveConditionPenalty', '#penaltyconditionsEdit'], true);
            var grid = $("#penaltyconditions").data("kendoGrid");
            grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabPenalty', false);
        } else {
            return;
        }
    });

    var PenaltyConditionsDataSource = $scope.createDataSource({
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
                var gridOpt = $("#penaltyoptions").data().kendoGrid;
                var gridCond = $('#penaltyconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#penaltyoptions").data().kendoGrid;
                var gridCond = $('#penaltyconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#penaltyoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#penaltyoptionsEdit', '#saveOptionPenalty', '#addConditionPenalty', '#penaltyconditionsEdit'], true);
                    if (checkEdit('penaltyconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabPenalty', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#penaltyoptionsEdit', '#saveOptionPenalty', '#addConditionPenalty', '#penaltyconditionsEdit', '#addOptionPenalty'], true);
                    enableDisableButtons(['#cancelConditionPenalty', '#saveConditionPenalty'], false);
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
                    RateFrom: { type: 'number', validation: { min: 0 } },
                    PenaltyRate: { type: 'number', validation: { min: 0 } }
                }
            }
        },
        serverFiltering: false,
        serverPaging: true,
        serverSorting: false
    });
    var secondDatasource = new kendo.data.DataSource();

    $scope.PenaltyConditionsGridOptions = $scope.createGridOptions({
        dataSource: PenaltyConditionsDataSource,
        height: 300,
        selectable: "row",
        sortable: true,
        editable: 'inline',
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
                field: "RateFrom",
                headerAttributes: { style: "text-align:center" },
                title: "Відсоток строку траншу від дати розміщення траншу",
                sortable: {
                    compare: function (a, b) {
                        return a.RateFrom - b.RateFrom;
                    }
                },
                template: function (dataItem) {
                    if (dataItem.RateFrom < 1) {
                        return "<span>" + "0" + dataItem.RateFrom + "</span>";
                    } else {
                        return "<span>" + dataItem.RateFrom + "</span>";
                    }
                }
            },
            {
                field: "PenaltyRate",
                headerAttributes: { style: "text-align:center" },
                title: "Штрафна ставка",
                sortable: {
                    compare: function (a, b) {
                        return a.PenaltyRate - b.PenaltyRate;
                    }
                },
                //данный темплейт позволяет переформатировать значение с оракла -.9 в нормальный вид -0.9
                template: function (dataItem) {
                    if (dataItem.PenaltyRate < 0) {
                        dataItem.PenaltyRate = dataItem.PenaltyRate.toString();
                        var arr = dataItem.PenaltyRate.split("");
                        if (arr[1] == '.') {
                            arr.splice(1, 0, '0');
                            var newArr = arr.join('');
                            return "<span>" + newArr + "</span>";
                        } else if (arr[1] != ".") {
                            var newArr = arr.join('');
                            return "<span>" + newArr + "</span>"
                        } else {
                            return "<span>" + dataItem.PenaltyRate + "</span>"
                        }
                    } else if (dataItem.PenaltyRate < 1 && dataItem.PenaltyRate > 0) {
                        return "<span>" + "0" + dataItem.PenaltyRate + "</span>";
                    } else {
                        return "<span>" + dataItem.PenaltyRate + "</span>";
                    }
                }
            }
        ],
        save: function (e) {
            var model = e.model;
            var ddl = $("input[name=CurrencyId]").data("kendoDropDownList");
            model.Currency = ddl.text();
        },
        filterable: true,
        filterMenuInit: function (e) {
            var filterButton = $(e.container).find('.k-primary'),
                resetButton = $(e.container).find('.k-button');

            //очистити
            $(resetButton).click(function (e) {
                setTimeout("$('#penaltyoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#penaltyoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {
            var data = this.dataItem(this.select());
            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#saveOptionPenalty', '#cancelOptionPenalty'], false);
                enableDisableButtons(['#penaltyoptionsEdit'], true);
            } else {
                enableDisableButtons(['#penaltyoptionsEdit'], true);
                enableDisableButtons(['#penaltyconditionsEdit', '#addConditionPenalty'], false);
            }

            if (data != null && data.Id != "") {
                if (checkEdit('penaltyconditions', ['#saveOptionPenalty', '#cancelOptionPenalty', '#addConditionPenalty', '#penaltyconditionsEdit'], ['#saveConditionPenalty', '#cancelConditionPenalty'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabPenalty', true);

                } else if (checkEdit('penaltyoptions', ['#saveConditionPenalty', '#cancelConditionPenalty'], ['#cancelOptionPenalty', '#saveOptionPenalty'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabPenalty', true);
                }
            } else {
                return;
            }

        }
    });

    $("#penaltyconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#penaltyoptions').data('kendoGrid').trigger('change')", 1);
    });
});

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