/**
 * Created by serhii.karchavets on 12.08.2016.
 */
var INITIAL_TAB_INDEX = 0;

var g_curTabIndex = -1;
var g_gridCounter = 0;
var g_gridCheckedCounter = 0;
var g_isGridCatalogInited = false;

var g_recordStatusData = null;
var g_HistoryGridInited = false;

function getGridLinesCheckedUrl(ID){
    return bars.config.urlContent("/api/pfu/filesgrid/linecatalog?id=" + ID);
}

function getStatusById(state) {
    return getNameById(state, g_recordStatusData, 'STATE', 'STATE_NAME');
}

function getRecordStatus() {
    if (g_recordStatusData == null) {
        var dataSource = CreateKendoDataSource({
            transport: {read:{url: bars.config.urlContent("/api/pfu/filesgrid/recordstatus")}},
            schema: {model: {fields: {STATE: { type: "number" }, STATE_NAME: { type: "string" }}}}
        });
        dataSource.fetch(function () {
            g_recordStatusData = this.data();
        });
    }
}

var MAIN_GRID_FIELDS = {
    ID: { type: "number" },
    ENVELOPE_REQUEST_ID: { type: "number" },
    CHECK_SUM: { type: "number" },
    CHECK_LINES_COUNT: { type: "number" },
    PAYMENT_DATE: { type: "date" },
    FILE_NUMBER: { type: "number" },
    FILE_NAME: { type: "string" },
    STATE_NAME: { type: "string" },
    CRT_DATE: { type: "date" },
};


var HISTORY_GRID_FIELDS = {
    ID: { type: "number" },
    ENVELOPE_REQUEST_ID: { type: "number" },
    CHECK_SUM: { type: "number" },
    CHECK_LINES_COUNT: { type: "number" },
    PAYMENT_DATE: { type: "date" },
    FILE_NUMBER: { type: "number" },
    FILE_NAME: { type: "string" },
    STATE_NAME: { type: "string" },
    CRT_DATE: { type: "date" },
    USERNAME: { type: "string" }
};
var HISTORY_GRID_COLUMNS = [
 {
     title: "№ п/п",
     template: "#= ++g_gridCounter #",
     width: "4%"
 },
    {
        field: "ID",
        title: "ID<br/>реєстру",
        width: "8%"
    },
    {
        field: "ENVELOPE_REQUEST_ID",
        title: "ID запиту в ПФУ",
        width: "10%"
    },
    {
        field: "FILE_NAME",
        title: "Найменування<br/>реєстру",
        width: "10%"
    },
    {
        field: "CRT_DATE",
        title: "Дата створення<br/>реєстру",
        width: "10%",
        template: "<div style='text-align:center;'>#=(PAYMENT_DATE == null) ? ' ' : kendo.toString(PAYMENT_DATE,'dd.MM.yyyy')#</div>"
    },
    {
        field: "CHECK_LINES_COUNT",
        title: "Кількість<br>інформаційних<br>рядків",
        width: "10%"
    },
    {
        field: "PAYMENT_DATE",
        title: "Дата платіжного<br/>календаря",
        width: "10%",
        template: "<div style='text-align:center;'>#=kendo.toString(PAYMENT_DATE,'dd.MM.yyyy')#</div>"
    },
    {
        field: "PAY_DATE",
        title: "Дата фактичної<br/>оплати",
        width: "10%"
    },
    {
        field: "DATE_SEND",
        title: "Дата/час<br/>відправки<br/>реєстру в ПФУ",
        width: "10%"
    },
    {
        field: "USERNAME",
        title: "Відповідальний<BR/>виконавець",
        width: "10%"
    },

    {
        field: "STATE_NAME",
        title: "Статус реєстру",
        width: "10%"
    },
];
var GRID_COLUMNS = [
    {
        title: "№ п/п",
        template: "#= ++g_gridCounter #",
        width: "3%"
    },
    {
        field: "ID",
        title: "ID реєстру",
        width: "8%"
    },
    {
        field: "ENVELOPE_REQUEST_ID",
        title: "ID запиту в ПФУ",
        width: "10%"
    },
    {
        field: "FILE_NAME",
        title: "Найменування реєстру",
        width: "10%"
    },
    {
        field: "CRT_DATE",
        title: "Дата створення реєстру",
        width: "10%",
        template: "<div style='text-align:center;'>#=(PAYMENT_DATE == null) ? ' ' : kendo.toString(PAYMENT_DATE,'dd.MM.yyyy')#</div>"
    },
    {
        field: "CHECK_LINES_COUNT",
        title: "Кількість<br>інформаційних<br>рядків",
        width: "10%"
    },
    {
        field: "PAYMENT_DATE",
        title: "Дата платіжного<br/>календаря",
        width: "10%",
        template: "<div style='text-align:center;'>#=kendo.toString(PAYMENT_DATE,'dd.MM.yyyy')#</div>"
    },
    {
        field: "USERID",
        title: "Дата фактичної<br/>оплати",
        width: "10%",
        hidden:true
    },
    {
        field: "STATE_NAME",
        title: "Статус реєстру",
        width: "10%"
    },
];
var MAIN_GRID_COLUMNS = GRID_COLUMNS.slice();
// MAIN_GRID_COLUMNS.unshift(
// {
//     field: "block",
//     title: " ",
//     filterable: false,
//     sortable: false,
//     template: "<input type='checkbox' class='checkbox' style='margin-left: 26%;' />",
//     width: "3%"
// });

function confirmEdit() {
    confirmGridWindow({
        windowGridID: "#gridEdit",
        windowID: "#dialogEdit",
        srcGridID: "#gridLinesChecked",
        srcSettings: {url: bars.config.urlContent("/api/pfu/filesgrid/readypaybackkvit2")},
        grabData: [{key: "id"}, {key: "DATE_PAYBACK"}, {key: "NUM_PAYM"}]
    });
}

function Edit() {
    openGridWindow({
        srcGridID: "#gridLinesChecked",
        windowGridID: '#gridEdit',
        windowID: '#dialogEdit',
        srcDataSource: {schema: {
            model: {
                fields: {
                    id: { type: "number" },
                    full_name: { type: "string"},
                    DATE_PAYBACK: { type: "date"},
                    NUM_PAYM: {type: "string"}
                }
            }
        }},
        srcSettings: {editable: true,
            columns: [
                {
                    field: "full_name",
                    title: "ПІБ отримувача",
                    width: 220,
                    editable: false,
                    attributes: { style: "text-overflow: ellipsis; white-space: nowrap;" }
                },
                {
                    field: "DATE_PAYBACK",
                    title: "Дата платіжного доручення повернення коштів",
                    template: "<div style='text-align:center;'>#=(DATE_PAYBACK == null) ? ' ' : kendo.toString(DATE_PAYBACK,'dd.MM.yyyy')#</div>"

                },
                {
                    field: "NUM_PAYM",
                    title: "Номер платіжного доручення повернення коштів"
                }
            ]},
        grabData: [{key: 'id', defaultValue: null}, {key: 'DATE_PAYBACK', defaultValue: null},
            {key: 'NUM_PAYM', defaultValue: null}, {key: 'full_name', defaultValue: null}]
    });
}

function confirmSend() {
    approveMatching();
}

function Send() {
    openGridWindow({
        srcGridID: "#gridFiles",
        windowGridID: '#gridSend',
        windowID: '#dialogSend',
        srcDataSource: {schema: {
            model: {
                fields: {
                    ID: { type: "number" },
                    FILE_NUMBER: { type: "number"},
                    FILE_NAME: { type: "string"}
                }
            }
        }},
        srcSettings: {editable: false,
            columns: [
            {
                field: "FILE_NUMBER",
                title: "ID файлу",
                width: 220,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "FILE_NAME",
                title: "Найменування файлу",
                width: 220,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            }
        ]},
        grabData: [{key: 'FILE_NUMBER', defaultValue: null}, {key: 'FILE_NAME', defaultValue: null}, {key: 'ID', defaultValue: null}]
    });
}

function updateHistoryGrid() {
    var grid = $("#gridMain").data("gridHistory");
    if (grid){grid.dataSource.fetch();}
}

function initGridHistory() {
    debugger;
    fillKendoGrid("#gridHistory", {
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/pfu/filesgrid/searchkvitsendhistory") } },
        schema: { model: { fields: HISTORY_GRID_FIELDS } }
    }, {
        columns: HISTORY_GRID_COLUMNS,
        selectable: "multiple",
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataBinding: function() { g_gridCounter = (this.dataSource.page() -1) * this.dataSource.pageSize(); }
    }, "#fileTitleHistory-template");
}

function initGridChecked(FileId) {
    Waiting(true);
    debugger;
    $('#lineFileIdChecked').html(" №" + FileId);
    fillKendoGrid("#gridLinesChecked", {
        type: "aspnetmvc-ajax",
        transport: { read: { url: getGridLinesCheckedUrl(FileId) } },
        schema: {
            model: {
                fields: {
                    id: { type: "number" },
                    full_name: { type: "string" },
                    numident: { type: "string" },
                    payment_date: { type: "date" },
                    date_enr: { type: "string" },
                    date_income: { type: "date" },
                    num_acc: { type: "string" },
                    mfo: { type: "string" },
                    sum_pay: { type: "number" },
                    Ref: { type: "number" },
                    state: { type: "number" },
                    DATE_PAYBACK: {type: "date"},
                    NUM_PAYM: {type: "string"}
                }
            }
        }
    }, {
        columns: [
            {
                field: "block",
                title: " ",
                filterable: false,
                sortable: false,
                template: "<input type='checkbox' class='checkbox' style='margin-left: 26%;' />",
                width: "3%"
            },
            {
                field: "id",
                title: "ID",
                width: "5%"
            },
            {
                field: "full_name",
                title: "ПІБ отримувача",
                width: "15%",
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "numident",
                title: "ІПН",
                width: "8%"
            },
            {
                field: "payment_date",
                title: "Дата<br>зарахування",
                width: "10%",
                template: "<div style='text-align:center;'>#=kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
            },
            {
                field: "num_acc",
                title: "Номер рахунку",
                width: "12%"
            },
            {
                field: "mfo",
                title: "Код МФО",
                width: "9%"
            },
            {
                field: "sum_pay",
                title: "Сума",
                template: '#=kendo.toString(sum_pay,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "15%"
            },
             {
                 field: "Ref",
                 title: "Платіжне<br>доручення",
                 width: "12%"
             },
            {
                field: "state",
                title: "Статус",
                width: "13%",
                template:'#= getStatusById(state) #',
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "DATE_PAYBACK",
                title: "Дата платіжного<br>доручення повернення<br>коштів",
                width: "12%",
                template: "<div style='text-align:center;'>#=(DATE_PAYBACK == null) ? ' ' : kendo.toString(DATE_PAYBACK,'dd.MM.yyyy')#</div>"
            },
            {
                field: "NUM_PAYM",
                title: "Номер платіжного<br>доручення повернення<br>коштів",
                width: "12%"
            }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataBinding: function() { g_gridCheckedCounter = (this.dataSource.page() -1) * this.dataSource.pageSize(); }
    }, "#linesTitleChecked-template");
}

function initGridHistoryChecked(FileId) {
    Waiting(true);
    debugger;
    $('#lineFileIdChecked').html(" №" + FileId);
    fillKendoGrid("#gridLinesChecked", {
        type: "aspnetmvc-ajax",
        transport: { read: { url: getGridLinesCheckedUrl(FileId) } },
        schema: {
            model: {
                fields: {
                    id: { type: "number" },
                    full_name: { type: "string" },
                    numident: { type: "string" },
                    payment_date: { type: "date" },
                    date_enr: { type: "string" },
                    date_income: { type: "date" },
                    num_acc: { type: "string" },
                    mfo: { type: "string" },
                    sum_pay: { type: "number" },
                    Ref: { type: "number" },
                    state: { type: "number" },
                    DATE_PAYBACK: { type: "date" },
                    NUM_PAYM: { type: "string" }
                }
            }
        }
    }, {
        columns: [

            {
                field: "id",
                title: "ID запиту в ПФУ",//"ID",
                width: "5%",
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "n0"
                        });
                    }
                }

            },
            {
                field: "full_name",
                title: "ПІБ отримувача",
                width: "15%",
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "numident",
                title: "ІПН",
                width: "8%"
            },
            {
                field: "payment_date",
                title: "Дата<br>зарахування",
                width: "10%",
                template: "<div style='text-align:center;'>#=kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
            },
            {
                field: "num_acc",
                title: "Номер рахунку",
                width: "12%"
            },
            {
                field: "mfo",
                title: "Код МФО",
                width: "9%"
            },
            {
                field: "sum_pay",
                title: "Сума",
                template: '#=kendo.toString(sum_pay,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "15%"
            },
             {
                 field: "Ref",
                 title: "Платіжне<br>доручення",
                 width: "12%"
             },
            {
                field: "state",
                title: "Статус",
                width: "13%",
                template: '#= getStatusById(state) #',
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "DATE_PAYBACK",
                title: "Дата платіжного<br>доручення повернення<br>коштів",
                width: "12%",
                template: "<div style='text-align:center;'>#=(DATE_PAYBACK == null) ? ' ' : kendo.toString(DATE_PAYBACK,'dd.MM.yyyy')#</div>"
            },
            {
                field: "NUM_PAYM",
                title: "Номер платіжного<br>доручення повернення<br>коштів",
                width: "12%"
            }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataBinding: function () { g_gridCheckedCounter = (this.dataSource.page() - 1) * this.dataSource.pageSize(); }
    }, "#linesHistoryTitleChecked-template");
}

function initGrid() {
    debugger;
    fillKendoGrid("#gridFiles", {
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/pfu/filesgrid/searchkvitsend") } },
        schema: { model: { fields: MAIN_GRID_FIELDS } }
    }, {
        columns: MAIN_GRID_COLUMNS,
        selectable: "multiple",
        dataBinding: function() { g_gridCounter = (this.dataSource.page() -1) * this.dataSource.pageSize(); }
    }, "#fileTitle-template");
}

function goToFiles() {
    debugger;
    if (!$("#gridHistory").is(":visible"))
        $("#gridHistory").show();
    if (!$("#gridFiles").is(":visible"))
        $("#gridFiles").show();
    $("#gridLinesChecked").hide();
    
}

function goToHistoryFiles() {
    debugger;
    if (!$("#gridHistory").is(":visible"))
        $("#gridHistory").show();
    if (!$("#gridFiles").is(":visible"))
        $("#gridFiles").show();
    $("#gridLinesChecked").hide();

}

// детализация
function goToLines() {
    var gview = $("#gridFiles").data("kendoGrid");
    var selectedCatalog = gview.dataItem(gview.select());
    if (selectedCatalog !== null) {
        $("#gridFiles").hide();
        $("#gridLinesChecked").show();
        if(!g_isGridCatalogInited){
            g_isGridCatalogInited = true;
            initGridChecked(selectedCatalog.ID);
        }
        else{
            $('#gridLinesChecked').data('kendoGrid').dataSource.transport.options.read.url = getGridLinesCheckedUrl(selectedCatalog.ID);
            $('#gridLinesChecked').data('kendoGrid').dataSource.page(1);
        }
    }
}
function goToLinesHistory() {

    var gview = $("#gridHistory").data("kendoGrid");
    var selectedCatalog = gview.dataItem(gview.select());
    if (selectedCatalog !== null) {
        $("#gridHistory").hide();
        $("#gridLinesChecked").show();
        if (!g_isGridCatalogInited) {
            g_isGridCatalogInited = true;
            initGridHistoryChecked(selectedCatalog.ID);
        }
        else {
            $('#gridLinesChecked').data('kendoGrid').dataSource.transport.options.read.url = getGridLinesCheckedUrl(selectedCatalog.ID);
            $('#gridLinesChecked').data('kendoGrid').dataSource.page(1);
        }
    }
}

function onChangeTab(e) {
    g_curTabIndex = (g_curTabIndex < 0) ? INITIAL_TAB_INDEX : (1 - g_curTabIndex);
    if(g_curTabIndex == 0){
        goToFiles();
        initGrid();
        $("#SendBtn").show();
    }
    else{
        $("#gridLinesChecked").hide();
        $("#SendBtn").hide();
        goToHistoryFiles();
        if(g_HistoryGridInited){
            updateHistoryGrid()
        }
        else{
            g_HistoryGridInited = true;
            initGridHistory();
        }
    }
}

////************************************************
////***************** SIGN *************************
////************************************************
// get all signID keys from BarsCryptor (used only first elem in keyResponse.Keys !!!)
function approveMatching() {
    debugger;
    var tabStrip = $(".k-state-active");
    var namegrid = "";
    if (tabStrip[0].innerText === "Реєстри готові до відправки ПФУ")
        namegrid = "#gridFiles"
    else
        namegrid = "#gridHistory"
    $('#SendBtn').attr("disabled", "disabled");
    $('#SendBtnHistory').attr("disabled", "disabled");
    var gview = $(namegrid).data("kendoGrid");
    selected_ids = []
    var rows = gview.select()
    for (var i = 0; i < rows.length; i++) {
        id = (gview.dataItem(rows[i])).ID
        selected_ids.push(id);
    }
    var selected = gview.dataItem(gview.select());
    if (selected === null) {
        $('#SendBtn').removeAttr("disabled", "disabled");
        $('#SendBtnHistory').removeAttr("disabled", "disabled");
        bars.ui.error({ title: 'Помилка!', text: 'Необхідно вибрати реєстр!' });
        return;
    }
    debugger;
    initSign(selected_ids, 2, namegrid);
}

////************************************************
////************************************************
////************************************************

$(document).ready(function () {

    getRecordStatus();

    InitGridWindow({windowID: "#dialogSend", srcSettings: {title: "Відправка файлів в ПФУ"}});
    InitGridWindow({windowID: "#dialogEdit", srcSettings: {title: "Редагування данних платіжного доручення"}});

    // init tabs
    var tabStrip = $("#tabstrip").kendoTabStrip({
        animation: false, select: onChangeTab
    }).data("kendoTabStrip").select(0);

    //tabStrip.disable(tabStrip.tabGroup.children().eq(1));   // hide 'history' tab for envelop page

    $('#confirmSend').click(confirmSend);
    $('#confirmEdit').click(confirmEdit);
    // $(document.body).keydown(function (e) { if (e.keyCode == KEY_CODE_ENTER) { Send(); } });

    $("#ddlViewBy").change(function () {
        debugger;
        var value = $('#ddlViewBy').val();
        window.location.href = GetKvitHref(value);

    });

    $('#SelectFiles').click(function () {
        debugger;
        var value = $('#ddlViewBy').val();
        window.location.href = GetKvitHref(value);
    });
});