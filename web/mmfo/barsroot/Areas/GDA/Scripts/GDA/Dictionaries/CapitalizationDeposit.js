var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("CapitalizationDeposit", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер


    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];
    var termOptions = [{ value: 1, text: "Щомісячно" }, { value: 2, text: "Щоквартально" }];

    var saveCapitalization = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setcapitalizationoption"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            data.ValidThough = kendo.toString(data.ValidThough, "yyyy-MM-dd");
            var grid = $("#capitalizationoptions").data().kendoGrid;
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
        url: bars.config.urlContent("/api/gda/gda/setcapitalizationcondition"),
        data: function (data) {
            var grid = $("#capitalizationoptions").data().kendoGrid;
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


    var CapitalizationOptionDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getcapitalizationinfo")
            },
            create: saveCapitalization,
            update: saveCapitalization
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

    $scope.CapitalizationOptionGridOptions = $scope.createGridOptions({
        dataSource: CapitalizationOptionDataSource,
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
                //template: "#= kendo.toString(kendo.toString(data.ValidFrom, 'yyyy-MM-dd')) #"
                format: "{0:dd-MM-yyyy}"

            },
            {
                field: "ValidThough",
                title: "Дата до",
                //template: "#= kendo.toString(kendo.toString(data.ValidThough, 'yyyy-MM-dd')) #"
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
            //{ command: ["edit"], title: "&nbsp;", width: "250px" }
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
                    $('#capitalizationconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#capitalizationconditions').data('kendoGrid').dataSource.data([]);
                $('#capitalizationconditions').data('kendoGrid').refresh();
            }

            enableDisableButtons(['#addConditionCapital', '#capitalizationoptionsEdit'], false);
            enableDisableButtons(['#cancelConditionCapital'], true);

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }

            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('capitalizationoptions', ['#saveConditionCapital', '#cancelConditionCapital'], ['#cancelOptionCapital', '#saveOptionCapital'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabCapital', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('capitalizationoptions', ['#saveConditionBase', '#cancelConditionBase'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabCapital', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });

    $('#capitalizationoptionsEdit,#capitalizationconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isCapitalizationOptions = id === 'capitalizationoptions';
        if (selected.length == 0) {
            var toDisableIds = isCapitalizationOptions ? ['#cancelOptionCapital'] : ['#cancelConditionCapital'];
            var toEnableIds = isCapitalizationOptions ? ['#addOptionCapital'] : ['#addConditionCapital'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {

            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isCapitalizationOptions ? ['#cancelOptionCapital', '#saveOptionCapital'] : ['#addConditionCapital', '#addOptionCapital', '#capitalizationoptionsEdit', '#saveOptionCapital', '#cancelOptionCapital', '#capitalizationconditionsEdit', '#exportToExcelCapital'];
            var toEnableIds = isCapitalizationOptions ? ['#addOptionCapital', '#capitalizationconditionsEdit', '#saveConditionCapital', '#addConditionCapital', '#exportToExcelCapital', '#capitalizationoptionsEdit'] : ['#cancelConditionCapital', "#saveConditionCapital"];

            if (isCapitalizationOptions) {
                if (checkEdit('capitalizationoptions', ['#saveConditionCapital', '#cancelConditionCapital'], ['#cancelOptionCapital', '#saveOptionCapital'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabCapital', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabCapital', true);
                }
            }
            else {
                if (checkEdit('capitalizationoptions', ['#saveConditionCapital', '#cancelConditionCapital'], ['#cancelOptionCapital', '#saveOptionCapital'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabCapital', true);

                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabCapital', true);
                }
            }
        }
    });

    $("#exportToExcelCapital").click(function () {
        var grid = $("#capitalizationoptions").data("kendoGrid");

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
                    { value: "Термін" },
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
                            { value: grid.dataItem(grid.select()).Conditions[i].PaymentTerm },
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
                        title: "Капіталізація по депозиту ММСБ",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Капіталізація по депозиту ММСБ.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") });
        }
    });

    $('#addOptionCapital').click(function () {
        enableDisableButtons(['#cancelOptionCapital', '#saveOptionCapital'], false);
        enableDisableButtons(['#capitalizationoptionsEdit', '#addConditionCapital', '#capitalizationconditionsEdit', '#saveConditionCapital', '#exportToExcelCapital'], true);
        var grid = $("#capitalizationoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabCapital', true);
        $('#capitalizationconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#saveOptionCapital').click(function () {
        enableDisableButtons(['#cancelOptionCapital', '#saveOptionCapital','#addConditionCapital'], true);
        enableDisableButtons(['#addOptionCapital', '#capitalizationoptionsEdit', '#exportToExcelCapital'], false);
        var grid = $("#capitalizationoptions").data("kendoGrid");
        grid.saveRow();
        $('#capitalizationoptions').data('kendoGrid').dataSource.read();
        $('#capitalizationoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabCapital', false);
    });
    $('#cancelOptionCapital').click(function () {
        enableDisableButtons(['#cancelOptionCapital', '#addConditionCapital', '#saveConditionCapital', '#cancelConditionCapital', '#generalconditions', '#saveOptionCapital'], true);
        enableDisableButtons(['#addOptionCapital','#exportToExcelCapital'], false);
        var grid = $("#capitalizationoptions").data("kendoGrid");
        grid.cancelRow();
        $("#capitalizationoptions").data("kendoGrid").dataSource.read();
        $('#capitalizationconditions').data('kendoGrid').dataSource.data([]);
        $("#capitalizationconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabCapital', false);
    });


    function Cancel() {
        var grid = $("#capitalizationoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#capitalizationconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#capitalizationconditions').data('kendoGrid').refresh();
                $('#capitalizationoptions').data('kendoGrid').dataSource.read();

            }
        }
    }

    $('#addConditionCapital').click(function (e) {
        enableDisableButtons(['#capitalizationconditionsEdit', '#addOptionCapital', '#capitalizationoptionsEdit', '#saveOptionCapital', '#cancelOptionCapital', '#exportToExcelCapital', '#addConditionCapital'], true);
        enableDisableButtons(['#cancelConditionCapital', '#saveConditionCapital'], false);
        if (checkEdit('capitalizationoptions', ['#saveConditionCapital', '#cancelConditionCapital'], ['#cancelOptionCapital', '#saveOptionCapital'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#capitalizationconditions").data("kendoGrid");
            var gridOpt = $("#capitalizationoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabCapital', true);
        }
    });
    $('#saveConditionCapital').click(function () {
        var gridOpt = $("#capitalizationoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionCapital', '#addConditionCapital', '#exportToExcelCapital'], false);
            enableDisableButtons(['#cancelConditionCapital', '#capitalizationoptionsEdit', '#saveOptionCapital', '#cancelOptionCapital'], true);
            var grid = $("#capitalizationconditions").data("kendoGrid");
            grid.saveRow();
            disableTabsInEditMode('tabCapital', false);
        } else {
            return;
        }
    });
    $('#cancelConditionCapital').click(function () {
        var gridOpt = $("#capitalizationoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());

        if (item != null) {
            enableDisableButtons(['#addOptionCapital', '#capitalizationoptionsEdit', '#addOptionCapital', '#addConditionCapital', '#exportToExcelCapital'], false);
            enableDisableButtons(['#cancelConditionCapital'], true);
            var grid = $("#capitalizationconditions").data("kendoGrid");
            grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabCapital', false);
        } else {
            return;
        }
    });

    var CapitalizationConditionsDataSource = $scope.createDataSource({
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
                var gridOpt = $("#capitalizationoptions").data().kendoGrid;
                var gridCond = $('#capitalizationconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#capitalizationoptions").data().kendoGrid;
                var gridCond = $('#capitalizationconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#capitalizationoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#capitalizationoptionsEdit', '#saveOptionCapital', '#capitalizationconditionsEdit', '#addConditionCapital'], true);
                    if (checkEdit('capitalizationconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabCapital', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#capitalizationoptionsEdit', '#saveOptionCapital', '#addConditionCapital', '#capitalizationconditionsEdit', '#addOptionCapital', '#exportToExcelCapital'], true);
                    enableDisableButtons(['#cancelConditionCapital', '#saveConditionCapital'], false);
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
                    PaymentTermId: { type: 'number' },
                    PaymentTerm: { type: 'string' },
                    InterestRate: { type: 'number' }
                }
            }
        },
        serverFiltering: false,
        serverPaging: true,
        serverSorting: false
    });

    $scope.CapitalizationConditionsGridOptions = $scope.createGridOptions({
        dataSource: CapitalizationConditionsDataSource,
        height: 300,
        selectable: "row",
        editable: 'inline',
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
                field: "PaymentTermId",
                title: "Термін",
                values: termOptions,
                width: 150,
                editor: function (container, options) {
                    var input = $('<input data-text-field="PAYMENT_TERM" data-value-field="PAYMENT_TERM_ID" data-bind="value: ' + options.field + '"/>');
                    input.appendTo(container);
                    //init drop
                    input.kendoDropDownList({
                        autoBind: true,
                        dataTextField: "PAYMENT_TERM",
                        dataValueField: "PAYMENT_TERM_ID",

                        template: '<span style="font-size:0.8em">#:PAYMENT_TERM#</span>',
                        dataSource: {
                            transport: {
                                read: {
                                    type: "GET",
                                    dataType: "json",
                                    url: bars.config.urlContent("/api/gda/gda/getcapitalizationterm")
                                }
                            },
                            schema: {
                                data: "Data"
                            }
                        },
                        optionLabel: {
                            PAYMENT_TERM: "Оберіть термін",
                            PAYMENT_TERM_ID: null
                        }
                    });
                },
                sortable: {
                    compare: function (a, b) {
                        return a.PaymentTermId - b.PaymentTermId;
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
                setTimeout("$('#capitalizationoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#capitalizationoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {
            var data = this.dataItem(this.select());
            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#saveOptionCapital', '#cancelOptionCapital'], false);
                enableDisableButtons(['#capitalizationoptionsEdit'], true);
            } else {
                enableDisableButtons(['#capitalizationoptionsEdit'], true);
                enableDisableButtons(['#capitalizationconditionsEdit', '#addConditionCapital'], false);
            }
            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('capitalizationconditions', ['#saveOptionCapital', '#cancelOptionCapital', '#addConditionCapital', '#capitalizationconditionsEdit'], ['#cancelConditionCapital', '#saveConditionCapital'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabCapital', true);
                    } else if (checkEdit('capitalizationoptions', ['#saveConditionCapital', '#cancelConditionCapital'], ['#cancelOptionCapital', '#saveOptionCapital'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabCapital', true);
                    }
                }
            } else {
                return;
            }

        }
    });

    $("#capitalizationconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#capitalizationoptions').data('kendoGrid').trigger('change')", 1);
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