/**
 * Created by serhii.karchavets on 16.12.2016.
 */

///*** GLOBALS
var PAGE_INITIAL_COUNT = 10;

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid) { grid.dataSource.fetch(); }
}

function initMainGrid() {
    Waiting(true);

    fillKendoGrid("#gridMain", {
        type: "webapi",
        //sort: [ { field: "ID", dir: "desc" } ],
        transport: { read: { url: bars.config.urlContent("/api/pfu/filesgrid/searchrecblocked") } },
        pageSize: PAGE_INITIAL_COUNT,
        schema: {
            model: {
                fields: {
                    REF: { type: "number" },
                    TT: { type: "string" },
                    DOC_DATE: { type: "string" },
                    FILE_ID: { type: "number" },
                    ID: { type: "number" },
                    MFO: { type: "string" },
                    NLS: { type: "string" },
                    OKPO: { type: "string" },
                    FIO: { type: "string" },
                    SUMA: { type: "number" },
                    SOS: { type: "number" },
                    GROUPID: { type: "number" },
                    USERNAME: { type: "string" },
                    GROUPNAME: { type: "string" }
                }
            }
        }
    }, {
        pageable: {
            refresh: true,
            pageSizes: [PAGE_INITIAL_COUNT, 50, 200, 1000, "Всі"],
            buttonCount: 5
        },
        excel: {
            allPages: true,
            fileName: "Заблоковані Фінмоніторингом.xlsx",
            proxyURL: bars.config.urlContent('/Pfu/Pfu/ConvertBase64ToFile/')
        },
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        reorderable: true,
        toolbar: ["excel"],
        columns: [
            {
                field: "REF",
                title: "Референс<br>документ"
                //,width: "15%"
            },
            {
                field: "TT",
                title: "Код<br>операції"
                //,width: "15%"
            },
            {
                field: "DOC_DATE",
                title: "Дата<br>документу"
                //,width: "15%"
            },
            {
                field: "FILE_ID",
                title: "ID<br>реєстру"
                //,width: "15%"
            },
            {
                field: "MFO",
                title: "МФО"
                //,width: "15%"
            },
            {
                field: "NLS",
                title: "Номер<br>рахунку<br>отримувача"
                //,width: "15%"
            },
            {
                field: "OKPO",
                title: "ІПН"
                //,width: "15%"
            },
            {
                field: "FIO",
                title: "ПІБ"
                //,width: "15%"
            },
            {
                template: '#=kendo.toString(SUMA,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                field: "SUMA",
                title: "Сума"
                //,width: "15%"
            },
            {
                field: "SOS",
                title: "Стан<br>оплати<br>документу"
                //,width: "15%"
            },
            {
                field: "GROUPID",
                title: "Група<br>візування"
                //,width: "15%"
            },
            {
                field: "USERNAME",
                title: "Користувач"
                //,width: "15%"
            },
            {
                field: "GROUPNAME",
                title: "Назва<br>групи<br>візування"
                //,width: "15%"
            }
        ]
    },
        null,
        null);
}

$(document).ready(function () {
    $("#title").html("Заблоковані Фінмоніторингом");
    initMainGrid();
});