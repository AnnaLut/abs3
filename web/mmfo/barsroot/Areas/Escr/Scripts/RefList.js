$(document).ready(function () {

    var toolbar = [];
    toolbar.push({ name: "btButton", type: "button", text: "<span class='pf-icon pf-16 pf-list-arrow_right'></span> Оплатити всі" });
    toolbar.push({ name: "btPayChecked", type: "button", text: "<span class='pf-icon pf-16 pf-list-ok'></span> Оплатити виділені" });
    toolbar.push({ name: "btDeleteChecked", type: "button", text: "<span class='pf-icon pf-16 pf-table_row-delete2'></span> Видалити виділені" });
    toolbar.push("excel");
    
    var grid = $("#gridRefList").kendoGrid({
        toolbar: toolbar,
        filterable: true,
        resizable: true,
        sortable: true,
        scrollable: true,
        selectable: "multiple,row",
        pageable: {
            refresh: true,
            pageSize: 1000,
            pageSizes: [1000, 2000, 3000]
        },
        columns: [
        {
            template: '<input class="checkboxExist" type="checkbox"/>',
            width: 30
        },
        {
            title: "Тип операції",
            width: 73,
            nullable: true,
            field: "TT"
        },
         {
             title: "Референс документу",
             width: 100,
             nullable: true,
             field: "REF",
         },
         {
             title: "Рахунок отримувача",
             width: 115,
             nullable: true,
             field: "NLSB"
         },
         {
             title: "Фактичний залишок",
             width: 115,
             nullable: true,
             field: "OSTC"
         },
         {
             title: "Призначення платежу",
             width: 250,
             nullable: true,
             field: "NAZN"
         },
         {
             title: "Сума",
             width: 115,
             nullable: true,
             field: "S"
         },
         {
             title: "ACC",
             width: 93,
             field: "ACC"
         },
         {
             title: "Кредитний договір",
             width: 93,
             nullable: true,
             field: "ND"
         },
         {
             title: "Дата КД",
             width: 90,
             nullable: true,
             field: "SDATE"
         },
         {
             title: "Номер КД",
             width: 90,
             nullable: true,
             field: "CC_ID"
         },
         {
             title: "ІПН отримувача",
             width: 120,
             nullable: true,
             field: "ID_B"
         },
         {
             title: "Примітки",
             width: 300,
             nullable: true,
             field: "TXT"
         }
        ],
        dataBound: function (e) {
            $(".checkboxExist").bind("change", function (e) {
                $(e.target).closest("tr").toggleClass("k-state-selected");
                DisabledButtons();
            });
            var data = $("#gridRefList").data("kendoGrid").dataSource.data();
            $.each(data, function (i, row) {
                if (row.DATE_CHECK)
                    $('tr[data-uid="' + row.uid + '"] ').addClass("red");
            });
            DisabledButtons();
        },
        change: function (e) {
            $('tr').find('[type=checkbox]').prop('checked', false);
            $('tr.k-state-selected').find('[type=checkbox]').prop('checked', true);
            DisabledButtons();
        },
        noRecords: {
            template: "<h3>немає записів на компенсацію</h3>"
        },
        excel: {
            fileName: "Список на компенсацію.xlsx",
            allPages: true
        }
    }).data("kendoGrid");

    ///start
    GetRefList();

    $(".k-grid-btButton").click(function () {
        var grid = $("#gridRefList").data("kendoGrid").dataSource.data();
        bars.ui.confirm({
            text: "Виконати  оплату всіх <strong>" + grid.length + "</strong> проводок ?", func: function () {
                var all_rows = [];
                for (var i = 0; i < grid.length ; i++) {
                    all_rows.push(grid[i].REF);
                }
                PayOrDelete(all_rows, "pay");
            }
        });
    });

    $(".k-grid-btPayChecked").click(function () {
        CheckedRows("pay");
    });

    $(".k-grid-btDeleteChecked").click(function () {
        CheckedRows("delete");
    });

    $("#gridRefList").kendoTooltip({
        filter: "td:nth-child(6)",
        position: "bottom",
        content: function (e) {
            return $("#gridRefList").data("kendoGrid").dataItem(e.target.closest("tr")).NAZN;
        }
    }).data("kendoTooltip");
})
////////////////////////////////////////////
function GetRefList() {
    var grid = $("#gridRefList").data("kendoGrid");
    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: "json",
                cache: false,
                url: bars.config.urlContent('/escr/portfoliodata/GetRefList/'),
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: function (e) {
                if (e.Status != undefined) {
                    bars.ui.error({
                        title: "Помилка ",
                        text: e.Status,
                        width: '800px',
                        height: '600px'
                    })
                }
            },
            model: {
                id: 'ACC',
                fields: {
                    TT: { type: "string" },
                    REF: { type: "number" },
                    NLSB: { type: "string" },
                    OSTC: { type: "number" },
                    NAZN: { type: "string" },
                    S: { type: "number" },
                    ACC: { type: "number" },
                    ND: { type: "string" },
                    SDATE: { type: "string" },
                    CC_ID: { type: "string" },
                    ID_B: { type: "string" },
                    TXT: { type: "string" },
                    DATE_CHECK: {type: "boolean"}
                }
            }
        },
        pageSize: 1000
    });
    grid.setDataSource(dataSource);
}

function PayOrDelete(rows, type_query) { 
    var _url = '/escr/portfoliodata/';
    _url += type_query === "pay" ? 'PayRefs/' : 'DeleteRefs/';
    bars.ui.loader('body', true);
    $.ajax({
        async: true,
        type: 'POST',
        url: bars.config.urlContent(_url),
        dataType: 'json',
        data: { all_rows: JSON.stringify(rows) },
        success: function (data) {
            if (CatchErrors(data)) {
                var output = "Всі проводки успішно ";
                output += type_query === "pay" ? "оплачено" : "видалено";
                bars.ui.alert({ text: output });
                GetRefList();
            }
        }
    });
    bars.ui.loader('body', false);
}
function CatchErrors(data) {
    if (data.Status != "ok") {
        bars.ui.error({
            title: "Помилка ",
            text: data.Status,
            width: '800px',
            height: '600px'
        });
        return false;
    }
    return true;
}

function DisabledButtons() {
    var grid = $("#gridRefList").data("kendoGrid");
    var check = grid.select().length > 0;
    disabledButtons(check, ".k-grid-btPayChecked");
    disabledButtons(check, ".k-grid-btDeleteChecked");
}

function disabledButtons(condition, id) {
    if (condition) {
        $(id).removeAttr("disabled");
    } else {
        $(id).attr("disabled", "disabled");
    }
}

function CheckedRows(type_query) {
    var grid = $("#gridRefList").data("kendoGrid");
    var selected_items = grid.select();
    var output = "pay" ? "Оплатити " : "Видалити ";
    output += selected_items.length + " обраних записів?";
    bars.ui.confirm({
        text: output, func: function () {
            var all_rows = [];
            grid.select().each(function () {
                all_rows.push(grid.dataItem($(this)).REF);
            });
            PayOrDelete(all_rows, type_query);
        }
    });
}
