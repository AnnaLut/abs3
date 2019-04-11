var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("BonusProlongationDeposit", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];
    var prolongOptions = [{ value: 1, text: "Так" }, { value: 0, text: "Ні" }];

    var saveAction = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setbonusprolongationoption"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            data.ValidThough = kendo.toString(data.ValidThough, "yyyy-MM-dd");
            var grid = $("#bonusprolongationdepositoptions").data().kendoGrid;

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
        url: bars.config.urlContent("/api/gda/gda/setbonusprolongationcondition"),
        data: function (data) {
            var grid = $("#bonusprolongationdepositoptions").data().kendoGrid;
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

    var BonusProlongationOptionDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getbonusprolongationinfo")
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



    $scope.BonusProlongDepositGridOptions = $scope.createGridOptions({
        dataSource: BonusProlongationOptionDataSource,
        dataBound: function (e) {
            $('#bonusprolongationdepositconditions').removeProp('disabled');
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

            if (data.Conditions != null) {
                var dataArray = $.map(data.Conditions, function (value, index) {
                    return [value];
                });
                //
                var editRow = this.dataItem('tr.k-grid-edit-row');
                if (!editRow) {
                    $('#bonusprolongationdepositconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#bonusprolongationdepositconditions').data('kendoGrid').dataSource.data([]);
                $('#bonusprolongationdepositconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#bonusprolongationdepositoptionsEdit', '#addConditionBonusProlongationDeposit'], false);

            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('bonusprolongationdepositoptions', ['#saveConditionBonusProlongationDeposit', '#cancelConditionBonusProlongationDeposit'], ['#cancelOptionBonusProlongationDeposit', '#saveOptionBonusProlongationDeposit'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabBonusProlong', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('bonusprolongationdepositoptions', ['#saveConditionBonusProlongationDeposit', '#cancelConditionBonusProlongationDeposit'], ['#cancelOptionBonusProlongationDeposit', '#saveOptionBonusProlongationDeposit'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabBonusProlong', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });
    $("#exportToExcelBonusProlongationDeposit").click(function () {
        var grid = $("#bonusprolongationdepositoptions").data("kendoGrid");

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
                    { value: "Ставка" },
                    { value: "Автолонгація" }
                ]
            }];
            var selectedItem = grid.dataItem(grid.select());
            if (selectedItem.Conditions != null) {
                rowsOpt.push({
                    cells: [
                        { value: selectedItem.OptionDescription },
                        { value: selectedItem.ValidFrom },
                        { value: selectedItem.ValidThough },
                        { value: selectedItem.IsActive ? 'Активна' : 'Неактивна' }
                    ]
                });
                for (var i = 0; i < selectedItem.Conditions.length; i++) {
                    rowsCond.push({
                        cells: [
                            { value: selectedItem.Conditions[i].Currency },
                            { value: +selectedItem.Conditions[i].InterestRate, format: "0.00" },
                            { value: +selectedItem.Conditions[i].IsProlongation ? 'Так' : 'Ні' }

                        ]
                    });
                }
                var newArr = rowsOpt.concat(rowsCond);
            } else {
                rowsOpt.push({
                    cells: [
                        { value: selectedItem.ValidFrom },
                        { value: selectedItem.ValidThough },
                        { value: selectedItem.IsActive ? 'Активна' : 'Неактивна' }
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
                        title: "Акційна ставка по депозиту ММСБ",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Акційна ставка по депозиту ММСБ.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") });
        }
    });

    function Cancel() {
        var grid = $("#bonusprolongationdepositoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#bonusprolongationdepositconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#bonusprolongationdepositconditions').data('kendoGrid').refresh();
                $('#bonusprolongationdepositoptions').data('kendoGrid').dataSource.read();
            }
        }
    };



    $('#addOptionBonusProlongationDeposit').click(function () {
        enableDisableButtons(['#cancelOptionBonusProlongationDeposit', '#saveOptionBonusProlongationDeposit'], false);
        enableDisableButtons(['#bonusprolongationdepositoptionsEdit', '#addConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit', '#saveConditionBonusProlongationDeposit', '#exportToExcelBonusProlongationDeposit'], true);
        var grid = $("#bonusprolongationdepositoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabBonusProlong', true);
        $('#bonusprolongationdepositconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#bonusprolongationdepositoptionsEdit,#bonusprolongationdepositconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isActionOptions = id === 'bonusprolongationdepositoptions';
        if (selected.length == 0) {
            var toDisableIds = isActionOptions ? ['#cancelOptionBonusProlongationDeposit'] : ['#cancelConditionBonusProlongationDeposit'];
            var toEnableIds = isActionOptions ? ['#addOptionBonusProlongationDeposit'] : ['#addConditionBonusProlongationDeposit'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isActionOptions ? ['#cancelOptionBonusProlongationDeposit', '#saveOptionBonusProlongationDeposit'] : ['#addConditionBonusProlongationDeposit', '#addOptionBonusProlongationDeposit', '#bonusprolongationdepositoptionsEdit', '#saveOptionBonusProlongationDeposit', '#cancelOptionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit', '#exportToExcelBonusProlongationDeposit'];
            var toEnableIds = isActionOptions ? ['#addOptionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit', '#saveConditionBonusProlongationDeposit', '#addConditionBonusProlongationDeposit', '#exportToExcelBonusProlongationDeposit', '#bonusprolongationdepositoptionsEdit'] : ['#cancelConditionBonusProlongationDeposit', '#saveConditionBonusProlongationDeposit'];

            if (isActionOptions) {
                if (checkEdit('bonusprolongationdepositoptions', ['#saveConditionBonusProlongationDeposit', '#cancelConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit', '#bonusprolongationdepositoptionsEdit'], ['#cancelOptionBonusProlongationDeposit', '#saveOptionBonusProlongationDeposit'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabBonusProlong', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    disableTabsInEditMode('tabBonusProlong', true);
                    grid.editRow(selected);
                }
            }
            else {
                if (checkEdit('bonusprolongationdepositoptions', ['#saveConditionBonusProlongationDeposit', '#cancelConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit'], ['#cancelOptionBonusProlongationDeposit', '#saveOptionBonusProlongationDeposit'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabBonusProlong', true);
                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    disableTabsInEditMode('tabBonusProlong', true);
                    grid.editRow(selected);
                }
            }

        }
    });
    $('#saveOptionBonusProlongationDeposit').click(function () {
        enableDisableButtons(['#cancelOptionBonusProlongationDeposit', '#saveConditionBonusProlongationDeposit', '#saveOptionBonusProlongationDeposit', '#addConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit'], true);
        enableDisableButtons(['#addOptionBonusProlongationDeposit', '#bonusprolongationdepositoptionsEdit', '#exportToExcelBonusProlongationDeposit'], false);
        var grid = $("#bonusprolongationdepositoptions").data("kendoGrid");
        grid.saveRow();
        $('#bonusprolongationdepositoptions').data('kendoGrid').dataSource.read();
        $('#bonusprolongationdepositoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabBonusProlong', false);
    });
    $('#cancelOptionBonusProlongationDeposit').click(function () {
        enableDisableButtons(['#cancelOptionBonusProlongationDeposit', '#addConditionBonusProlongationDeposit', '#saveConditionBonusProlongationDeposit', '#cancelConditionBonusProlongationDeposit', '#bonusprolongationdepositconditions', '#saveOptionBonusProlongationDeposit', '#saveConditionBonusProlongationDeposit'], true);
        enableDisableButtons(['#addOptionBonusProlongationDeposit', '#exportToExcelBonusProlongationDeposit'], false);
        var grid = $("#bonusprolongationdepositoptions").data("kendoGrid");
        grid.cancelRow();
        grid.dataSource.read();
        $('#bonusprolongationdepositconditions').data('kendoGrid').dataSource.data([]);
        $("#bonusprolongationdepositconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabBonusProlong', false);
    });

    $('#addConditionBonusProlongationDeposit').click(function (e) {
        enableDisableButtons(['#bonusprolongationdepositconditionsEdit', '#addOptionBonusProlongationDeposit', '#bonusprolongationdepositoptionsEdit', '#saveOptionBonusProlongationDeposit', '#cancelOptionBonusProlongationDeposit', '#exportToExcelBonusProlongationDeposit', '#addConditionBonusProlongationDeposit'], true);
        enableDisableButtons(['#cancelConditionBonusProlongationDeposit', '#saveConditionBonusProlongationDeposit'], false);

        if (checkEdit('bonusprolongationdepositoptions', ['#saveConditionBonusProlongationDeposit', '#cancelConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit'], ['#cancelOptionBonusProlongationDeposit', '#saveOptionBonusProlongationDeposit'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#bonusprolongationdepositconditions").data("kendoGrid");
            var gridOpt = $("#bonusprolongationdepositoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabBonusProlong', true);
        }
    });
    $('#saveConditionBonusProlongationDeposit').click(function () {
        var gridOpt = $("#bonusprolongationdepositoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            var grid = $("#bonusprolongationdepositconditions").data("kendoGrid");
            grid.saveRow();
            enableDisableButtons(['#addOptionBonusProlongationDeposit', '#bonusprolongationdepositoptionsEdit', '#addOptionBonusProlongationDeposit', '#bonusprolongationdepositoptionsEdit', '#saveOptionBonusProlongationDeposit', '#addConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit', '#exportToExcelBonusProlongationDeposit'], false);
            enableDisableButtons(['#cancelConditionBonusProlongationDeposit'], true);
            disableTabsInEditMode('tabBonusProlong', false);
        } else {
            return;
        }
    });
    $('#cancelConditionBonusProlongationDeposit').click(function () {
        var gridOpt = $("#bonusprolongationdepositoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            var grid = $("#bonusprolongationdepositconditions").data("kendoGrid");
            enableDisableButtons(['#addOptionBonusProlongationDeposit', '#bonusprolongationdepositoptionsEdit', '#bonusprolongationdepositoptionsEdit', '#saveOptionBonusProlongationDeposit'], false);
            enableDisableButtons(['#cancelConditionBonusProlongationDeposit', '#saveConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit', '#addConditionBonusProlongationDeposit'], true);
            grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabBonusProlong', false);
        } else {
            return;
        }
    });

    var BonusProlongationConditionsDataSource = $scope.createDataSource({
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
                var gridOpt = $("#bonusprolongationdepositoptions").data().kendoGrid;
                var gridCond = $('#bonusprolongationdepositconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#bonusprolongationdepositoptions").data().kendoGrid;
                var gridCond = $('#bonusprolongationdepositconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#bonusprolongationdepositoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#bonusprolongationdepositoptionsEdit', '#saveOptionBonusProlongationDeposit', '#addConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit'], true);
                    if (checkEdit('bonusprolongationdepositconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabBonusProlong', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#bonusprolongationdepositoptionsEdit', '#saveOptionBonusProlongationDeposit', '#addConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit', '#addOptionBonusProlongationDeposit'], true);
                    enableDisableButtons(['#cancelConditionBonusProlongationDeposit', '#saveConditionBonusProlongationDeposit'], false);
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
                    IsProlongation: { type: 'string' },
                    InterestRate: { type: 'number' }
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
    $scope.BonusProlongDepositConditionsGridOptions = $scope.createGridOptions({
        dataSource: BonusProlongationConditionsDataSource,
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
            },
            {
                field: "IsProlongation",
                title: "Автопролонгація",
                values: prolongOptions,
                editor: function (container, options) {
                    var input = $('<input data-text-field="text" data-value-field="value" data-bind="value: ' + options.field + '" name="' + options.field + '"/>');
                    input.appendTo(container);
                    input.kendoDropDownList({
                        optionLabel: {
                            text: "Оберіть статус",
                            value: null
                        },
                        dataTextField: "text",
                        dataValueField: "value",
                        dataSource: prolongOptions
                    });
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
                setTimeout("$('#bonusprolongationdepositoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#bonusprolongationdepositoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {

            var data = this.dataItem(this.select());

            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#saveConditionBonusProlongationDeposit', '#cancelConditionBonusProlongationDeposit'], false);
                enableDisableButtons(['#bonusprolongationdepositoptionsEdit'], true);
            } else {
                enableDisableButtons(['#addConditionBonusProlongationDeposit', '#bonusprolongationdepositconditionsEdit'], false);
                enableDisableButtons(['#bonusprolongationdepositoptionsEdit'], true);
            }

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('bonusprolongationdepositconditions', ['#saveOptionBase', '#cancelOptionBase', '#bonusprolongationdepositconditionsEdit', '#addConditionBonusProlongationDeposit'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabBonusProlong', true);
                    } else if (checkEdit('bonusprolongationdepositoptions', ['#saveConditionBase', '#cancelConditionBase'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabBonusProlong', true);
                    }
                }
            } else {
                return;
            }
        }
    });

    $("#bonusprolongationdepositconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#bonusprolongationdepositoptions').data('kendoGrid').trigger('change')", 1);
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
