var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("ActionRateDeposit", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];

    var saveAction = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setactionoption"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            data.ValidThough = kendo.toString(data.ValidThough, "yyyy-MM-dd");
            var grid = $("#actionoptions").data().kendoGrid;

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
        url: bars.config.urlContent("/api/gda/gda/setactioncondition"),
        data: function (data) {
            var grid = $("#actionoptions").data().kendoGrid;
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

    var ActionOptionDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getactioninfo")
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
                    Id: { type: 'string' },
                    OptionDescription: { type: "string" }
                }
            }
        },
        serverFiltering: false, ////!!!!!
        serverPaging: false,
        serverSorting: false
    });



    $scope.ActionOptionGridOptions = $scope.createGridOptions({
        dataSource: ActionOptionDataSource,
        dataBound: function (e) {
            $('#actionconditions').removeProp('disabled');
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
                field: "OptionDescription",
                title: "Назва акційної ставки"
            },
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
                    $('#actionconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#actionconditions').data('kendoGrid').dataSource.data([]);
                $('#actionconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#actionoptionsEdit', '#addConditionAction'], false);

            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('actionoptions', ['#saveConditionAction', '#cancelConditionAction'], ['#cancelOptionAction', '#saveOptionAction'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabAction', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('actionoptions', ['#saveConditionBase', '#cancelConditionBase'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabAction', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });
    $("#exportToExcelAct").click(function () {
        var grid = $("#actionoptions").data("kendoGrid");

        var selectedRow = grid.dataItem(grid.select());
        if (selectedRow == null) {
            bars.ui.alert({ text: "Щоб завантажити дані у Excel оберіть строк дії та ще раз натисніть цю кнопку" });
        } else {
            var rowsOpt = [{
                cells: [
                    { value: 'Назва ставки' },
                    { value: "Дата від" },
                    { value: "Дата до" },
                    { value: "Статус" },
                ]
            }];
            var rowsCond = [{
                cells: [
                    { value: "Валюта" },
                    { value: "Строк від (днів)" },
                    { value: "Сума від" },
                    { value: "Ставка" },
                ]
            }];

            if (grid.dataItem(grid.select()).Conditions != null) {
                rowsOpt.push({
                    cells: [
                        { value: grid.dataItem(grid.select()).OptionDescription },
                        { value: grid.dataItem(grid.select()).ValidFrom },
                        { value: grid.dataItem(grid.select()).ValidThough },
                        { value: grid.dataItem(grid.select()).IsActive ? 'Активна' : 'Неактивна' }
                    ]
                });

                for (var i = 0; i < grid.dataItem(grid.select()).Conditions.length; i++) {
                    rowsCond.push({
                        cells: [
                            { value: grid.dataItem(grid.select()).Conditions[i].Currency },
                            { value: +grid.dataItem(grid.select()).Conditions[i].TermFrom },
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
        var grid = $("#actionoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#actionconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#actionconditions').data('kendoGrid').refresh();
                $('#actionoptions').data('kendoGrid').dataSource.read();
            }
        }
    };



    $('#addOptionAction').click(function () {
        enableDisableButtons(['#cancelOptionAction', '#saveOptionAction'], false);
        enableDisableButtons(['#actionoptionsEdit', '#addConditionAction', '#actionconditionsEdit', '#saveConditionAction', '#exportToExcelAct'], true);
        var grid = $("#actionoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabAction', true);
        $('#actionconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#actionoptionsEdit,#actionconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isActionOptions = id === 'actionoptions';
        if (selected.length == 0) {
            var toDisableIds = isActionOptions ? ['#cancelOptionAction'] : ['#cancelConditionAction'];
            var toEnableIds = isActionOptions ? ['#addOptionAction'] : ['#addConditionAction'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isActionOptions ? ['#cancelOptionAction', '#saveOptionAction'] : ['#addConditionAction', '#addOptionAction', '#actionoptionsEdit', '#saveOptionAction', '#cancelOptionAction', '#actionconditionsEdit', '#exportToExcelAct'];
            var toEnableIds = isActionOptions ? ['#addOptionAction', '#actionconditionsEdit', '#saveConditionAction', '#addConditionAction', '#exportToExcelAct', '#actionoptionsEdit'] : ['#cancelConditionAction', '#saveConditionAction'];

            if (isActionOptions) {
                if (checkEdit('actionoptions', ['#saveConditionAction', '#cancelConditionAction', '#actionconditionsEdit', '#actionoptionsEdit'], ['#cancelOptionAction', '#saveOptionAction'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabAction', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    disableTabsInEditMode('tabAction', true);
                    grid.editRow(selected);
                }
            }
            else {
                if (checkEdit('actionoptions', ['#saveConditionAction', '#cancelConditionAction', '#actionconditionsEdit'], ['#cancelOptionAction', '#saveOptionAction'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabAction', true);
                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    disableTabsInEditMode('tabAction', true);
                    grid.editRow(selected);
                }
            }

        }
    });
    $('#saveOptionAction').click(function () {
        enableDisableButtons(['#cancelOptionAction', '#saveConditionAction', '#saveOptionAction', '#addConditionAction', '#actionconditionsEdit'], true);
        enableDisableButtons(['#addOptionAction', '#actionoptionsEdit', '#exportToExcelAct'], false);
        var grid = $("#actionoptions").data("kendoGrid");
        grid.saveRow();
        $('#actionoptions').data('kendoGrid').dataSource.read();
        $('#actionoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabAction', false);
    });
    $('#cancelOptionAction').click(function () {
        enableDisableButtons(['#cancelOptionAction', '#addConditionAction', '#saveConditionAction', '#cancelConditionAction', '#actionconditions', '#saveOptionAction', '#saveConditionAction'], true);
        enableDisableButtons(['#addOptionAction', '#exportToExcelAct'], false);
        var grid = $("#actionoptions").data("kendoGrid");
        grid.cancelRow();
        grid.dataSource.read();
        $('#actionconditions').data('kendoGrid').dataSource.data([]);
        $("#actionconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabAction', false);
    });

    $('#addConditionAction').click(function (e) {
        enableDisableButtons(['#actionconditionsEdit', '#addOptionAction', '#actionoptionsEdit', '#saveOptionAction', '#cancelOptionAction', '#exportToExcelAct', '#addConditionAction'], true);
        enableDisableButtons(['#cancelConditionAction', '#saveConditionAction'], false);

        if (checkEdit('actionoptions', ['#saveConditionAction', '#cancelConditionAction', '#actionconditionsEdit'], ['#cancelOptionAction', '#saveOptionAction'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#actionconditions").data("kendoGrid");
            var gridOpt = $("#actionoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabAction', true);
        }
    });
    $('#saveConditionAction').click(function () {
        var gridOpt = $("#actionoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            var grid = $("#actionconditions").data("kendoGrid");
            grid.saveRow();
            enableDisableButtons(['#addOptionAction', '#actionoptionsEdit', '#addOptionAction', '#actionoptionsEdit', '#saveOptionAction', '#addConditionAction', '#actionconditionsEdit'], false);
            enableDisableButtons(['#cancelConditionAction'], true);
            disableTabsInEditMode('tabAction', false);
        } else {
            return;
        }
    });
    $('#cancelConditionAction').click(function () {
        var gridOpt = $("#actionoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            var grid = $("#actionconditions").data("kendoGrid");
            enableDisableButtons(['#addOptionAction', '#actionoptionsEdit', '#actionoptionsEdit', '#saveOptionAction'], false);
            enableDisableButtons(['#cancelConditionAction', '#saveConditionAction', '#actionconditionsEdit', '#addConditionAction'], true);
            grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabAction', false);
        } else {
            return;
        }
    });

    var ActionConditionsDataSource = $scope.createDataSource({
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
                var gridOpt = $("#actionoptions").data().kendoGrid;
                var gridCond = $('#actionconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#actionoptions").data().kendoGrid;
                var gridCond = $('#actionconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#actionoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#actionoptionsEdit', '#saveOptionAction', '#addConditionAction', '#actionconditionsEdit'], true);
                    if (checkEdit('actionconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabAction', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#actionoptionsEdit', '#saveOptionAction', '#addConditionAction', '#actionconditionsEdit', '#addOptionAction'], true);
                    enableDisableButtons(['#cancelConditionAction', '#saveConditionAction'], false);
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
    $scope.ActionConditionsGridOptions = $scope.createGridOptions({
        dataSource: ActionConditionsDataSource,
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
                field: "TermFrom",
                headerAttributes: { style: "text-align:center" },
                title: "Строк від (днів)",
                sortable: {
                    compare: function (a, b) {
                        return a.TermFrom - b.TermFrom;
                    }
                },
                template: function (dataItem) {
                    if (dataItem.TermFrom < 0) {
                        dataItem.TermFrom = dataItem.TermFrom.toString();
                        var arr = dataItem.TermFrom.split("");
                        if (arr[1] == '.') {
                            arr.splice(1, 0, '0');
                            var newArr = arr.join('');
                            return "<span>" + newArr + "</span>";
                        } else if (arr[1] != ".") {
                            var newArr = arr.join('');
                            return "<span>" + newArr + "</span>"
                        } else {
                            return "<span>" + dataItem.TermFrom + "</span>"
                        }
                    } else if (dataItem.TermFrom < 1 && dataItem.TermFrom > 0) {
                        return "<span>" + "0" + dataItem.TermFrom + "</span>";
                    } else {
                        return "<span>" + dataItem.TermFrom + "</span>";
                    }
                }
            },
            {
                field: "AmountFrom",
                headerAttributes: { style: "text-align:center" },
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
                setTimeout("$('#actionoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#actionoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {

            var data = this.dataItem(this.select());

            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#saveConditionAction', '#cancelConditionAction'], false);
                enableDisableButtons(['#actionoptionsEdit'], true);
            } else {
                enableDisableButtons(['#addConditionAction', '#actionconditionsEdit'], false);
                enableDisableButtons(['#actionoptionsEdit'], true);
            }

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('actionconditions', ['#saveOptionBase', '#cancelOptionBase', '#actionconditionsEdit', '#addConditionAction'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabAction', true);
                    } else if (checkEdit('actionoptions', ['#saveConditionBase', '#cancelConditionBase'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabAction', true);
                    }
                }
            } else {
                return;
            }
        }
    });

    $("#actionconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#actionoptions').data('kendoGrid').trigger('change')", 1);
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
