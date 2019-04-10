var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("TimeAddTranches", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер


    var saveTimeAddTranches = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/settimeaddtranche"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            var grid = $("#timeaddtranchesoptions").data().kendoGrid;
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
        url: bars.config.urlContent("/api/gda/gda/settimeaddtranchecondition"),
        data: function (data) {
            var grid = $("#timeaddtranchesoptions").data().kendoGrid;
            var selectedRow = grid.select();
            //
            $scope.sItem = grid.dataItem(grid.select()).Id;
            //
            var selectedDataItem = grid.dataItem(selectedRow);
            data.InterestOptionId = selectedDataItem.Id;
            return data;
        }
    };

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];


    $scope.placementTranche = modelService.initFormData("placementTranche");

    var TimeAddTranchesOptionDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/gettimeaddtranchesinfo")
            },
            create: saveTimeAddTranches,
            update: saveTimeAddTranches
        },
        requestEnd: function (e) {
            if (e.type == "create") {
                bars.ui.notify("Повідомлення", "Новий строк дії умов доданий", 'success', { autoHideAfter: 5 * 1000 });
                bars.ui.loader("body", false);
            }
            bars.ui.loader("body", false);
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
                    UserId: { type: 'string' },
                    SysTime: { type: 'string' }
                }
            }
        },
        serverFiltering: false, ////!!!!!
        serverPaging: false,
        serverSorting: false
    });

    $scope.TimeAddTranchesGridOptions = $scope.createGridOptions({
        dataSource: TimeAddTranchesOptionDataSource,
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
                    $('#timeaddtranchesconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#timeaddtranchesconditions').data('kendoGrid').dataSource.data([]);
                $('#timeaddtranchesconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#addConditionTimeAddTranches', '#timeaddtranchesoptionsEdit'], false);

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('timeaddtranchesoptions', ['#saveConditionTimeAddTranches', '#cancelConditionTimeAddTranches'], ['#cancelOptionTimeAddTranches', '#saveOptionTimeAddTranches'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('timeaddtranchesoptions', ['#saveConditionTimeAddTranches', '#cancelConditionTimeAddTranches'], ['#cancelOptionTimeAddTranches', '#saveOptionTimeAddTranches'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabTimeAdd', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });

    $("#exportToExcelTimeAddTranches").click(function () {
        var grid = $("#timeaddtranchesoptions").data("kendoGrid");

        var selectedRow = grid.dataItem(grid.select());
        if (selectedRow == null) {
            bars.ui.alert({ text: "Щоб завантажити дані у Excel оберіть строк дії та ще раз натисніть цю кнопку" });
        } else {
            var rowsOpt = [{
                cells: [
                    { value: "Дата від" },
                    { value: "Статус" },
                ]
            }];
            var rowsCond = [{
                cells: [
                    { value: "Термін розміщення Траншу (від)" },
                    { value: "Припинення поповнення траншу за n кількість днів до повернення траншу" },
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
                            { value: +grid.dataItem(grid.select()).Conditions[i].TranchTerm, format: "0.00" },
                            { value: +grid.dataItem(grid.select()).Conditions[i].DaysToCloseReplenish, format: "0.00" }
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
                        title: "Строки поповнення траншів",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Строки поповнення траншів.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") });
        }
    });


    function Cancel() {
        var grid = $("#timeaddtranchesoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data)
            if (data.Conditions != null) {
                $('#timeaddtranchesconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#timeaddtranchesconditions').data('kendoGrid').refresh();
                $('#timeaddtranchesoptions').data('kendoGrid').dataSource.read();
            }

    }

    $('#addOptionTimeAddTranches').click(function () {
        enableDisableButtons(['#cancelOptionTimeAddTranches', '#saveOptionTimeAddTranches'], false);
        enableDisableButtons(['#timeaddtranchesoptionsEdit', '#addConditionTimeAddTranches', '#timeaddtranchesconditionsEdit', '#saveConditionTimeAddTranches', '#exportToExcelTimeAddTranches', '#addOptionTimeAddTranches'], true);
        var grid = $("#timeaddtranchesoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabTimeAdd', true);
        $('#timeaddtranchesconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#timeaddtranchesoptionsEdit,#timeaddtranchesconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isTimeAddTranchesOptions = id === 'timeaddtranchesoptions';
        if (selected.length == 0) {
            var toDisableIds = isTimeAddTranchesOptions ? ['#cancelOptionTimeAddTranches'] : ['#cancelConditionTimeAddTranches'];
            var toEnableIds = isTimeAddTranchesOptions ? ['#addOptionTimeAddTranches'] : ['#addConditionTimeAddTranches'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isTimeAddTranchesOptions ? ['#cancelOptionTimeAddTranches', '#saveOptionTimeAddTranches'] : ['#addConditionTimeAddTranches', '#addOptionTimeAddTranches', '#saveOptionTimeAddTranches', '#cancelOptionTimeAddTranches', '#exportToExcelTimeAddTranches', '#timeaddtranchesconditionsEdit'];
            var toEnableIds = isTimeAddTranchesOptions ? ['#addOptionTimeAddTranches', '#timeaddtranchesconditionsEdit', '#saveConditionTimeAddTranches', '#addConditionTimeAddTranches', '#exportToExcelTimeAddTranches', '#timeaddtranchesoptionsEdit'] : ['#cancelConditionTimeAddTranches', '#saveConditionTimeAddTranches'];

            if (isTimeAddTranchesOptions) {
                if (checkEdit('timeaddtranchesoptions', ['#saveConditionTimeAddTranches', '#cancelConditionTimeAddTranches'], ['#cancelOptionTimeAddTranches', '#saveOptionTimeAddTranches'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabTimeAdd', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabTimeAdd', true);
                }
            }
            else {
                if (checkEdit('timeaddtranchesoptions', ['#saveConditionTimeAddTranches', '#cancelConditionTimeAddTranches'], ['#cancelOptionTimeAddTranches', '#saveOptionTimeAddTranches'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabTimeAdd', true);

                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabTimeAdd', true);
                }
            }
        }
    });
    $('#saveOptionTimeAddTranches').click(function () {
        enableDisableButtons(['#cancelOptionTimeAddTranches', '#saveOptionTimeAddTranches','#addConditionTimeAddTranches'], true);
        enableDisableButtons(['#addOptionTimeAddTranches', '#timeaddtranchesoptionsEdit', '#exportToExcelTimeAddTranches'], false);
        var grid = $("#timeaddtranchesoptions").data("kendoGrid");
        grid.saveRow();
        $('#timeaddtranchesoptions').data('kendoGrid').dataSource.read();
        $('#timeaddtranchesoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabTimeAdd', false);
    });
    $('#cancelOptionTimeAddTranches').click(function () {
        var grid = $("#timeaddtranchesoptions").data("kendoGrid");
        grid.cancelRow();
        enableDisableButtons(['#cancelOptionTimeAddTranches', '#addConditionTimeAddTranches', '#saveConditionTimeAddTranches', '#cancelConditionTimeAddTranches', '#actionconditions', '#saveOptionTimeAddTranches'], true);
        enableDisableButtons(['#addOptionTimeAddTranches', '#exportToExcelTimeAddTranches'], false);
        grid.dataSource.read();
        $('#timeaddtranchesconditions').data('kendoGrid').dataSource.data([]);
        $("#timeaddtranchesconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabTimeAdd', false);
    });

    $('#addConditionTimeAddTranches').click(function (e) {
        enableDisableButtons(['#timeaddtranchesconditionsEdit', '#addOptionTimeAddTranches', '#timeaddtranchesoptionsEdit', '#saveOptionTimeAddTranches', '#cancelOptionTimeAddTranches', '#exportToExcelTimeAddTranches', '#addConditionTimeAddTranches'], true);
        enableDisableButtons(['#cancelConditionTimeAddTranches', '#saveConditionTimeAddTranches'], false);
        if (checkEdit('timeaddtranchesoptions', ['#saveConditionTimeAddTranches', '#cancelConditionTimeAddTranches'], ['#cancelOptionTimeAddTranches', '#saveOptionTimeAddTranches'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#timeaddtranchesconditions").data("kendoGrid");
            var gridOpt = $("#timeaddtranchesoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabTimeAdd', true);
        }
    });
    $('#saveConditionTimeAddTranches').click(function () {
        var gridOpt = $("#timeaddtranchesoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionTimeAddTranches', '#timeaddtranchesoptionsEdit', '#addOptionTimeAddTranches', '#timeaddtranchesoptionsEdit', '#addConditionTimeAddTranches', '#exportToExcelTimeAddTranches'], false);
            enableDisableButtons(['#cancelConditionTimeAddTranches', '#saveConditionTimeAddTranches'], true);
            var grid = $("#timeaddtranchesconditions").data("kendoGrid");
            grid.saveRow();
            disableTabsInEditMode('tabTimeAdd', false);
        } else {
            return;
        }

    });
    $('#cancelConditionTimeAddTranches').click(function () {
        var gridOpt = $("#timeaddtranchesoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionTimeAddTranches', '#addOptionTimeAddTranches', '#timeaddtranchesoptionsEdit', '#addConditionTimeAddTranches', '#timeaddtranchesconditionsEdit'], false);
            enableDisableButtons(['#cancelConditionTimeAddTranches', '#saveConditionTimeAddTranches'], true);
            var grid = $("#timeaddtranchesconditions").data("kendoGrid");
            grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabTimeAdd', false);
        } else {
            return;
        }
    });

    var TimeAddTranchesConditionsDataSource = $scope.createDataSource({
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
                var gridOpt = $("#timeaddtranchesoptions").data().kendoGrid;
                var gridCond = $('#timeaddtranchesconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#timeaddtranchesoptions").data().kendoGrid;
                var gridCond = $('#timeaddtranchesconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#timeaddtranchesoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#timeaddtranchesoptionsEdit', '#saveOptionTimeAddTranches', '#addConditionTimeAddTranches', '#timeaddtranchesconditionsEdit'], true);
                    if (checkEdit('timeaddtranchesconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabTimeAdd', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#timeaddtranchesoptionsEdit', '#saveOptionTimeAddTranches', '#addConditionTimeAddTranches', '#timeaddtranchesconditionsEdit', '#addOptionTimeAddTranches'], true);
                    enableDisableButtons(['#cancelConditionTimeAddTranches', '#saveConditionTimeAddTranches'], false);
                }
            }
        },
        schema: {
            model: {
                id: "Id",
                fields: {
                    Id: { type: 'string' },
                    InterestOptionId: { type: 'string' },
                    TranchTerm: { type: 'number', validation: { min: 0 } },
                    DaysToCloseReplenish: { type: 'number', validation: { min: 0 } }
                }
            }
        },
        serverFiltering: false,
        serverPaging: true,
        serverSorting: false
    });
    //var secondDatasource = new kendo.data.DataSource();

    $scope.TimeAddTranchesConditionsGridOptions = $scope.createGridOptions({
        dataSource: TimeAddTranchesConditionsDataSource,
        height: 300,
        selectable: "row",
        sortable: true,
        editable: 'inline',
        columns: [
            {
                field: "TranchTerm",
                title: "Термін розміщення Траншу (від)",
                headerAttributes: { style: "text-align:center" },
                sortable: {
                    compare: function (a, b) {
                        return a.TranchTerm - b.TranchTerm;
                    }
                }
            },
            {
                field: "DaysToCloseReplenish",
                title: "Припинення поповнення траншу за n кількість днів до повернення траншу",
                headerAttributes: { style: "text-align:center" },
                sortable: {
                    compare: function (a, b) {
                        return a.DaysToCloseReplenish - b.DaysToCloseReplenish;
                    }
                }
            }
            //{ command: ["edit"], title: "&nbsp;", width: "250px" }
        ],
        filterable: true,
        filterMenuInit: function (e) {
            var filterButton = $(e.container).find('.k-primary'),
                resetButton = $(e.container).find('.k-button');

            //очистити
            $(resetButton).click(function (e) {
                setTimeout("$('#timeaddtranchesoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#timeaddtranchesoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {
            var data = this.dataItem(this.select());
            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#timeaddtranchesoptionsEdit'], true);
                enableDisableButtons(['#timeaddtranchesconditionsEdit', '#addConditionTimeAddTranches'], false);
            } else {
                enableDisableButtons(['#saveOptionTimeAddTranches', '#cancelOptionTimeAddTranches'], false);
                enableDisableButtons(['#timeaddtranchesoptionsEdit'], true);
            }
            var editRow = this.dataItem('tr.k-grid-edit-row');


            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('timeaddtranchesconditions', ['#saveOptionTimeAddTranches', '#cancelOptionTimeAddTranches', '#timeaddtranchesconditionsEdit', '#addConditionTimeAddTranches'], ['#saveConditionTimeAddTranches', '#cancelConditionTimeAddTranches'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabTimeAdd', true);

                    } else if (checkEdit('timeaddtranchesoptions', ['#saveConditionTimeAddTranches', '#cancelConditionTimeAddTranches'], ['#cancelOptionTimeAddTranches', '#saveOptionTimeAddTranches'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabTimeAdd', true);
                    }
                }
            } else {
                return;
            }

        }
    });

    $("#timeaddtranchesconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#timeaddtranchesoptions').data('kendoGrid').trigger('change')", 1);
    });
});
