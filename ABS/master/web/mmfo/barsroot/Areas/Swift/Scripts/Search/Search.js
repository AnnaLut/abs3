/**
 * Created by serhii.karchavets on 30.05.2017.
 */

// http://afuchs.tumblr.com/post/23550124774/datenow-in-ie8
Date.now = Date.now || function() { return +new Date; };

var PAGE_INITIAL_COUNT = 30;
var g_mainData = null;
var g_isMainGridInited = false;

function linkToSWREF(SWREF) {
    return '<a href="#" onclick="OpenSWREF(\''+SWREF+'\')" style="color: blue">' + SWREF + '</a>';
}

function OpenSWREF(SWREF) {
    if(SWREF != null && SWREF !== "null"){
        OpenBarsDialog("/barsroot/documentview/view_swift.aspx?swref=" + SWREF);
    }
    else{ bars.ui.error({ title: 'Помилка', text: "Неправильний SWREF!" }); }
}

function linkToREF(REF) {
    return '<a href="#" onclick="OpenREF(\''+REF+'\')" style="color: blue">' + REF + '</a>';
}

function OpenREF(REF) {
    if(REF != null && REF !== "null"){
        OpenBarsDialog("/barsroot/documentview/default.aspx?ref=" + REF);
    }
    else{ bars.ui.error({ title: 'Помилка', text: "Неправильний REF!" }); }
}

function onClickBtn(btn) {
    switch (btn.id){
        case "btnExcel":
            $('#gridMain').data("kendoGrid").saveAsExcel();
            break;
    }
}

function initMainGrid() {
    fillKendoGrid("#gridMain", {
            type: "webapi",
            // sort: [ { field: "SWREF", dir: "desc" } ],
            transport: {
                read: {
                    url: bars.config.urlContent("/api/Search/SearchMain"),
                    data: function () { return g_mainData; }
                }
            },
            pageSize: PAGE_INITIAL_COUNT,
            schema: {
                model: {
                    fields: {
                        swref: { type: "number" },
                        io_ind: { type: "string" },
                        mt: { type: "number" },
                        trn: { type: "string" },
                        sender: { type: "string" },
                        receiver: { type: "string" },
                        currency: { type: "string" },
                        amount: { type: "number" },
                        date_rec: { type: "date" },
                        date_pay: { type: "date" },
                        vdate: { type: "date" },
                        ref: { type: "number" }
                    }
                }
            }
        }, {
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
            reorderable: true,
            excel: {
                allPages: true,
                fileName: "swi_search.xlsx",
                proxyURL: bars.config.urlContent('/Swift/Search/ConvertBase64ToFile/')
            },
            excelExport: function (e) {
                var sheet = e.workbook.sheets[0];
                var header = sheet.rows[0];
                for (var headerCellIndex = 0; headerCellIndex < header.cells.length; headerCellIndex++) {
                    var headerColl = header.cells[headerCellIndex];
                    headerColl.value = headerColl.value.replace(/<br>/g, ' ');
                }
            },
            columns: [
                {
                    template:'#= linkToSWREF(swref) #',
                    field: "swref",
                    title: "Референс",
                    width: "10%"
                },
                {
                    field: "io_ind",
                    title: "Вх./Вих.",
                    width: "6%"
                },
                {
                    field: "mt",
                    title: "Тип",
                    width: "6%"
                },
                {
                    field: "trn",
                    title: "SWIFT<br>реф.",
                    width: "10%"
                },
                {
                    field: "sender",
                    title: "Відправник",
                    width: "10%"
                },
                {
                    field: "receiver",
                    title: "Отримувач",
                    width: "10%"
                },
                {
                    field: "currency",
                    title: "Валюта",
                    width: "8%"
                },
                {
                    field: "amount",
                    title: "Сума",
                    width: "10%",
                    template: '#=(amount == null) ? "" : kendo.toString(amount,"n")#',
                    format: '{0:n}',
                    attributes: { "class": "money" }
                },
                {
                    field: "date_rec",
                    title: "Дата<br>запису",
                    width: "8%",
                    template: "<div style='text-align:center;'>#=(date_rec == null) ? ' ' : kendo.toString(date_rec,'dd.MM.yyyy')#</div>"
                },
                {
                    field: "date_pay",
                    title: "Дата<br>оплати",
                    width: "8%",
                    template: "<div style='text-align:center;'>#=(date_pay == null) ? ' ' : kendo.toString(date_pay,'dd.MM.yyyy')#</div>"
                },
                {
                    field: "vdate",
                    title: "Дата<br>валютування",
                    width: "8%",
                    template: "<div style='text-align:center;'>#=(vdate == null) ? ' ' : kendo.toString(vdate,'dd.MM.yyyy')#</div>"
                },
                {
                    template:'#= linkToREF(ref) #',
                    field: "ref",
                    title: "Референс<br>АБС",
                    width: "10%"
                }
            ],
            pageable: {
                messages: {
                    allPages: "Всі"
                },
                refresh: true,
                pageSizes: [PAGE_INITIAL_COUNT, 50, 200, 1000, "All"],
                buttonCount: 5
            }
        }
        ,"#mainTitle-template"               //toolbarTemplate
        ,null               //fetchFunc
        ,null  //toolbar
    );
}

function Search() {
    var text = $("#tbText").val();
    if(text == null || text == "" || text == undefined){
        bars.ui.error({ title: 'Помилка', text: "Дані не введено!" });
        return;
    }

    var startDate = replaceAll($("#startDate").val(), '/', '.');
    //var endDate = replaceAll($("#endDate").val(), '/', '.');
    var endDate = startDate;

    if(startDate == null || startDate == "" || endDate == null || endDate == ""){
        bars.ui.error({ title: 'Помилка', text: "Дату не вибрано!" });
        return;
    }

    g_mainData = {text: text, d1: startDate, d2: endDate};
    Waiting(true);
    if(g_isMainGridInited){
        updateMainGrid();
    }
    else{
        g_isMainGridInited = true;
        initMainGrid();
    }
}

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

$(document).ready(function () {
    $("#title").html("Пошук повідомлення");

    var now = new Date(Date.now());
    var d = new Date(now.getFullYear(), now.getMonth(), now.getDate()-200);
    $("#startDate").kendoMaskedDatePicker({ format: "dd/MM/yyyy", value: d });
    //$("#endDate").kendoMaskedDatePicker({ format: "dd/MM/yyyy", value: new Date(Date.now()) });

    $('#SearchBtn').click(Search);
});