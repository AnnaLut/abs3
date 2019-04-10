var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("PaymentDeposit", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.nd = 12345;

    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];
    var termOptions = [{ value: 1, text: "Щомісячно" }, { value: 2, text: "Щоквартально" }, { value: 3, text: "В кінці строку" }];

    var savePayment = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setpaymentoption"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            data.ValidThough = kendo.toString(data.ValidThough, "yyyy-MM-dd");
            var grid = $("#paymentoptions").data().kendoGrid;
            var selectedRow = grid.select();
            //
            if (selectedRow.length > 0) {
                $scope.sItem = grid.dataItem(grid.select()).Id;
            }
            //
            return data;
        }
    };

    var saveConditions = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setpaymentcondition"),
        data: function (data) {
            var grid = $("#paymentoptions").data().kendoGrid;
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

    var PaymentOptionDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getpaymentinfo")
            },
            create: savePayment,
            update: savePayment
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

    $scope.PaymentOptionGridOptions = $scope.createGridOptions({
        dataSource: PaymentOptionDataSource,
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
                    $('#paymentconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#paymentconditions').data('kendoGrid').dataSource.data([]);
                $('#paymentconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#paymentconditionsEdit', '#saveConditionPayment'], true);
            enableDisableButtons(['#addConditionPayment', '#paymentoptionsEdit'], false);


            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }

            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('paymentoptions', ['#saveConditionPayment', '#cancelConditionPayment'], ['#cancelOptionPayment', '#saveOptionPayment'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabPayment', true);
                }
            } else if (data != null && data.Id != '') {

                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('paymentoptions', ['#saveConditionBase', '#cancelConditionBase'], ['#cancelOptionBase', '#saveOptionBase'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabPayment', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });


    $("#exportToExcelPayment").click(function () {
        var grid = $("#paymentoptions").data("kendoGrid");

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
                        title: "Виплата по депозиту ММСБ",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Виплата по депозиту ММСБ.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") });
        }
    });
    $('#paymentoptionsEdit,#paymentconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isPaymentOptions = id === 'paymentoptions';
        if (selected.length == 0) {
            var toDisableIds = isPaymentOptions ? ['#cancelOptionPayment'] : ['#cancelConditionPayment'];
            var toEnableIds = isPaymentOptions ? ['#addOptionPayment'] : ['#addConditionPayment'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isPaymentOptions ? ['#cancelOptionPayment', '#saveOptionPayment'] : ['#addConditionPayment', '#addOptionPayment', '#paymentoptionsEdit', '#saveOptionPayment', '#cancelOptionPayment', '#paymentconditionsEdit'];
            var toEnableIds = isPaymentOptions ? ['#addOptionPayment', '#paymentconditionsEdit', '#saveConditionPayment', '#addConditionPayment', '#paymentoptionsEdit', '#exportToExcelPayment'] : ['#cancelConditionPayment', '#saveConditionPayment'];
            if (isPaymentOptions) {
                if (checkEdit('paymentoptions', ['#saveConditionPayment', '#cancelConditionPayment'], ['#cancelOptionPayment', '#saveOptionPayment'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabPayment', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    disableTabsInEditMode('tabPayment', true);
                    grid.editRow(selected);
                }
            }
            else {
                if (checkEdit('paymentoptions', ['#saveConditionPayment', '#cancelConditionPayment'], ['#cancelOptionPayment', '#saveOptionPayment'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                } else if (checkEdit('paymentoptions', ['#saveConditionPayment', '#cancelConditionPayment'], ['#cancelOptionPayment', '#saveOptionPayment'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    disableTabsInEditMode('tabPayment', true);
                    grid.editRow(selected);
                }
            }
        }
    });


    $('#addOptionPayment').click(function () {
        var grid = $("#paymentoptions").data("kendoGrid");
        grid.addRow();
        enableDisableButtons(['#cancelOptionPayment', '#saveOptionPayment'], false);
        enableDisableButtons(['#addConditionPayment', '#exportToExcelPayment'], true);
        disableTabsInEditMode('tabPayment', true);
        $('#paymentconditions').data('kendoGrid').dataSource.data([]);
    });
    $('#saveOptionPayment').click(function () {
        enableDisableButtons(['#cancelOptionPayment', '#addConditionPayment', '#saveOptionPayment'], true);
        enableDisableButtons(['#addOptionPayment', '#paymentoptionsEdit',  '#exportToExcelPayment'], false);
        var grid = $("#paymentoptions").data("kendoGrid");
        grid.saveRow();
        $('#paymentoptions').data('kendoGrid').dataSource.read();
        $('#paymentoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabPayment', false);
    });

    $('#cancelOptionPayment').click(function () {
        enableDisableButtons(['#cancelOptionPayment', '#addConditionPayment', '#saveConditionPayment', '#cancelConditionPayment', '#paymentoptionsEdit', '#saveOptionPayment'], true);
        enableDisableButtons(['#addOptionPayment', '#paymentoptionsEdit', '#exportToExcelPayment'], false);
        var grid = $("#paymentoptions").data("kendoGrid");
        grid.cancelRow();
        $('#paymentconditions').data('kendoGrid').dataSource.data([]);
        $('#paymentoptions').data('kendoGrid').dataSource.read();
        $("#paymentconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabPayment', false);
    });

    function Cancel() {
        var grid = $("#paymentoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#paymentconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#paymentconditions').data('kendoGrid').refresh();
                $('#paymentoptions').data('kendoGrid').dataSource.read();

            }
        }
    }

    $('#addConditionPayment').click(function (e) {
        enableDisableButtons(['#paymentconditionsEdit', '#paymentoptionsEdit', '#cancelOptionPayment', '#addConditionPayment'], true);
        enableDisableButtons(['#cancelConditionPayment', '#saveConditionPayment'], false);

        if (checkEdit('paymentoptions', ['#saveConditionPayment', '#cancelConditionPayment'], ['#cancelOptionPayment', '#saveOptionPayment'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#paymentconditions").data("kendoGrid");
            var gridOpt = $("#paymentoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabPayment', true);
        }
    });
    $('#saveConditionPayment').click(function () {
        var gridOpt = $("#paymentoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            var grid = $("#paymentconditions").data("kendoGrid");
            grid.saveRow();
            enableDisableButtons(['#addOptionPayment', '#paymentoptionsEdit', '#addOptionPayment', '#paymentoptionsEdit', '#addConditionPayment', '#paymentconditionsEdit'], false);
            enableDisableButtons(['#cancelConditionPayment'], true);
            disableTabsInEditMode('tabPayment', false);
        } else {
            return;
        }
    });

    $('#cancelConditionPayment').click(function () {
        var grid = $("#paymentconditions").data("kendoGrid"),
            gridOpt = $("#paymentoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            grid.cancelRow();
            Cancel();
            enableDisableButtons(['#addOptionPayment', '#paymentoptionsEdit', '#addConditionPayment'], false);
            enableDisableButtons(['#cancelConditionPayment'], true);
            disableTabsInEditMode('tabPayment', false);
        } else {
            return;
        }
    });

    var PaymentConditionsDataSource = $scope.createDataSource({
        type: "json",
        pageSize: 100,
        transport: {
            create: saveConditions,
            update: saveConditions
        },
        requestEnd: function (e) {
            bars.ui.loader('body', false);
            if (e.type == "create") {
                bars.ui.notify("Повідомлення", "Створена нова умова для обраного запису", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#paymentoptions").data().kendoGrid;
                var gridCond = $('#paymentconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#paymentoptions").data().kendoGrid;
                var gridCond = $('#paymentconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#paymentoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#paymentoptionEdit', '#saveOptionPayment', '#addConditionPayment','#cancelConditionPayment', '#saveConditionPayment'], true);
                    if (checkEdit('paymentconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabPayment', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#paymentoptionsEdit', '#saveOptionPayment', '#addConditionPayment', '#paymentconditionsEdit', '#addOptionPayment','#exportToExcelPayment'], true);
                    enableDisableButtons(['#cancelConditionPayment', '#saveConditionPayment'], false);
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
                    PaymentTermId: { type: 'string' },
                    PaymentTerm: { type: 'string' },
                    InterestRate: { type: 'number' }
                },
            }
        },
        serverFiltering: false,
        serverPaging: true,
        serverSorting: false
    });
    //var secondDatasource = new kendo.data.DataSource();

    $scope.PaymentConditionsGridOptions = $scope.createGridOptions({
        dataSource: PaymentConditionsDataSource,
        height: 300,
        selectable: "row",
        editable: 'inline',
        sortable: true,
        columns: [
            {
                field: "CurrencyId",
                title: "Валюта",
                template: "#=Currency# | #=CurrencyId# ",
                width: 150,
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
                    })

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
                width: 150,
                //template: "#=PaymentTerm#",
                values: termOptions,
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
                                    url: bars.config.urlContent("/api/gda/gda/getpaymentterm")
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
        filterable: true,
        filterMenuInit: function (e) {
            var filterButton = $(e.container).find('.k-primary'),
                resetButton = $(e.container).find('.k-button');

            //очистити
            $(resetButton).click(function (e) {
                setTimeout("$('#paymentoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#paymentoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {
            var data = this.dataItem(this.select());
            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#saveConditionPayment', '#cancelConditionPayment'], false);
                enableDisableButtons(['#paymentoptionsEdit'], true);
            } else {
                enableDisableButtons(['#addConditionPayment', '#paymentconditionsEdit'], false);
                enableDisableButtons(['#paymentoptionsEdit'], true);
            }
            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('paymentconditions', ['#saveOptionPayment', '#cancelOptionPayment', '#exportToExcelPayment', '#addOptionPayment', '#paymentconditionsEdit', '#addConditionPayment'], ['#cancelConditionPayment', '#saveConditionPayment'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabPayment', true);
                    } else if (checkEdit('paymentoptions', ['#saveConditionPayment', '#cancelConditionPayment'], ['#cancelOptionPayment', '#saveOptionPayment'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabPayment', true);
                    }
                }
            }
            else {
                return;
            }
        }
    });

    $("#paymentconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#paymentoptions').data('kendoGrid').trigger('change')", 1);
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