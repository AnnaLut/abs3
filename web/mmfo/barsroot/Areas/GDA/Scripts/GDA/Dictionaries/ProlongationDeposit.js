var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("ProlongationDeposit", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];
    var prolongOptions = [{ value: 1, text: "для першої" }, { value: 2, text: "для кожної" }];

    var saveProlongation = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setprolongationoption"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            data.ValidThough = kendo.toString(data.ValidThough, "yyyy-MM-dd");
            var grid = $("#prolongationoptions").data().kendoGrid;
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
        url: bars.config.urlContent("/api/gda/gda/setprolongationcondition"),
        data: function (data) {
            var grid = $("#prolongationoptions").data().kendoGrid;
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

    var ProlongationOptionDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getprolongationinfo")
            },
            create: saveProlongation,
            update: saveProlongation
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

    $("#exportToExcelProlong").click(function () {
        var grid = $("#prolongationoptions").data("kendoGrid");

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
                    { value: "Кількість пролонгацій" },
                    { value: "Ставка" },
                    { value: "Термін" },

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
                            { value: +grid.dataItem(grid.select()).Conditions[i].AmountFrom },
                            { value: +grid.dataItem(grid.select()).Conditions[i].InterestRate, format: "0.00" },
                            { value: grid.dataItem(grid.select()).Conditions[i].ApplyToFirstName }
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
                            { width: 90 },
                            { width: 150 },
                            { width: 90 },
                            { width: 100 }
                        ],
                        title: "Пролонгація по депозиту ММСБ",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Пролонгація по депозиту ММСБ.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") });
        }
    });
    $scope.ProlongationOptionGridOptions = $scope.createGridOptions({
        dataSource: ProlongationOptionDataSource,
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

            if (data && data.Conditions != null) {
                var dataArray = $.map(data.Conditions, function (value, index) {
                    return [value];
                });
                //
                var editRow = this.dataItem('tr.k-grid-edit-row');
                if (!editRow) {
                    $('#prolongationconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#prolongationconditions').data('kendoGrid').dataSource.data([]);
                $('#prolongationconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#addConditionProlong', '#prolongationoptionsEdit'], false);
            enableDisableButtons(['#cancelConditionProlong'], true);


            var editRow = this.dataItem('tr.k-grid-edit-row');
            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }
            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('prolongationoptions', ['#saveConditionProlong', '#cancelConditionProlong'], ['#cancelOptionProlong', '#saveOptionProlong'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabProlong', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('prolongationoptions', ['#saveConditionBase', '#cancelConditionBase'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabProlong', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });

    function Cancel() {
        var grid = $("#prolongationoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#prolongationconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#prolongationconditions').data('kendoGrid').refresh();
                $('#prolongationoptions').data('kendoGrid').dataSource.read();

            }
        }
    }

    $('#prolongationoptionsEdit,#prolongationconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isGeneralOptions = id === 'prolongationoptions';
        if (selected.length == 0) {
            var toDisableIds = isGeneralOptions ? ['#cancelOptionProlong'] : ['#cancelConditionProlong'];
            var toEnableIds = isGeneralOptions ? ['#addOptionProlong'] : ['#addConditionProlong'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isGeneralOptions ? ['#cancelOptionProlong', '#saveOptionProlong'] : ['#addConditionProlong', '#addOptionProlong', '#prolongationoptionsEdit', '#saveOptionProlong', '#cancelOptionProlong', '#prolongationconditionsEdit', '#exportToExcelProlong'];
            var toEnableIds = isGeneralOptions ? ['#addOptionProlong', '#prolongationconditionsEdit', '#saveConditionProlong', '#addConditionProlong', '#prolongationoptionsEdit', '#exportToExcelProlong'] : ['#cancelConditionProlong', '#saveConditionProlong'];

            if (isGeneralOptions) {
                if (checkEdit('prolongationoptions', ['#saveConditionProlong', '#cancelConditionProlong'], ['#cancelOptionProlong', '#saveOptionProlong'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabProlong', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabProlong', true);
                }
            }
            else {
                if (checkEdit('prolongationoptions', ['#saveConditionProlong', '#cancelConditionProlong'], ['#cancelOptionProlong', '#saveOptionProlong'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabProlong', true);
                }
            }
        }
    });

    $('#addOptionProlong').click(function () {
        enableDisableButtons(['#cancelOptionProlong', '#saveOptionProlong'], false);
        enableDisableButtons(['#prolongationoptionsEdit', '#addConditionProlong', '#prolongationconditionsEdit', '#saveConditionProlong', '#exportToExcelProlong'], true);
        var grid = $("#prolongationoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabProlong', true);
        $('#prolongationconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#saveOptionProlong').click(function () {
        enableDisableButtons(['#cancelOptionProlong', '#saveConditionProlong', '#saveOptionProlong', '#addConditionProlong', '#prolongationoptionsEdit'], true);
        enableDisableButtons(['#addOptionProlong', '#prolongationoptionsEdit', '#exportToExcelProlong'], false);
        var grid = $("#prolongationoptions").data("kendoGrid");
        grid.saveRow();
        $('#prolongationoptions').data('kendoGrid').dataSource.read();
        $('#prolongationoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabProlong', false);
    });
    $('#cancelOptionProlong').click(function () {
        enableDisableButtons(['#cancelOptionProlong', '#addConditionProlong', '#saveConditionProlong', '#cancelConditionProlong', '#prolongconditions'], true);
        enableDisableButtons(['#addOptionProlong', '#prolongationoptionsEdit', '#exportToExcelProlong'], false);
        var grid = $("#prolongationoptions").data("kendoGrid");
        grid.cancelRow();
        grid.dataSource.read();
        $('#prolongationconditions').data('kendoGrid').dataSource.data([]);
        $("#prolongationconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabProlong', false);
    });


    $('#addConditionProlong').click(function (e) {
        enableDisableButtons(['#prolongationconditionsEdit', '#addOptionProlong', '#prolongationoptionsEdit', '#saveOptionProlong', '#cancelOptionProlong', '#addConditionProlong', '#exportToExcelProlong'], true);
        enableDisableButtons(['#cancelConditionProlong', '#saveConditionProlong'], false);
        if (checkEdit('prolongationoptions', ['#saveConditionProlong', '#cancelConditionProlong'], ['#cancelOptionProlong', '#saveOptionProlong'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#prolongationconditions").data("kendoGrid");
            var gridOpt = $("#prolongationoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabProlong', true);
        }
    });




    $('#cancelConditionProlong').click(function () {
        var gridOpt = $("#prolongationoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionProlong', '#prolongationoptionsEdit', '#addOptionProlong', '#addConditionProlong', '#prolongationconditionsEdit'], false);
            enableDisableButtons(['#cancelConditionProlong', '#saveOptionProlong', '#saveConditionProlong'], true);
            var grid = $("#prolongationconditions").data("kendoGrid");
            grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabProlong', false);
        } else {
            return;
        }
    });

    $('#saveConditionProlong').click(function () {
        var gridOpt = $("#prolongationoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionProlong', '#prolongationoptionsEdit', '#prolongationoptionsEdit', '#saveOptionProlong', '#addConditionProlong', '#exportToExcelProlong'], false);
            enableDisableButtons(['#cancelConditionProlong', '#saveOptionProlong', '#cancelOptionProlong', '#saveConditionProlong'], true);
            var grid = $("#prolongationconditions").data("kendoGrid");
            grid.saveRow();
            disableTabsInEditMode('tabProlong', false);
        } else {
            return;
        }
    });


    var ProlongationConditionsDataSource = $scope.createDataSource({
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
                var gridOpt = $("#prolongationoptions").data().kendoGrid;
                var gridCond = $('#prolongationconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#prolongationoptions").data().kendoGrid;
                var gridCond = $('#prolongationconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#prolongationoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#prolongationoptionsEdit', '#saveOptionProlong', '#addConditionProlong', '#prolongationconditionsEdit'], true);
                    if (checkEdit('prolongationconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabProlong', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#prolongationoptionsEdit', '#saveOptionProlong', '#addConditionProlong', '#prolongationconditionsEdit', '#addOptionProlong'], true);
                    enableDisableButtons(['#cancelConditionProlong', '#saveConditionProlong'], false);
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
                    AmountFrom: { type: 'number', validation: { min: 0 } },
                    InterestRate: { type: 'number' },
                    ApplyToFirst: { type: 'string' },
                    ApplyToFirstName: { type: 'string' }
                }
            }
        },
        serverFiltering: false,
        serverPaging: true,
        serverSorting: false
    });
    //var secondDatasource = new kendo.data.DataSource();

    $scope.ProlongationConditionsGridOptions = $scope.createGridOptions({
        dataSource: ProlongationConditionsDataSource,
        height: 300,
        selectable: "row",
        editable: 'inline',
        sortable: true,
        columns: [
            {
                field: "CurrencyId",
                title: "Валюта",
                template: "#=Currency# | #=CurrencyId# ",
                width: 130,
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
                headerAttributes: { style: "text-align:center" },
                title: "Кількість пролонгацій",
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
            },
            {
                field: "ApplyToFirst",
                title: "Термін",
                width: 150,
                values: prolongOptions,
                editor: function (container, options) {
                    var input = $('<input data-text-field="frequency_of_use" data-value-field="frequency_of_use_id" data-bind="value: ' + options.field + '"/>');
                    input.appendTo(container);
                    //init drop
                    input.kendoDropDownList({
                        autoBind: true,
                        dataTextField: "frequency_of_use",
                        dataValueField: "frequency_of_use_id",

                        template: '<span style="font-size:0.8em">#:frequency_of_use#</span>',
                        dataSource: {
                            transport: {
                                read: {
                                    type: "GET",
                                    dataType: "json",
                                    url: bars.config.urlContent("/api/gda/gda/getprolongationlist")
                                }
                            },
                            schema: {
                                data: "Data"
                            }
                        },
                        optionLabel: {
                            frequency_of_use: "Оберіть кількість",
                            frequency_of_use_id: null
                        }
                    });
                },
                sortable: {
                    compare: function (a, b) {
                        return a.ApplyToFirst - b.ApplyToFirst;
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
                setTimeout("$('#prolongationoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#prolongationoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {
            var data = this.dataItem(this.select());
            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#saveOptionProlong', '#cancelOptionProlong'], false);
                enableDisableButtons(['#prolongationoptionsEdit'], true);
            } else {
                enableDisableButtons(['#prolongationoptionsEdit'], true);
                enableDisableButtons(['#prolongationconditionsEdit', '#addConditionProlong'], false);
            }
            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('prolongationconditions', ['#saveOptionProlong', '#cancelOptionProlong', '#addConditionProlong', '#prolongationconditionsEdit'], ['#saveConditionProlong', '#cancelConditionProlong'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabProlong', true);
                    } else if (checkEdit('prolongationoptions', ['#saveConditionProlong', '#cancelConditionProlong'], ['#cancelOptionProlong', '#saveOptionProlong'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabProlong', true);
                    }
                }
            } else {
                return;
            }
        }
    });

    $("#prolongationconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#prolongationoptions').data('kendoGrid').trigger('change')", 1);
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