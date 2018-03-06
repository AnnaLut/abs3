$(document).ready(function () {
    // init tabstrip:
    $("#tabstrip").kendoTabStrip();

    function switchCurrencyMode() {
        $("#grid-buy").data("kendoGrid").dataSource.read();
    }

    $("#toolbar-buy").kendoToolBar({
        items: [
            { type: "button", text: "Btn#1" },
            { type: "separator" },
            { type: "button", text: "За валюту", id:"currencyUse", togglable: true, selected: false, toggle: switchCurrencyMode }
        ]
    });

    $("#currencyUse").kendoButton();

    function dataContext() {
        var dk = 1;
        if ($("#currencyUse.k-state-active").length > 0)
            dk = 3;

        return { requestType: dk }
    }

    $("#grid-buy").kendoGrid({
        dataSource: {
            transport: {
                read: {
                    type: "GET",
                    dataType: 'json',
                    contentType: "application/json",
                    url: bars.config.urlContent("/api/zayBuy/zay/confirmprimarybuy/GetConfirmPrimaryBuyDataList"),
                    data: dataContext
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        KV2: { type: "number" },
                        DK: { type: "number" },
                        ID: { type: "number" },
                        CUST_BRANCH: { type: "string" },
                        KV_CONV: { type: "number" },
                        KURS_Z: { type: "number" }
                    }
                }
            },
            pageSize: 20
        },
        //height: 550,
        //groupable: true,
        sortable: true,
        selectable: "row",
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "KV2",
                title: "kv2 <br/>Валюта заявки"
            }, {
                field: "DK",
                title: "dk <br/>1 - покупка,<br/>  2 - продаж,<br/> 3 - покупка за др.валюту (конверсія),<br/> 4 - за валюту"
            }, {
                field: "ID",
                title: "id<br/>Ідентифікатор заявки"
            }, {
                field: "CUST_BRANCH",
                title: "cust_branch<br/>Відділення"
            }, {
                field: "KV_CONV",
                title: "KV_CONV<br/>"
            }, {
                field: "KURS_Z",
                title: "KURS_Z<br/>"
            }
        ]
    });

    $("#toolbar-sale").kendoToolBar({
        items: [
            { type: "button", text: "Btn#1" },
            { type: "separator" }
        ]
    });

    $("#grid-sale").kendoGrid({
        dataSource: {
            transport: {
                read: {
                    type: "GET",
                    dataType: 'json',
                    contentType: "application/json",
                    url: bars.config.urlContent("/api/zaySale/zay/confirmprimarysale/GetConfirmPrimarySaleDataList")
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        KV2: { type: "number" },
                        DK: { type: "number" },
                        ID: { type: "number" },
                        CUST_BRANCH: { type: "string" },
                        RNK: { type: "number" },
                        KURS_Z: { type: "number" }
                    }
                }
            },
            pageSize: 20
        },
        sortable: true,
        selectable: "row",
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "KV2",
                title: "kv2 <br/>Валюта заявки"
            }, {
                field: "DK",
                title: "dk <br/>1 - покупка,<br/>  2 - продаж,<br/> 3 - покупка за др.валюту (конверсія),<br/> 4 - за валюту"
            }, {
                field: "ID",
                title: "id<br/>Ідентифікатор заявки"
            }, {
                field: "CUST_BRANCH",
                title: "cust_branch<br/>Відділення"
            }, {
                field: "RNK",
                title: "RNK<br/>"
            }, {
                field: "KURS_Z",
                title: "KURS_Z<br/>"
            }
        ]
    });
});