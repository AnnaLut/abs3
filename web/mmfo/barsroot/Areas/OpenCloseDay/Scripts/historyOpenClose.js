$(document).ready(function () {
    var historySource = new kendo.data.DataSource({
        transport: {
            read: {
                dataType: "json",
                type: "GET",
                url: bars.config.urlContent("/api/opencloseday/departmentinfo/getrunhistory")
            }
        },
        schema: {
            model: {
                fields: {
                    ID: { type: "string", editable: false },
                    CURRENT_BANK_DATE: { type: "string", editable: false },
                    TASK_NAME: { type: "string", editable: false },
                    NEW_BANK_DATE: { type: "string", editable: false },
                    RUN_STATE: { type: "string", editable: false },
                }
            }
        }
    });

    var historyGrid = $("#historyGrid").kendoGrid({
        dataSource: historySource,
        height: 350,
        sortable: true,
        pageable: false,
        columns: [{
            field: "ID",
            title: "Індентифікатор",
            //width: "10%"
        }, {
            template: "#= (CURRENT_BANK_DATE == null) ? ' ' : kendo.toString(kendo.parseDate(CURRENT_BANK_DATE), 'dd.MM.yyyy') #",
            field: "CURRENT_BANK_DATE",
            title: "Дата відкриття",
           // width: "10%"
        }, {
            template: "#= (NEW_BANK_DATE == null) ? ' ' : kendo.toString(kendo.parseDate(NEW_BANK_DATE), 'dd.MM.yyyy') #",
            field: "NEW_BANK_DATE",
            title: "Дата закриття",
            //width: "10%"
        }, {
            field: "RUN_STATE",
            title: "Статус",
            //width: "10%"
        }, {
            command: {
                text: "Деталі",
                click: showDetails
            },
            title: "Переглянути",
            width: "100px",
            align:"center"
        }]
    }).data("kendoGrid");

    function showDetails(e) {
        e.preventDefault();

        var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
        var redir_href = window.location.href.split("/")[0] + "//"
            + $(location).attr('href').split("/").slice(2, 4).join("/") +
            "/opencloseday/openclose/opmonitoring?deploy_id=" + dataItem.ID;
        window.location.replace(redir_href);
        
    }
});