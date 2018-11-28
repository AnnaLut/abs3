//Read only doprekvs grid:
$("#AddDopRekvGrid").kendoGrid({
    columns: [
        {
            field: "RekvName",
            title: "Назва реквізиту",
            width: 200
        },
        {
            field: "RekvValue",
            title: "Значення реквізиту",
            width: 100
        }
    ],
    dataSource: {
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                type: "GET",
                dataType: 'json',
                url: bars.config.urlContent('/sto/Contract/GetDopRekvForPayment'),  //Here url address should be changed to proper one!!!
                data: { paymentIdd: rowIdd },
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            error: "Errors",
            model: {
                fields: {
                    RekvName: { type: "string" },
                    RekvValue: { type: "string" }
                }
            }
        },
        error: function (e) {
            alert(e.errorThrown);
        },
        pageSize: 10,
        serverPaging: true,
    },
    autobind: false,
    filterable: false,
    resizable: false,
    pageable: {
        refresh: true,
        pageSizes: [10, 20],
        buttonCount: 3
    },
    height: "270px",
    noRecords: {
        template: '<div class="k-label" style="color:grey; margin:20px 20px;">Для даного типу операцій не передбачено додаткових реквізитів. </div>'
    },
});

$("#ContractDopRekvGrid").data('kendoGrid').dataSource.read();
$("#ContractDopRekvGrid").data('kendoGrid').refresh();