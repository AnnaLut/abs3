$(document).ready(function () {
    var toolbar = [];
    toolbar.push({ name: "btGLK", type: "button", text: "<span class='pf-icon pf-16 pf-document_header_footer-ok2'></span> Перебудувати ГЛК з помилками" });

    var grid = $("#gridJournal").kendoGrid({
        toolbar: toolbar,
        filterable: true,
        resizable: true,
        sortable: true,
        scrollable: true,
        selectable: "row",
        pageable: {
            refresh: true,
            pageSize: 1000,
            pageSizes: [1000, 2000, 3000]
        },
        columns: [
        {
            title: "Номер журналу",
            width: 100,
            field: "ID"
        },
         {
             title: "Загальна к-сть кредитів  для зарахування",
             width: 150,
             nullable: true,
             field: "TOTAL_DEAL_COUNT",
         },
         {
             title: "К-сть успішних оплат",
             width: 150,
             nullable: true,
             field: "SUCCESS_DEAL_COUNT"
         },
         {
             title: "К-сть КД з помилками при зарахуванні",
             width: 150,
             nullable: true,
             field: "ERROR_DEAL_COUNT"
         },
         {
             title: "Дата виконання зарахування",
             width: 100,
             nullable: true,
             field: "OPER_DATE",
             format: "{0:dd.MM.yyyy HH:mm:ss}"
         }
        ],
        noRecords: {
            template: "<h3>немає записів у журналі</h3>"
        },
        detailTemplate: kendo.template($("#details-template").html()),
        detailInit: detailInit,
        dataBound: function (e) {
            $(".k-grid-btGLK").attr("disabled", "disabled");
        },
        change: function (e) {
            var grid = $("#gridJournal").data("kendoGrid");
            var selected_items = grid.select();
            if (selected_items != null) {
                $(".k-grid-btGLK").removeAttr("disabled");
            } else {
                $(".k-grid-btGLK").attr("disabled", "disabled");
            }
        }
    }).data("kendoGrid");

    ///start
    GetJournalList();


    $(".k-grid-btGLK").click(function () {
        var grid = $("#gridJournal").data().kendoGrid;
        var selectedDataItem = grid.dataItem(grid.select());
        bars.ui.loader('body', true);
        $.ajax({
            async: true,
            type: 'POST',
            url: bars.config.urlContent('/escr/portfoliodata/RestoreGLK/'),
            dataType: 'json',
            data: { id: selectedDataItem.ID },
            success: function (data) {
                if (CatchErrors(data)) {
                    bars.ui.alert({ text: "Відновлення успішно здійснене" });
                    GetJournalList();
                }
            }
        });
        bars.ui.loader('body', false);
    });

})
////////////////////////////////////////////
function GetJournalList() {
    var grid = $("#gridJournal").data("kendoGrid");
    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: "json",
                cache: false,
                url: bars.config.urlContent('/escr/portfoliodata/GetJournalList/'),
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
                id: 'ID',
                fields: {
                    ID: { type: "number" },
                    TOTAL_DEAL_COUNT: { type: "number" },
                    SUCCESS_DEAL_COUNT: { type: "number" },
                    ERROR_DEAL_COUNT: { type: "number" },
                    OPER_DATE: { type: "date" },
                    KF: { type: "string" }
                }
            }
        },
        sort: [
            { field: "ID", dir: "desc" }
        ],
        pageSize: 1000
    });
    grid.setDataSource(dataSource);
}

function detailInit(e) {
    var detailRow = e.detailRow;
    var data = e.data;
    detailRow.find("#gridDetails").kendoGrid({
        dataSource: {
            transport: {
                cache: false,
                read: {
                    url: bars.config.urlContent('/escr/portfoliodata/GetJournalDetail/?id=' + data.ID)
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
                    fields: {
                        DEAL_ID: { type: "number" },
                        ERR_CODE: { type: "number" },
                        ERR_DESC: { type: "string" },
                        COMMENTS: { type: "string" },
                    }
                }
            },
            pageSize: 5
        },
        toolbar: ["excel"],
        pageable: {
            refresh: true,
            pageSizes: [5, 10, 20],
            buttonCount: 5
        },
        columns: [
        {
            title: "Референс КД",
            width: 100,
            nullable: true,
            field: "DEAL_ID",
            template: "<a href='/barsroot/CreditUi/GLK/?id=${DEAL_ID}&readonly=1' onclick='window.open(this.href); return false;'>${DEAL_ID}</a>"
        },
         {
             title: "Помилка",
             width: 300,
             nullable: true,
             field: "ERR_DESC",
         },
         {
             title: "Коментар",
             width: 450,
             nullable: true,
             field: "COMMENTS"
         }],
        excel: {
            fileName: "Проблемні кредити журналу " + data.ID + ".xlsx",
            allPages: true
        }
    }).data("kendoGrid");
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
