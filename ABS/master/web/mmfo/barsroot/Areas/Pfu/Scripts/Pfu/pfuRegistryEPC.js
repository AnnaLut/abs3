/**
 * Created by serhii.karchavets on 04.08.2016.
 */
// Constans
var EPC_DESTROYED_STATE = 19;
var KEY_CODE_ENTER = 13;
var INITIAL_TAB_INDEX = 0;
var INITIAL_EPC_LINE_STATUS = 3;

var g_registersGridCounter = 0;
var g_registersLinesGridCounter = 0;

var g_filterRegistersGrid = null;
var g_filterRegistersLinesGrid = null;

var g_curTabIndex = -1;
var g_isGridRegistersLinesInited = false;

////////////

function OnClickRow(eppId) {
    OpenWindowDestroyedEpcInfo(eppId);
}

function OpenWindowDestroyedEpcInfo(EPP_NUMBER) {
    $.ajax({
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        url: bars.config.urlContent("/api/pfu/filesgrid/destroyedepcinfo?epcId=" + EPP_NUMBER),
        success: function (data) {
            if(data != null && data != undefined){
                var detailsTemplate = kendo.template($("#template").html());
                $("#dialogRemoveFromPay").data('kendoWindow').content(detailsTemplate(data));
                $("#dialogRemoveFromPay").data('kendoWindow').center().open();
            }
            else{
                //console.warn("OpenWindowDestroyedEpcInfo - data is empty for:"+EPP_NUMBER);
            }
        }
    });
}

// население грида с строками реестра
function initRegistersLinesGrid(qv) {
    g_filterRegistersLinesGrid = qv;

    fillKendoGrid("#gridRecords", {
        transport: { read: {
            url: bars.config.urlContent("/api/pfu/filesgrid/searchregisterlinesepc"),
            data: function () { return g_filterRegistersLinesGrid;
            }
        } },
        schema: {
            model: {
                fields: {
                    EPP_NUMBER: { type: "string" },
                    ACCOUNT_NUMBER: { type: "string" },
                    FIO: { type: "string" },
                    TAX_REGISTRATION_NUMBER: { type: "string" },
                    PHONE_NUMBERS: { type: "string" },
                    DOCUMENT_ID: { type: "string" },
                    TYPE: { type: "string" },
                    BANK_NUM: { type: "string" },
                    ERR_TAG: { type: "string" },
                    STATE_ID: { type: "number" }
                }
            }
        }
    }, {
        columns: [
            {
                title: "№ п/п",
                template: "#= ++g_registersLinesGridCounter #",
                width: "3%"
            },
            {
                field: "EPP_NUMBER",
                title: "Ідентифікатор<br>електронного<br>пенсійного",
                width: "%10"
            },
            {
                field: "ACCOUNT_NUMBER",
                title: "Номер<br>рахунка",
                width: "%10"
            },
            {
                field: "FIO",
                title: "ПІБ<br>клієнта",
                width: "%10",
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "TAX_REGISTRATION_NUMBER",
                title: "ІПН<br>клієнта",
                width: "%10"
            },
            {
                field: "PHONE_NUMBERS",
                title: "Контактний<br>номер<br>телефону",
                width: "%10"
            },
            {
                field: "DOCUMENT_ID",
                title: "Серія та<br>номер<br>документу",
                width: "%10"
            },
            {
                field: "TYPE",
                title: "Ознака<br>пенсійних<br>виплат",
                width: "%10"
            },
            {
                field: "BANK_NUM",
                title: "Код філії/відділення<br>банку де особа<br>отримуватиме картку",
                width: "%10"
            },
            {
                field: "ERR_TAG",
                title: "Теги<br>помилок",
                width: "%10"
            },
            {
                field: "STATE_ID",
                title: "Статус",
                width: "%10",
                template:'#= getStatusById(STATE_ID, EPP_NUMBER) #',
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataBinding: function (res) { g_registersLinesGridCounter = (this.dataSource.page() -1) * this.dataSource.pageSize(); }
    }, null);
}

// население грида с реестрами
function initRegistersGrid(qv) {
    g_filterRegistersGrid = qv;

    fillKendoGrid("#gridFiles", {
        type: "webapi",
        sort: [ { field: "id", dir: "desc" } ],
        transport: {
            read: {
                url: bars.config.urlContent("/api/pfu/filesgrid/searchregisterepc"),
                data: function () { return g_filterRegistersGrid; }
            }
        },
        schema: {
            model: {
                fields: {
                    ID: { type: "number" },
                    NAME: { type: "number" },
                    BATCH_DATE: { type: "date" },
                    BATCH_LINES_COUNT: { type: "number" },
                    COUNT_GOOD: { type: "number" },
                    STATE: { type: "string" }
                }
            }
        }
    }, {
        columns: [
            {
                title: "№ п/п",
                template: "#= ++g_registersGridCounter #",
                width: "3%"
            },
            {
                field: "ID",
                title: "ID реєстру",
                width: "5%"
            },
            {
                field: "NAME",
                title: "Найменування реєстру",
                width: "10%"
            },
            {
                field: "BATCH_DATE",
                title: "Дата<br>створення",
                width: "5%",
                template: "<div style='text-align:center;'>#=(BATCH_DATE == null) ? ' ' : kendo.toString(BATCH_DATE,'dd.MM.yyyy')#</div>"
            },
            {
                field: "BATCH_LINES_COUNT",
                title: "Кількість<br>інформаційних<br>рядків загальна",
                attributes: { "class": "text-right" },
                width: "10%"
            },
            {
                field: "COUNT_GOOD",
                title: "Кількість<br>інформаційних<br>рядків з помилками",
                attributes: { "class": "text-right" },
                width: "10%"
            },
            {
                field: "STATE",
                title: "Статус",
                width: "10%"
            }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataBinding: function() { g_registersGridCounter = (this.dataSource.page() -1) * this.dataSource.pageSize(); },
    }, "#fileTitle-template");
}

function getSearchDataRegisters(qv) {
    g_filterRegistersGrid = qv;
    var grid = $("#gridFiles").data("kendoGrid");
    if (grid)
        grid.dataSource.fetch();
}

function getSearchDataRegistersLines(qv) {
    g_filterRegistersLinesGrid = qv;
    var grid = $("#gridRecords").data("kendoGrid");
    if (grid)
        grid.dataSource.fetch();
}

function SearchRegister() {
    var qv = {};
    var RegisterDate = $("#searchDate").data("kendoDatePicker").value();
    qv.RegisterDate = kendo.toString(RegisterDate, "MM.dd.yyyy");
    qv.RegisterId = NullOrValue($("#searchId").val());

    getSearchDataRegisters(qv);
}

function SearchRegisterLines() {
    var qv = {};
    qv.FullName = NullOrValue($("#searchFullName").val());
    qv.TaxID = NullOrValue($("#searchTaxID").val());
    qv.EpcId = NullOrValue($("#searchEPC").val());
    qv.State = NullOrValue($("#searchState").val());

    getSearchDataRegistersLines(qv);
}

function SwitchFilters() {
    if(g_curTabIndex == 1){
        $("#dvFilesFilter").hide();
        $("#reestrRowsEpc").show();
        if(!g_isGridRegistersLinesInited){
            g_isGridRegistersLinesInited = true;
            initRegistersLinesGrid(g_filterRegistersLinesGrid != null ? g_filterRegistersLinesGrid : {FullName: null, TaxID: null, EpcId: null, State: 3});
        }
        else{
            getSearchDataRegistersLines(g_filterRegistersLinesGrid);
        }
    }
    else{
        $("#dvFilesFilter").show();
        $("#reestrRowsEpc").hide();
    }
}

function onChangeTab(e) {
    g_curTabIndex = (g_curTabIndex < 0) ? INITIAL_TAB_INDEX : (1 - g_curTabIndex);
    SwitchFilters();
}

function getStatusById(stateId, EPP_NUMBER) {
    var grid = $("#searchState").data("kendoDropDownList");
    var ds = grid.dataSource;
    var value = getNameById(stateId, ds._data, 'ID', 'NAME');
    if(EPC_DESTROYED_STATE == stateId)
    {
        return '<a href="#" onclick="OnClickRow(\''+EPP_NUMBER+'\')" class="destroyed">' + value + '</a>';
    }
    return value;
}

$(document).ready(function () {
    fillDropDownList("#searchState", {
        transport: {read: {url: bars.config.urlContent("/api/pfu/filesgrid/pfuepclinestatus")}},
        schema: {model: {fields: { ID: { type: "number" }, NAME: { type: "string" } }}}
    }, {
        value: INITIAL_EPC_LINE_STATUS, dataTextField: "NAME", dataValueField: "ID"
    });

    // init tabs
    $("#tabstrip").kendoTabStrip({ animation: false, select: onChangeTab }).data("kendoTabStrip").select(INITIAL_TAB_INDEX);

    $("#title").html("Перегляд реєстрів та результатів обробки інформаційних рядків ЕПП");

    initRegistersGrid({ RegisterId: null, RegisterDate: null});

    $("#searchDate").kendoDatePicker({ format: "dd.MM.yyyy" });
    $('#SearchFiles').click(SearchRegister);
    $('#SearchEpcBtn').click(SearchRegisterLines);

    $(document.body).keydown(function (e) { if (e.keyCode == KEY_CODE_ENTER) {
        e.preventDefault(); // Stops IE from triggering the button to be clicked
        if(g_curTabIndex == 0){
            SearchRegister();
        }
        else{
            SearchRegisterLines();
        }
    } });

    InitGridWindow({windowID: "#dialogRemoveFromPay", srcSettings: {title: "Додаткова інформація про видалене ЕПП"}});
});

