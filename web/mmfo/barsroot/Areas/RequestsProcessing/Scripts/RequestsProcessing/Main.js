///*** GLOBALS
var PAGE_INITIAL_COUNT = 10;
var g_gridRequestResultInited = false;
var g_dictData = null;
var g_pageable = {
    messages: {
        allPages: "Всі"
    },
    refresh: true,
    pageSizes: [PAGE_INITIAL_COUNT, 50, 200, 1000, "All"],
    buttonCount: 5
};
var g_dynamicRequestData = null;
var g_fileName = "";
var g_defaultDileName = "result";
var g_dictSelectedIndexes = {};
var moneyWildcards = ["оборот", "кредит", "дебет", "залишок", "сума", "тіло"];
///***

/// Parse string like ":sFdat1='',:T='Код папки (0-всі)',:I='Код викон(0=всi)'"
/// Result: ["sFdat1=''",    "T='Код папки (0-всі)'",    "I='Код викон(0=всi)'"]
function parseRow(parseString, isSplitEq) {
    var sList = [];
    var sb = "";
    for (var i = 0; i < parseString.length; i++) {
        var curS = parseString[i];
        if (curS == ',' && i < parseString.length + 1 && parseString[i + 1] == ':') {
            continue;
        }
        if (curS == ':') {
            if (sb != "") {
                sList.push(isSplitEq ? sb.split('=') : sb);
                sb = "";
            }
        }
        else {
            sb += curS;
        }
    }
    // put last item
    if (sb != "") {
        sList.push(isSplitEq ? sb.split('=') : sb);
        sb = "";
    }
    return sList;
}

function parseDate(dateString, format) {
    if (!dateString) {
        return null;
    }
    if (format == undefined) {
        format = 'dd.MM.yyyy HH:mm:ss';
    }

    if (typeof dateString !== 'string') {
        return kendo.toString(dateString, format);
    }
    return kendo.toString(new Date(dateString.match(/\d+/)[0] * 1), format);
};


function onClickOpenDict(e) {
    if (g_dictData != null) {
        var grid = $('#gridDynamicRequestParams').data("kendoGrid");
        if (grid) {
            var dialog = $("#dialogDict").data("kendoWindow");

            var row = grid.dataItem(grid.select());     // parameter row selected
            if (row) {
                var i;
                var index = -1;
                for (i = 0; i < g_dictData.length; i++) {
                    var ID = g_dictData[i].ID;
                    if (ID == row.ID) {
                        index = i;      //found main data for selected param
                        break;
                    }
                }
                if (index == -1) {
                    console.error("Error index " + row.ID + " " + g_dictData);        // oops...
                }

                var title = g_dictData[index].tableSemantic["semantic"];
                dialog.title(title);        //set dict title

                var colnameID = null;
                var columns = [];
                var fields = {};
                var tableColumns = g_dictData[index].tableColumns;
                for (i = 0; i < tableColumns.length; i++) {
                    var colname = tableColumns[i].colname;
                    if (i == 0) { colnameID = colname; }
                    var semantic = tableColumns[i].semantic;
                    semantic = replaceAll(semantic, '~', ' ');
                    fields[colname] = { type: "string" };
                    columns.push({
                        field: colname,
                        title: semantic
                    });
                }

                var data = g_dictData[index].data;
                for (var o = 0; o < data.length; o++) {
                    for (var attr in data[o]) {
                        if (data[o][attr].toString().indexOf("/Date") != -1) {
                            data[o][attr] = parseDate(data[o][attr], 'dd.MM.yyyy');
                        }
                    }
                }

                // fill dict grid
                var dstDataSource = {
                    data: data,
                    pageSize: 10,
                    schema: { model: { fields: fields } }
                };
                var dictGridData = new kendo.data.DataSource(dstDataSource);
                var dictGridSettings = {
                    sortable: true,
                    resizable: true,
                    scrollable: true,
                    selectable: "row",
                    dataSource: dictGridData,
                    filterable: true,
                    columns: columns
                };
                $("#gridDict").kendoGrid(dictGridSettings);
                $("#gridDict").delegate("tbody>tr", "dblclick", function (e) {
                    e.preventDefault();

                    var gridDict = $('#gridDict').data("kendoGrid");
                    var rowDict = gridDict.dataItem(gridDict.select());
                    var value = rowDict[colnameID];
                    if (value != undefined) {
                        g_dictSelectedIndexes[colnameID] = gridDict.select().index();
                        row.set("VALUE", value);
                        row.dirty = true;
                    }
                    dialog.close();
                });
            }
        }
    }
    dialog.center().open();
}

function onClickExport2Excel(e) {
    var grid = $("#gridDynamicRequestResult").data("kendoGrid");
    grid.saveAsExcel();
}

function confirmExport2Text() {
    var fName = $("#fNameTxt").val();
    if (fName == null || fName == "") { fName = g_defaultDileName; }
    var separator = $("#separatorText").val();
    var params = "";
    var KODZ = g_dynamicRequestData.KODZ;
    var PARAMS = g_dynamicRequestData.PARAMS;
    for (var i = 0; i < PARAMS.length; i++) {
        var ID = PARAMS[i].ID;
        var VALUE = PARAMS[i].VALUE;
        params += ID + ";" + VALUE;
        if (i < PARAMS.length - 1) {
            params += "|";
        }
    }

    var ds = $("#gridDynamicRequestResult").data("kendoGrid").dataSource;
    $("#dialogExport2Text").data('kendoWindow').close();

    var isAllPages = $("#isAllPages").prop("checked");
    var count = isAllPages ? ds.total() : ds.pageSize();

    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());
    var showHeaders = row ? !(parseInt(row.KODZ, 10) == 1012073) : true;

    var url = '/api/RequestsProcessing/RequestsProcessing/GetTextFile' +
        "?fName=" + encodeURIComponent(fName) +
        "&columnSeparator=" + separator +
        "&page=" + ds.page() +
        "&pageSize=" + count +
        "&kodz=" + KODZ +
        "&param=" + params +
        "&showHeaders=" + showHeaders;
    window.location = bars.config.urlContent(url);
}

function onClickExport2Text(e) {
    $("#dialogExport2Text").data('kendoWindow').center().open();

    var fName = g_fileName != null && g_fileName != "" ? g_fileName : g_defaultDileName;

    // todo: hack for #A7 1012073 ,sorry
    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());
    if (row && parseInt(row.KODZ, 10) == 1012073 && g_dictData.length > 0 && g_dictData[0].data.length) {
        //result: B20170111_#A7ILP4D_CB1_01.csv

        var index = g_dictSelectedIndexes['DATZ'] != undefined ? g_dictSelectedIndexes['DATZ'] : 0;
        var f = g_dictData[0].data[index].FILENAME;

        fName = "B" + f.substr(17, 4) + f.substr(15, 2) + f.substr(13, 2) + "_" +
            f.substr(0, 8) + "_" + f.substr(9, 3) + "_0" + f.substr(11, 1) + ".csv";
    }

    $("#fNameTxt").val(fName);
}

function onClickRequestResult(e) {
    g_dictData = null;      // clear dict data

    var grid = $('#gridMain').data("kendoGrid");
    if (grid) {
        var row = grid.dataItem(grid.select());
        if (row) {
            if (row.BINDVARS == null) {
                // request without params
                sendRequestResult({ KODZ: row.KODZ, PARAMS: [] }, row.NAMEF);
                return;
            }
            if (row.BIND_SQL != null && row.BIND_SQL != "") {
                AJAX({
                    srcSettings: {
                        url: bars.config.urlContent("/api/RequestsProcessing/RequestsProcessing/DynamicDictRequest"),
                        success: function (data) {
                            fillDict(row, data);
                        },
                        complete: function (jqXHR, textStatus) { },
                        error: function (jqXHR, textStatus, errorThrown) { },
                        data: JSON.stringify({ KODZ: row.KODZ, PARAMS: [] })
                    }
                });
            }
            else {
                fillDict(row, null);
            }
            return;
        }
    }
    bars.ui.error({ title: 'Помилка', text: "Рядок не вибрано!" });
}

function parseDate(dateString, format) {
    if (!dateString) {
        return null;
    }
    if (typeof dateString !== 'string') {
        return kendo.toString(dateString, format);
    }
    return kendo.toString(new Date(dateString.match(/\d+/)[0] * 1), format);
}

function convert(VALUE) {
    if (VALUE == null) { return ""; }
    if (isNumeric(VALUE)) {
        return "<div style='text-align:right;'>" + kendo.toString(VALUE, 'n2')+"</div>";
    }
    if (VALUE.indexOf("Date") != -1) {
        //return parseDate(VALUE, 'dd.MM.yyyy HH:mm:ss');
        return parseDate(VALUE, 'dd.MM.yyyy');
    }
    return VALUE;
}

function formatConvert(cell) {

    if (cell == null || cell.value == null) { return cell; }
    if (cell.value && isNaN(cell.value) && cell.value.indexOf("Date") != -1) {
        //return parseDate(cell.value, 'dd.MM.yyyy HH:mm:ss');
        return parseDate(cell.value, 'dd.MM.yyyy');
    }
    if (!isNaN(cell.value))
        cell.format = '# ##0.00';


    return cell;
};
// replaceAll("Hello world!", "o", "_")
function replaceAll(s, oldValue, newValue) {
    var newS = "";
    var i;
    var indexes = [];
    for (i = 0; i < s.length; i++) {
        if (s[i] === oldValue) {
            indexes.push(i);
        }
    }
    for (i = 0; i < s.length; i++) {
        if (indexes.indexOf(i) != -1) {
            newS += newValue;
        }
        else {
            newS += s[i];
        }
    }
    return newS;
}

function isMoneyColumn(field) {
    var result = -1;
    if (typeof (field) === "string") {
        for (var i = 0; i < moneyWildcards.length; i++) {
            var pos = field.toLowerCase().indexOf(moneyWildcards[i].toLowerCase());
            if (-1 !== pos) {
                result = pos;
                break;
            }
        }
    }
    return -1 !== result;
};

function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}

function sendRequestResult(DynamicRequestData, fileName) {
    g_dynamicRequestData = DynamicRequestData;
    g_fileName = fileName;
    Waiting(true);
    AJAX({
        srcSettings: {
            url: bars.config.urlContent("/api/RequestsProcessing/RequestsProcessing/DynamicRequest"),
            success: function (data) {
                Waiting(false);
                if (data && data.length > 0) {

                    if (g_gridRequestResultInited) {
                        var _grid = $("#gridDynamicRequestResult").data("kendoGrid");
                        if (_grid !== undefined || _grid != null)
                            $('#gridDynamicRequestResult').kendoGrid('destroy').empty();        // clear prev data in grid
                    }
                    else {
                        g_gridRequestResultInited = true;
                    }

                    var row = data[0];
                    var columns = [];
                    var fields = {};
                    for (var k in row) {
                        if (k.indexOf(" ") > -1 || k.indexOf(".") > -1) {
                            bars.ui.alert({ text: "Назви полів не можуть містити пробілів і точок !" });
                            return;
                        }

                        var fieldID = k;
                        if (!isNaN(fieldID)) {
                            continue;
                        }
                        columns.push({
                            field: fieldID,
                            title: fieldID,
                            template: "#= convert(" + k + ") #"
                        });
                        //fields[fieldID] = { type: "string" };
                        fields[fieldID] = { type: (typeof (row[k]) === "number" && isMoneyColumn(k)) ? "number" : "string" };
                    }

                    var dstDataSource = {
                        data: data,
                        pageSize: 12,
                        schema: { model: { fields: fields } }
                    };

                    var blockGridData = new kendo.data.DataSource(dstDataSource);
                    var blockGridSettings = {
                        sortable: true,
                        resizable: true,
                        scrollable: true,
                        filterable: true,
                        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
                        selectable: "row",
                        dataSource: blockGridData,
                        columns: columns,
                        pageable: g_pageable,
                        reorderable: true,
                        toolbar: kendo.template($("#requestResultTitle-template").html()),
                        excel: {
                            allPages: false,
                            fileName: fileName + ".xlsx",
                            proxyURL: bars.config.urlContent('/RequestsProcessing/RequestsProcessing/ConvertBase64ToFile/')
                        },
                        excelExport: function (e) {
                            var sheet = e.workbook.sheets[0];
                            for (var rowIndex = 1; rowIndex < sheet.rows.length; rowIndex++) {
                                var row = sheet.rows[rowIndex];
                                for (var cellIndex = 0; cellIndex < row.cells.length; cellIndex++) {
                                    //row.cells[cellIndex].background = "#aabbcc";
                                    row.cells[cellIndex] = formatConvert(row.cells[cellIndex]);
                                }
                            }
                        }
                    };

                    if (blockGridSettings.columns.length == 0) {
                        g_gridRequestResultInited = false;
                        bars.ui.notify("Інформація", "Дані відсутні!", "info", { autoHideAfter: 5 * 1000 });
                    }
                    else {
                        $("#gridDynamicRequestResult").kendoGrid(blockGridSettings);
                    }
                    $("#gridDynamicRequestResult").show();
                }
                else {
                    $("#gridDynamicRequestResult").hide();
                    bars.ui.notify("Інформація", "Дані відсутні!", "info", { autoHideAfter: 5 * 1000 });
                }
            },
            complete: function (jqXHR, textStatus) { },
            error: function (jqXHR, textStatus, errorThrown) {
                Waiting(false);
            },
            data: JSON.stringify(DynamicRequestData)
        }
    });
}

function confirmDynamicRequest() {
    var grid = $('#gridMain').data("kendoGrid");
    if (grid) {
        var row = grid.dataItem(grid.select());
        if (row) {
            var DynamicRequestData = { KODZ: row.KODZ, PARAMS: [] };
            var dataSource = $("#gridDynamicRequestParams").data("kendoGrid").dataSource;
            var data = dataSource.data();
            for (var i = 0; i < data.length; i++) {
                var item = data[i];
                var val = item.VALUE != "" ? item.VALUE : "";
                var isDatePickerEnabled = item.ID.indexOf("sFdat1") != -1 || item.ID.indexOf("sFdat2") != -1;
                if (isDatePickerEnabled) {
                    if (val == ""){
                        bars.ui.error({ title: "Помилка", text: "Заповнення поля дати є обов'язковим. Введіть дату у форматі \"дд.ММ.рррр\"  або \"дд/ММ/рррр\" ." });
                        return;
                    }
                    else 
                        if (kendo.parseDate(val, "dd.MM.yyyy") || kendo.parseDate(val, "dd/MM/yyyy"))
                            val = replaceAll(val, '.', '/');
                        else {
                            bars.ui.error({ title: "Помилка", text: "Перевірте введену дату. Формат дати повинени бути: \"дд.ММ.рррр\" або \"дд/ММ/рррр\" "});
                            return;
                        }
                }
                // skip default value ex: '0'
                if (!(val.indexOf("'") == 0 && val.lastIndexOf("'") == val.length - 1)) {
                    val = "'" + val + "'";
                }
                DynamicRequestData["PARAMS"].push({ ID: ":" + item.ID, VALUE: val });
            }
            sendRequestResult(DynamicRequestData, row.NAMEF);
        }
    }

    $("#dialogDynamicRequest").data('kendoWindow').close();
}

function fillGridDict(dataRequestResult) {
    var dstDataSource = {
        data: dataRequestResult,
        pageSize: 12,
        schema: {
            model: {
                fields: {
                    ID: { type: "string", editable: false },
                    NAME: { type: "string", editable: false },
                    VALUE: { type: "string" }
                }
            }
        }
    };
    var blockGridData = new kendo.data.DataSource(dstDataSource);
    var blockGridSettings = {
        sortable: true,
        resizable: true,
        editable: true,
        scrollable: true,
        selectable: "row",
        dataSource: blockGridData,
        change: function (e) {
            grid = e.sender;
            var currentDataItem = grid.dataItem(grid.select());

            var text = "";
            var index = -1;
            var isDictVisible = false;

            // date picker
            var isDatePickerEnabled = currentDataItem != undefined ? currentDataItem.ID.indexOf("sFdat1") != -1 || currentDataItem.ID.indexOf("sFdat2") != -1 : false;
            var datePicker = $("#datePicker").data("kendoDatePicker").enable(isDatePickerEnabled);
            if (isDatePickerEnabled) {
                $("#datePickerTextMuted").hide();
                $("#datePickerTextSuccess").show();
            }
            else {
                $("#datePickerTextMuted").show();
                $("#datePickerTextSuccess").hide();
            }

            if (g_dictData != null) {
                if (currentDataItem == undefined) {
                    // error :(
                    return;
                }
                for (var i = 0; i < g_dictData.length; i++) {
                    var ID = g_dictData[i].ID;
                    if (ID == currentDataItem.ID) {
                        isDictVisible = true;
                        index = i;
                        break;
                    }
                }

                if (isDictVisible && index != -1) {
                    var title = g_dictData[index].tableSemantic["semantic"];
                    if (g_dictData[index].data.length == 0) {
                        text = "Довідний порожній, або відсутні права на таблицю: ";
                        text += "<strong>";
                        text += title;
                        text += ",";
                        text += g_dictData[index].tableSemantic["tabid"];
                        text += "</strong>";
                        isDictVisible = false;
                    }
                }
            }

            if (isDictVisible) {
                $("#dictTextMuted").hide();
                $("#dictTextSuccess").show();
            }
            else {
                $("#dictTextMuted").html(text != "" ? text : "Довідник недоступний");
                $("#dictTextMuted").show();
                $("#dictTextSuccess").hide();
            }
            $("#openDict").prop("disabled", !isDictVisible);
        },
        columns: [{ field: "NAME", title: "Параметр" }, { field: "VALUE", title: "Значення" }]
    };
    $("#gridDynamicRequestParams").kendoGrid(blockGridSettings);
    $("#gridDynamicRequestParams").delegate("tbody>tr", "dblclick", function () {
        var dictBtnDisabled = $("#openDict").prop('disabled');
        if (!dictBtnDisabled) {
            onClickOpenDict(null);
        }
    });
}

function changeDate(VALUE, format) {
    if (!VALUE) { return VALUE; }
    var milliseconds = Date.parse(VALUE);
    var date = new Date(milliseconds);
    return parseDate(date, format);
}

function fillDict(row, dictData) {
    g_dictData = dictData;

    var dataRequestResult = [];

    var defaultVarsArr = null;
    if (row.DEFAULT_VARS != null) {
        defaultVarsArr = parseRow(row.DEFAULT_VARS, true);
    }
    var bindVarsArr = parseRow(row.BINDVARS, true);
    for (var i = 0; i < bindVarsArr.length; i++) {
        if (bindVarsArr[i].length < 2) {
            continue;
        }
        var ID = bindVarsArr[i][0];
        var NAME = "";
        if (ID.indexOf("sFdat1") != -1) {
            NAME = "Дата з";
        }
        else if (ID.indexOf("sFdat2") != -1) {
            NAME = "Дата по";
        }
        else {
            NAME = replaceAll(bindVarsArr[i][1], "'", "");
        }
        if (NAME != null && NAME != "") {
            var VALUE = "";
            if (defaultVarsArr != null) {
                for (var j = 0; j < defaultVarsArr.length; j++) {
                    if (defaultVarsArr[j][0] == ID) {
                        VALUE = defaultVarsArr[j][1];
                        break;
                    }
                }
            }
            dataRequestResult.push({ ID: ID, NAME: NAME, VALUE: VALUE });
        }
    }
    fillGridDict(dataRequestResult);
    $("#dictTextMuted").html("Довідник недоступний");
    $("#dictTextMuted").show();
    $("#dictTextSuccess").hide();

    $("#datePickerTextMuted").show();
    $("#datePickerTextSuccess").hide();

    $("#openDict").prop("disabled", true);
    var datePicker = $("#datePicker").data("kendoDatePicker").enable(false);
    $("#dialogDynamicRequest").data('kendoWindow').center().open();
}

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid) { grid.dataSource.fetch(); }
}

function initMainGrid() {
    Waiting(true);

    fillKendoGrid("#gridMain", {
        type: "webapi",
        //sort: [ { field: "ID", dir: "desc" } ],
        transport: { read: { url: bars.config.urlContent("/api/RequestsProcessing/RequestsProcessing/SearchMain") } },
        pageSize: PAGE_INITIAL_COUNT,
        schema: {
            model: {
                fields: {
                    KODZ: { type: "number" },
                    KODR: { type: "number" },
                    NAME: { type: "string" },
                    NAMEF: { type: "string" },
                    BINDVARS: { type: "string" },
                    CREATE_STMT: { type: "string" },
                    RPT_TEMPLATE: { type: "string" },
                    DEFAULT_VARS: { type: "string" },
                    BIND_SQL: { type: "string" },
                    LAST_UPDATED: { type: "date" }
                }
            }
        }
    }, {
            pageable: g_pageable,
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
            reorderable: true,
            columns: [
                {
                    field: "KODZ",
                    title: "Код",
                    width: "15%"
                },
                {
                    field: "NAME",
                    title: "Назва запиту",
                    width: "40%"
                },
                {
                    field: "NAMEF",
                    title: "Файл результату",
                    width: "25%"
                },
                {
                    field: "LAST_UPDATED",
                    title: "Дата останньої<br>модифікації",
                    width: "20%",
                    template: "<div style='text-align:center;'>#=(LAST_UPDATED == null) ? ' ' : kendo.toString(LAST_UPDATED,'dd.MM.yyyy HH:mm:ss')#</div>"
                }
            ]
        },
        "#mainTitle-template",
        null);
}

$(document).ready(function () {
    $("#title").html("Каталогізовані запити");
    $('#confirmDynamicRequest').click(confirmDynamicRequest);
    $('#confirmExport2Text').click(confirmExport2Text);

    InitGridWindow({ windowID: "#dialogExport2Text", srcSettings: { title: "Вигрузка в текстовий файл", width: "440px" } });
    InitGridWindow({ windowID: "#dialogDict", srcSettings: { title: "Довідник." } });
    InitGridWindow({ windowID: "#dialogDynamicRequest", srcSettings: { title: "Параметри запиту." } });
    initMainGrid();

    $("#datePicker").kendoDatePicker({ format: "dd.MM.yyyy" }).change(function (e) {
        var grid = $('#gridDynamicRequestParams').data("kendoGrid");
        var row = grid.dataItem(grid.select());
        row.set("VALUE", e.currentTarget.value);
        row.dirty = true;
    });
});