///*** GLOBALS
var PAGE_INITIAL_COUNT = 50;
var BANK_DATE = "";
///***

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid) { grid.dataSource.fetch(); }
}


function onContinueClick() {
    $("#dialog").data("kendoWindow").close();
    updateMainGrid();
}

function onCancelClick(event) {
    $("#dialog").data("kendoWindow").close();
    //event.stopImmediatePropagation();
}

function initBankDateSelector() {
    $("#datepicker").kendoDatePicker({
        //value: new Date(),
        format: "dd.MM.yyyy",
        change: function () { BANK_DATE = kendo.toString(this.value(), "dd.MM.yyyy"); }
    });

    $("#dialog").kendoWindow({
        modal: true,
        //actions: [],
        title: "Вибір банківського дня",
        width: "400px"
    });
}

function showDatePickerDialog() {
    var dialog = $("#dialog").data("kendoWindow");
    dialog.center().open();
}

$(document).ready(function () {
    $("#title").html("Підсумки");
    initBankDateSelector();
    initMainGrid();
    insertRowSelectionTooltip();

    showDatePickerDialog();
});

function getBankDate() {
    var date = kendo.toString(BANK_DATE, 'dd.MM.yyyy');
    //var date = kendo.toString($("#datepicker").data("kendoDatePicker").value(), 'dd.MM.yyyy');
    return { "bankDate": date };
}

function showSummaryDate() {
    $("#partialTitle")[0].innerText = "за дату: " + getBankDate()["bankDate"];
}

function initMainGrid() {
    //Waiting(true);

    var gridId = "#gridMain";
    var srcDataSource = {
        //requestStart: function () { $('.k-loading-mask').css('display', 'block'); },
        //requestEnd: function () { $('.k-loading-mask').css('display', 'none'); },
        requestStart: function () { Waiting(true); },
        requestEnd: function () { Waiting(false); },
        type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/CustomerList/CustomerList/TotalCurrencies"),
                dataType: "json",
                data: getBankDate
            }
        },
        pageSize: PAGE_INITIAL_COUNT,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    KV: { type: "number" },
                    LCV: { type: "string" },
                    ISDF: { type: "number" },
                    ISKF: { type: "number" },
                    DOS: { type: "number" },
                    KOS: { type: "number" },
                    OSTCD: { type: "number" },
                    OSTCK: { type: "number" },
                    RAT: { type: "number" }
                }
            }
        }
    };
    var dataSource = new kendo.data.DataSource(srcDataSource);
    var toolbar = [{
        name: "excel",
        imageClass: 'pf-icon pf-16 pf-exel',
        text: ' Вигрузити в EXCEL'
    }];
    var srcSettings = {
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSizes: [PAGE_INITIAL_COUNT, 50, 200, 1000, "All"],
            buttonCount: 5
        },
        filterMenuInit: function (e) {
            e.container.addClass("widerMenu");
        },
        reorderable: true,
        change: function () {
            var grid = $(gridId).data("kendoGrid");
            if (grid) {
                var row = grid.dataItem(grid.select());
            }
        },
        columns: [
            {
                field: "KV",
                title: "KV",
                width: "10%",
                hidden: true
            },
            {
                field: "LCV",
                title: "Валюта",
                width: "10%",
                template: "<div align=center>#=LCV#</div>"
            },
            {
                field: "ISDF",
                title: "Вхідний залишок ДЕБЕТ",
                width: "10%",
                format: "{0:n2}",
                attributes: { "class": "text-right" }
            },
            {
                field: "ISKF",
                title: "Вхідний залишок КРЕДИТ",
                width: "10%",
                format: "{0:n2}",
                attributes: { "class": "text-right" }
            },
            {
                field: "DOS",
                title: "Дт. оборот",
                width: "10%",
                format: "{0:n2}",
                attributes: { "class": "text-right" }
            },
            {
                field: "KOS",
                title: "Кт. оборот",
                width: "10%",
                format: "{0:n2}",
                attributes: { "class": "text-right" }
            },
            {
                field: "OSTCD",
                title: "Вихідний залишок ДЕБЕТ",
                width: "10%",
                format: "{0:n2}",
                attributes: { "class": "text-right" }
            },
            {
                field: "OSTCK",
                title: "Вихідний залишок КРЕДИТ",
                width: "10%",
                format: "{0:n2}",
                attributes: { "class": "text-right" }
            },
            {
                field: "RAT",
                title: "Середньозважена ставка",
                width: "10%",
                format: "{0:n2}",
                attributes: { "class": "text-right" }
            }
        ],
        columnMenu: true,
        toolbar: toolbar,
        dataSource: dataSource,
        dataBinding: function (res) { },
        dataBound: function () { Waiting(false); showSummaryDate(); },
        autoBind: false,
        resizable: true,
        selectable: "multiple row",
        scrollable: true,
        sortable: true,
        excel: {
            fileName: "total_currency_" + kendo.toString(new Date(), "dd.MM.yyyy") + ".xlsx",
            allPages: true,
            filterable: true,
            pagenable: false,
            proxyURL: bars.config.urlContent('/CustomerList/CustomerList/ConvertBase64ToFile/')
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            var grid = $(gridId).data("kendoGrid");
            for (var rowIndex = 1; rowIndex < sheet.rows.length; rowIndex++) {
                var row = sheet.rows[rowIndex];
                for (var cellIndex = 0; cellIndex < row.cells.length; cellIndex++) {
                    var type = dataSource.options.schema.model.fields[grid.columns[cellIndex].field].type;
                    var field = grid.columns[cellIndex].field;
                    if ('date' === type) {
                        row.cells[cellIndex].format = "dd/MM/yyyy HH:mm:ss";
                    } else if ('number' === type) {
                        row.cells[cellIndex].format = '###,##0.00';
                    }
                }
            }

            var counter = 0;
            grid.columns.forEach(function (col, index) {
                if (!col.hidden)
                    sheet.columns[counter++].autoWidth = true;
            });
        }
    };

    $(gridId).kendoGrid(srcSettings);
}