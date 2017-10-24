$(document).ready(function () {
    var dStrt = $("#dateStart, #dateEnd").kendoDatePicker({
        value: new Date(), format: "dd.MM.yyyy"
    });


    $("#SepArcDocumentsGrid").kendoGrid({
        autobind: true,
        selectable: "multiple",
        filterable: true,
        sortable: true,
        resizable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        scrollable: true,
        columns: [
        {
            field: "REF",
            title: "Референс документа",
            width: "120px",
            headerAttributes: {
                style: "white-space: normal;"
            }
        },
        {
            field: "ND",
            title: "Номер документа",
            width: "120px",
            headerAttributes: {
                style: "white-space: normal;"
            }
        },
        {
            field: "MFOA",
            title: "МФО - A",
            width: "100px"
        },
        {
            field: "NLSA",
            title: "Рахунок - A",
            width: "120px"
        },
        {
            field: "S",
            title: "Сума",
            template: "<div style='text-align:right;'>#=(S/100).toFixed(2)#</div>",
            width: "80px"
        },
        {
            field: "KV",
            title: "Валюта",
            width: "100px",
            headerAttributes: {
                style: "white-space: normal;"
            }
        },
        {
            field: "MFOB",
            title: "МФО - B",
            width: "100px"
        },
        {
            field: "NLSB",
            title: "Рахунок - B",
            width: "120px"
        },
        {
            field: "DK",
            title: "ДБ Кр",
            width: "80px",
            headerAttributes: {
                style: "white-space: normal;"
            }
        },
        //{
        //    field: "VOB",
        //    title: "Вид документа",
        //    width: "55px"
        //},
        {
            field: "DATP",
            title: "Дата документа",
            width: "120px",
            template: "<div style='text-align:right;'>#=kendo.toString(DATP,'dd.MM.yyyy')#</div>",
            headerAttributes: {
                style: "white-space: normal;"
            }
        },
        //{
        //            field: "VDAT",
        //            title: "VDAT",
        //            width: "80px",
        //            template: "<div style='text-align:right;'>#=kendo.toString(VDAT,'dd.MM.yyyy')#</div>",
        //            headerAttributes: {
        //                style: "white-space: normal;"
        //            }
        //        },
        {
            field: "FN_A",
            title: "СЕП. Ім'я вхідного файлу",
            width: "150px",
            headerAttributes: {
                style: "white-space: normal;"
            }
        },
        {
            field: "DAT_A",
            title: "СЕП.<br/>Дата файлу",
            width: "120px",
            template: "<div style='text-align:right;'>#=kendo.toString(DAT_A,'dd.MM.yyyy')#</div>"
        },
        //{
        //    field: "D_REC",
        //    title: "D_REC",
        //    width: "80px",
        //    template: "<div style='text-align:right;'>#=D_REC == null ? '' : D_REC#</div>",
        //    headerAttributes: {
        //        style: "white-space: normal;"
        //    }
        //},
        {
            field: "REC_A",
            title: "СЕП. Номер запису",
            width: "120px",
            template: "<div style='text-align:right;'>#=REC_A == null ? '' : REC_A#</div>",
            headerAttributes: {
                style: "white-space: normal;"
            }
        },
        {
            field: "FN_B",
            title: "СЕП. Ім'я вихідного файлу",
            width: "150px",
            headerAttributes: {
                style: "white-space: normal;"
            }
        },
        {
            field: "DAT_B",
            title: "СЕП.<br/>Дата файлу",
            width: "120px",
            template: "<div style='text-align:right;'>#=DAT_B == null ? '' : kendo.toString(DAT_B,'dd.MM.yyyy')#</div>"
        },
        //{
        //    field: "DATD",
        //    title: "DATD",
        //    width: "80px",
        //    template: "<div style='text-align:right;'>#=DAT_B == null ? '' : kendo.toString(DATD,'dd.MM.yyyy')#</div>"
        //},
        {
            field: "REC_B",
            title: "СЕП. Номер запису",
            width: "120px",
            template: "<div style='text-align:right;'>#=REC_B == null ? '' : REC_B#</div>",
            headerAttributes: {
                style: "white-space: normal;"
            }
        },
        {
            field: "NAZN",
            title: "Призначення платежу",
            width: "300px"
        },
        {
            field: "NAM_A",
            title: "Відправник",
            width: "120px"
        },
        {
            field: "NAME_A",
            title: "Банк<br/>відправника",
            width: "130px"
        },
        {
            field: "NAM_B",
            title: "Одержувач",
            width: "120px"
        },
        {
            field: "NAME_B",
            title: "Банк<br/>одержувач",
            width: "120px"
        }
        ],
        toolbar: [{ name: 'excel', text: 'Друк' }],
        excel: {
            fileName: "Архів документів.xlsx",
            allPages: true,
            filterable: true,
            proxyURL: bars.config.urlContent("/sep/separcdocuments/ConvertBase64ToFile/")
        },
        dataSource: {
            type: 'aspnetmvc-ajax',
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            pageSize: 10,
            transport: {
                read: {
                    datatype: 'json',
                    type: "GET",
                    url: bars.config.urlContent('/sep/separcdocuments/GetSepArcDocs'),
                    data: function () { return SearchByParams() }
                }
            },
            requestStart: function (e) {
                bars.ui.loader("body", true);
            },
            requestEnd: function (e) {
                bars.ui.loader("body", false);
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        MFOA: { type: "string" },
                        MFOB: { type: "string" },
                        NLSA: { type: "string" },
                        NLSB: { type: "string" },
                        S: { type: "number" },
                        KV: { type: "number" },
                        LCV: { type: "string" },
                        DIG: { type: "number" },
                        DK: { type: "number" },
                        VOB: { type: "number" },
                        DATP: { type: "date" },
                        VDAT: { type: "date" },
                        REC: { type: "number" },
                        FN_A: { type: "string" },
                        DAT_A: { type: "date" },
                        REC_A: { type: "number" },
                        FN_B: { type: "string" },
                        DAT_B: { type: "date" },
                        DATD: { type: "date" },
                        REC_B: { type: "number" },
                        D_REC: { type: "number" },
                        REF: { type: "number" },
                        SOS: { type: "number" },
                        ND: { type: "string" },
                        NAZN: { type: "string" },
                        NAM_A: { type: "string" },
                        NBA: { type: "string" },
                        NAM_B: { type: "string" }
                    }
                }
            }
        }
    });
    $('#SepArcDocumentsToolBar').kendoToolBar({
        items: [
            {
                template: "<button id='pbFilter' type='button' class='k-button' title='Складний фільтр'><i class='pf-icon pf-16 pf-filter-ok'></i></button>"
            },
            {
                template: "<button id='Reload' type='button' class='k-button' onclick='reloadGrid()' title='Оновити грід'><i class='pf-icon pf-16 pf-filter-remove'></i></button>"
            },
            {
                template: "<button id='pbViewDoc' type='button' class='k-button' onclick='openDocByDblClick()' title='Переглянути документ'><i class='pf-icon pf-16 pf-folder_open'></i></button>"
            }
            //{
            //    template: "<button id='excel' type='button' class='k-button' title='Друк'><i class='pf-icon pf-16 pf-print'></i></button>"
            //}

        ]
    });

    $("#SepArcDocumentsGrid").on("dblclick", "tbody > tr", openDocByDblClick);

    $("#excel").click(function () {
        $("#SepArcDocumentsGrid").data('kendoGrid').saveAsExcel();
    });

    $("#pbFilter").kendoButton({
        click: function () {
            bars.ui.getFiltersByMetaTable(function (response, success) {
                debugger;
                if (!success)
                    return false;
                var grid = $("#SepArcDocumentsGrid").data("kendoGrid");
                var model = SearchByDocDate();
                if (response && response.length > 0) {
                  
                    filterParam = response[0];
                    var res = getFilterParam();
                    
                    if (res != undefined)
                        model.flt += ' and ' + res;
                    grid.dataSource.read({
                        flt: model.flt
                    });
                }
                else
                {
                    filterParam = '';
                    grid.dataSource.read({
                        flt: model.flt
                    });
                }
                   

            }, { tableName: "V_ARCHIVE_DOCS" });
        }
    });
    //$('body').on('click', '#submit', reloadGrid());
});
function SearchByParams() {
    var res = SearchByDocDate();
    var params = getFilterParam();
    if (params != undefined && params != '')
        res.flt += ' and ' + params;
    return res;
}

function SearchByDocDate() {
    var grid = $("#SepArcDocumentsGrid").data("kendoGrid");
    var dStrt = $("#dateStart").val();
    var dEnd = $("#dateEnd").val();
    var res = "DAT_A between to_date('" + dStrt + "', 'dd.mm.yyyy') and to_date('" + dEnd + "', 'dd.mm.yyyy')"
    return { flt: res };
}

var filterParam = '';
/**
 * повертає значення фільтру у вигляді стринга
 */
function getFilterParam() {
    debugger;
    var result = '';
    var paramType = typeof filterParam;
    if (filterParam && paramType === "string") {
        result = filterParam;
    } else if (filterParam && paramType === "object") {
        result = filterParam[0];
    }
    return result.toString();
}

function reloadGrid() {
    $('#SepArcDocumentsGrid').data('kendoGrid').dataSource.read();
}

/**
 * при натисканні на запис в табліці двічі перенаправляє на → парегляд докменту
*/
function openDocByDblClick() {
    var grid = $("#SepArcDocumentsGrid").data("kendoGrid");
    var record = grid.dataItem(grid.select());
    OpenModalDoc(record);
}
function openDocByRow(row) {
    if (row.REF != null) {

        var docUrl = bars.config.urlContent("/documents/item/" + row.REF + "/");
        window.location = docUrl;
    }
}

function OpenModalDoc(row) {
    $.get(bars.config.urlContent('/sep/sep3720/getrefbyrec'), { recId: row.REC }).done(function (result) {
        if (result.data == null && row.REF != "") {
            var docUrl = bars.config.urlContent("/documents/item/" + row.REF + "/");
            window.showModalDialog(docUrl, null, 'dialogWidth:790px;dialogHeight:550px');
        } else {
            if (result.data.REF !== 0) {
                var docUrl = bars.config.urlContent("/documents/item/" + result.data.REF + "/");
                window.showModalDialog(docUrl, null, 'dialogWidth:790px;dialogHeight:550px');
            } else {
                var sepDocViewer = bars.sepfiles.sepDocViewer;
                sepDocViewer.loadFirstTab(result.data);
                sepDocViewer.loadSecondTab.part1(result.data);
                sepDocViewer.loadSecondTab.part2(result.data);
                sepDocViewer.show();
            }
        }
    });
}