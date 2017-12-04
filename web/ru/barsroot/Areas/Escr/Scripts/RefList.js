$(document).ready(function () {

    var toolbar = [];
    toolbar.push({ name: "btButton", type: "button", text: "<span class='pf-icon pf-16 pf-list-ok'></span> Оплатити всі проводки" });
    
    var grid = $("#gridRefList").kendoGrid({
        toolbar: toolbar,
        filterable: true,
        resizable: true,
        sortable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            pageSize: 1000,
            pageSizes: [1000, 2000, 3000]
        },
        columns: [
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
        noRecords: {
            template: "<h3>немає записів на компенсацію</h3>"
        }
    }).data("kendoGrid");

    ///start
    GetRefList();

    $(".k-grid-btButton").click(function () {
        var grid = $("#gridRefList").data("kendoGrid");
        bars.ui.confirm({
            text: "Виконати  оплату всіх <strong>" + grid.dataSource.total() + "</strong> проводок ?", func: function () {
                paymentAll();
            }
        });
    });
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
            errors: "Errors",
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
                    TXT: { type: "string" }
                }
            }
        },
        pageSize: 1000
    });
    grid.setDataSource(dataSource);
}

function paymentAll() {
    var grid = $("#gridRefList").data("kendoGrid").dataSource.data();
    var all_rows = [];
    for (var i = 0; i < grid.length ; i++)
    {
        all_rows.push(grid[i].REF);
    }
    bars.ui.loader('body', true);
    $.ajax({
        async: true,
        type: 'POST',
        url: bars.config.urlContent('/escr/portfoliodata/RepaymentAll'),
        dataType: 'json',
        data: { all_rows: JSON.stringify(all_rows) },
        success: function (data) {
            if (CatchErrors(data)) { bars.ui.alert({ text: "Всі проводки успішно оплачено" }); GetRefList(); }
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

