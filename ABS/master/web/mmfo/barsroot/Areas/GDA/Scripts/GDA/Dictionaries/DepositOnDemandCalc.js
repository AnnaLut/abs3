var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("DepositOnDemandCalc", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.placementTranche = modelService.initFormData("placementTranche");

    var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];

    var saveAction = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setdepositdemandcalctype"),
        data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");

            return data;
        }
    };


    var saveCondition = {
        type: "POST",
        url: bars.config.urlContent("/api/gda/gda/setdepositdemandcalctypecondition"),
        data: function (data) {
            var grid = $("#depositondemandcalcoptions").data().kendoGrid;
            var selectedRow = grid.select();
            var selectedDataItem = grid.dataItem(selectedRow);
            data.InterestOptionId = selectedDataItem.Id;
            return data;
        }
    };

    var DepositOnDemandCalcDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getdepositdemandtypeinfo"),
            },
            create: saveAction,
            update: saveAction
        },
        requestStart: function (e) {
            bars.ui.loader("body", false);
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
                    Id: { type: 'string' },
                    ValidFrom: { type: 'date' },
                    IsActive: { type: 'number', validation: { required: true, min: 0, max: 1 } },
                    UserId: { type: 'string' },
                    SysTime: { type: 'string' },
                    CalculationTypeId: { type: 'string' },
                    CalculationTypeName: { type: 'string' }
                }
            }

        },
        serverFiltering: false, ////!!!!!
        serverPaging: false,
        serverSorting: false
    });

    $scope.DepositOnDemandCalcGridOptions = $scope.createGridOptions({
        dataSource: DepositOnDemandCalcDataSource,
        dataBound: function (e) {
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
        height: 400,
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
            for (var j = 0; j < sheet.rows.length; j++) {
                if (sheet.rows[j].cells[1].value == 0) {
                    sheet.rows[j].cells[1].value = 'Довільний метод нарахування'
                } else if (sheet.rows[j].cells[1].value == 1) {
                    sheet.rows[j].cells[1].value = 'Залишок на кінець дня'
                } else if (sheet.rows[j].cells[1].value == 2) {
                    sheet.rows[j].cells[1].value = 'Середньоденні залишки'
                } else if (sheet.rows[j].cells[1].value != "Метод нарахування") { //пропускаем первый row
                    sheet.rows[j].cells[1].value = 'Дані відсутні(можливо неправильно обрали метод)'
                }
            }
            e.workbook.fileName = "Метод нарахування %%.xlsx";
        },
        columns: [
            {
                field: "ValidFrom",
                title: "Дата початку",
                format: "{0:dd-MM-yyyy}",
                width: 150
            },
            {
                field: "CalculationTypeId",
                title: "Метод нарахування",
                template: "#  if (CalculationTypeId == '0' ) { #Довільний метод нарахування# }  else if (CalculationTypeId == '1'){ #Залишок на кінець дня# } else { #Середньоденні залишки# } #",
                width: 220,
                editor: function (container, options) {
                    var input = $('<input data-text-field="ITEM_NAME" data-value-field="ITEM_ID" data-bind="value: ' + options.field + '" name="' + options.field + '"/>');
                    input.appendTo(container);
                    //init drop
                    input.kendoDropDownList({
                        autoBind: true,
                        dataTextField: "ITEM_NAME",
                        dataValueField: "ITEM_ID",
                        filter: 'contains',
                        template: '#:ITEM_NAME#',
                        dataSource: {
                            transport: {
                                read: {
                                    type: "GET",
                                    dataType: "json",
                                    url: bars.config.urlContent("/api/gda/gda/getcalctype")
                                }
                            },
                            schema: {
                                data: "Data",
                                model: {
                                    fields: {
                                        ITEM_ID: { type: 'string' }
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
                                    { field: 'item_id', operator: 'startswith', value: intval.toString() },
                                    { field: 'item_name', operator: 'contains', value: filterValue }
                                ]
                            });
                        },
                        optionLabel: {
                            ITEM_NAME: "Оберіть метод нарахування",
                            ITEM_ID: null
                        }
                    });
                },
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
                //$('#depositondemandcalcconditions').data('kendoGrid').dataSource.data(dataArray);
            } else {
                //$('#depositondemandcalcconditions').data('kendoGrid').dataSource.data([]);
                //$('#depositondemandcalcconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#addConditionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#saveConditionDepositOnDemandCalc'], false);

            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }
            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('depositondemandcalcoptions', [], ['#cancelOptionDepositOnDemandCalc', '#saveOptionDepositOnDemandCalc'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabDemandCalc', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('depositondemandcalcoptions', [], ['#cancelOptionDepositOnDemandCalc', '#saveOptionDepositOnDemandCalc'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabDemandCalc', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });

    function Cancel() {
        var grid = $("#depositondemandcalcoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#depositondemandcalcconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#depositondemandcalcconditions').data('kendoGrid').refresh();
            }
        }
    }

    $("#exportToExcelDepositOnDemandCalc").click(function () {
        var grid = $("#depositondemandcalcoptions").data("kendoGrid");
        grid.saveAsExcel();
    });

    $('#addOptionDepositOnDemandCalc').click(function () {
        enableDisableButtons(['#cancelOptionDepositOnDemandCalc', '#saveOptionDepositOnDemandCalc'], false);
        enableDisableButtons(['#optionsdepositondemandcalcEdit', '#addConditionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#exportToExcelDepositOnDemandCalc', '#addOptionDepositOnDemandCalc'], true);
        var grid = $("#depositondemandcalcoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabDemandCalc', true);
    });

    $('#depositondemandcalcoptionsEdit,#depositondemandcalcconditionsEdit').click(function (event) {
        var id = event.currentTarget.id.slice(0, -4);
        var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isDepositOptions = id === 'depositondemandcalcoptions';
        if (selected.length == 0) {
            var toDisableIds = isDepositOptions ? ['#cancelOptionDepositOnDemandCalc'] : ['#cancelConditionDepositOnDemandCalc'];
            var toEnableIds = isDepositOptions ? ['#addOptionDepositOnDemandCalc'] : ['#addConditionDepositOnDemandCalc'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
            return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isDepositOptions ? ['#cancelOptionDepositOnDemandCalc', '#saveOptionDepositOnDemandCalc'] : ['#addConditionDepositOnDemandCalc', '#addOptionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#saveOptionDepositOnDemandCalc', , '#cancelOptionDepositOnDemandCalc'];
            var toEnableIds = isDepositOptions ? ['#addOptionDepositOnDemandCalc', '#depositondemandcalcconditionsEdit', '#saveConditionDepositOnDemandCalc', '#addConditionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#exportToExcelDepositOnDemandCalc'] : ['#cancelConditionDepositOnDemandCalc'];

            if (isDepositOptions) {
                enableDisableButtons(toDisableIds, inEdit);
                enableDisableButtons(toEnableIds, !inEdit);
                disableTabsInEditMode('tabDemandCalc', true);
            }
            else {
                enableDisableButtons(toDisableIds, !inEdit);
                enableDisableButtons(toEnableIds, inEdit);
                disableTabsInEditMode('tabDemandCalc', true);
            }
            grid.editRow(selected);
        }
    });

    $('#saveOptionDepositOnDemandCalc').click(function () {
        enableDisableButtons(['#cancelOptionDepositOnDemandCalc', '#saveOptionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit'], true);
        enableDisableButtons(['#addOptionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#addConditionDepositOnDemandCalc', '#depositondemandcalcconditionsEdit', '#saveConditionDepositOnDemandCalc', '#exportToExcelDepositOnDemandCalc'], false);
        var grid = $("#depositondemandcalcoptions").data("kendoGrid");
        grid.saveRow();
        $('#depositondemandcalcoptions').data('kendoGrid').dataSource.read();
        $('#depositondemandcalcoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabDemandCalc', false);
    });

    $('#cancelOptionDepositOnDemandCalc').click(function () {
        var grid = $("#depositondemandcalcoptions").data("kendoGrid");
        grid.cancelRow();
        grid.dataSource.read();
        enableDisableButtons(['#cancelOptionDepositOnDemandCalc', '#addConditionDepositOnDemandCalc', '#saveConditionDepositOnDemandCalc', '#cancelConditionDepositOnDemandCalc', '#saveOptionDepositOnDemandCalc'], true);
        enableDisableButtons(['#addOptionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#addConditionDepositOnDemandCalc', '#saveConditionDepositOnDemandCalc', '#exportToExcelDepositOnDemandCalc'], false);
        disableTabsInEditMode('tabDemandCalc', false);
    });


    $('#addConditionDepositOnDemandCalc').click(function () {
        enableDisableButtons(['#depositondemandcalcconditionsEdit', '#addOptionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#saveOptionDepositOnDemandCalc', '#cancelOptionDepositOnDemandCalc'], true);
        enableDisableButtons(['#cancelConditionDepositOnDemandCalc'], false);
        var grid = $("#depositondemandcalcconditions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabDemandCalc', true);
    });

    $('#saveConditionDepositOnDemandCalc').click(function () {
        enableDisableButtons(['#addOptionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#addOptionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#saveOptionDepositOnDemandCalc', '#addConditionDepositOnDemandCalc', '#depositondemandcalcconditionsEdit'], false);
        enableDisableButtons(['#cancelConditionDepositOnDemandCalc'], true);

        var grid = $("#depositondemandcalcconditions").data("kendoGrid");
        grid.saveRow();
        disableTabsInEditMode('tabDemandCalc', false);
    });

    $('#cancelConditionDepositOnDemandCalc').click(function () {
        enableDisableButtons(['#addOptionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#addOptionDepositOnDemandCalc', '#depositondemandcalcoptionsEdit', '#saveOptionDepositOnDemandCalc', '#addConditionDepositOnDemandCalc', '#depositondemandcalcconditionsEdit'], false);
        enableDisableButtons(['#cancelConditionDepositOnDemandCalc'], true);
        var grid = $("#depositondemandcalcconditions").data("kendoGrid");
        grid.cancelRow();
        Cancel();
        disableTabsInEditMode('tabDemandCalc', false);
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