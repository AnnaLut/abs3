var KEY_CODE_ENTER = 13;

var g_primitives = ["number", "boolean", "string", "function", "undefined"];

function updateGrid(gridId) {
    var grid = $(gridId).data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function setGridNavigationChbx(gridId) {

    var isShiftUp = true;

    function setArrowSelect(grid, rowIndex, isShift) {
        uid = grid.dataSource.at(rowIndex).uid;
        grid.select("tr[data-uid='" + uid + "']");

        if(isShift){
            isChecked = grid.tbody.find("tr[data-uid='" + uid + "']").find(".chkFormols").is(':checked');
            setCheckBox(grid, uid, !isChecked);
        }
    }

    function setCheckBox(grid, uid, isChecked) {
        grid.tbody.find("tr[data-uid='" + uid + "']").find(".chkFormols").prop("checked", isChecked);
    }

    $(gridId).find("table").on("keyup", function(e){
        e.preventDefault(); // Stops IE from triggering the button to be clicked
        if(e.keyCode == 16){
            isShiftUp = true;
        }
    });

    $(gridId).find("table").on("keydown", function(e){
        e.preventDefault(); // Stops IE from triggering the button to be clicked

        var grid = $(gridId).data("kendoGrid");
        var dataRows = grid.items();
        var rowIndex = dataRows.index(grid.select());
        if(rowIndex == null || rowIndex < 0){ return; }

        var isShift = window.event ? !!window.event.shiftKey : !!e.shiftKey;

        var uid;
        if(e.keyCode == 40){
            var nextRowIndex = rowIndex + 1;    // arrow down
            if(nextRowIndex < dataRows.length){
                setArrowSelect(grid, nextRowIndex, isShift);
            }
        }
        else if(e.keyCode == 38){
            var prevRowIndex = rowIndex - 1;    // arrow up
            if(prevRowIndex >= 0){
                setArrowSelect(grid, prevRowIndex, isShift);
            }
        }
        else if(e.keyCode == 16){
            if(isShiftUp){
                uid = grid.dataSource.at(rowIndex).uid;
                var isChecked = grid.tbody.find("tr[data-uid='" + uid + "']").find(".chkFormols").is(':checked');
                setCheckBox(grid, uid, !isChecked);
            }
            isShiftUp = false;
        }
    });
}

function setGridNavigation(gridId) {
    $(gridId).find("table").on("keydown", function(e){
        e.preventDefault(); // Stops IE from triggering the button to be clicked
        
        var grid = $(gridId).data("kendoGrid");
        var dataRows = grid.items();
        var rowIndex = dataRows.index(grid.select());
        if(rowIndex == null || rowIndex < 0){ return; }

        var uid;
        if(e.keyCode == 40){
            var nextRowIndex = rowIndex + 1;    // arrow down
            if(nextRowIndex < dataRows.length){
                uid = grid.dataSource.at(nextRowIndex).uid;
                grid.select("tr[data-uid='" + uid + "']");
            }
        }
        else if(e.keyCode == 38){
            var prevRowIndex = rowIndex - 1;    // arrow up
            if(prevRowIndex >= 0){
                uid = grid.dataSource.at(prevRowIndex).uid;
                grid.select("tr[data-uid='" + uid + "']");
            }
        }
    });
}

// replaceAll("Hello world!", "o", "_")
function replaceAll(s, oldValue, newValue) {
    var newS = "";
    var i;
    var indexes = [];
    for(i = 0; i < s.length; i++){
        if(s[i] === oldValue){
            indexes.push(i);
        }
    }
    for(i = 0; i < s.length; i++){
        if(indexes.indexOf(i) != -1){
            newS += newValue;
        }
        else{
            newS += s[i];
        }
    }
    return newS;
}

function OpenBarsDialog(url, settings) {
    var options = {
        content: url,
        iframe: true,
        modal: true,
        height: document.documentElement.offsetHeight * 0.8,
        width: document.documentElement.offsetWidth * 0.8,
        padding: 0,
        actions: ["Refresh", "Maximize", "Minimize", "Close"]
    };
    if(settings != null){ change(settings, options); }
    bars.ui.dialog(options);
}

function Waiting(flag) {
    WaitingForID(flag, ".search-main");
}

function WaitingForID(flag, ID) {
    kendo.ui.progress($(ID), flag);
}

function AJAX(settings) {
    var dstSettings = {
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        url: ""
    };
    if(settings.srcSettings != null){ change(settings.srcSettings, dstSettings); }
    $.ajax(dstSettings);
}

function InitGridWindow(settings) {
    var dstSettings = {
        actions: ["Close"],
        draggable: true,
        modal: true,
        resizable: false,
        title: "",
        width: "720px",
        visible: false,
        open: function () { }
    };
    if(settings.srcSettings != null){ change(settings.srcSettings, dstSettings); }

    $(settings.windowID).kendoWindow(dstSettings);
}

function confirmGridWindow(settings) {
    var query = [];
    var dataSource = $(settings.windowGridID).data("kendoGrid").dataSource;
    var data = dataSource.data();

    for (var i = 0; i < data.length; i++) {
        var item = data[i];
        var obj = {};
        for (var j = 0; j < settings.grabData.length; j++) {
            var key = settings.grabData[j].key;
            if(key === "comment" && isEmpty(item[key])){
                bars.ui.error({ title: 'Помилка!', text: 'Коментар не заповнений!' });
                return;
            }
            obj[key] = item[key];
        }
        query.push(obj);
    }
    var dstSettings = {
        type: "POST",
        dataType: "json",
        data: JSON.stringify(query),
        contentType: 'application/json; charset=utf-8',
        url: ""
    };
    if(settings.srcSettings != null){ change(settings.srcSettings, dstSettings); }
    $.ajax(dstSettings).done(function () {
        // $(settings.windowID).data('kendoWindow').close();
        // $(settings.srcGridID).data('kendoGrid').dataSource.read();
        // $(settings.srcGridID).data('kendoGrid').refresh();
        if("successFunc" in settings){
            settings["successFunc"]();
        }
    }).always(function () {
        $(settings.windowID).data('kendoWindow').close();
        $(settings.srcGridID).data('kendoGrid').dataSource.read();
        $(settings.srcGridID).data('kendoGrid').refresh();
    });
}

//srcGridID - string
//windowGridID -  string
//windowID - string
//srcDataSource - Object
//srcSettings - Object
//grabData - Array [{key: 'name', defaultValue: null}]
function openGridWindow(settings) {
    var pensioners = [];
    var grid = $(settings.srcGridID).data("kendoGrid");
    var dataSource = grid.dataSource;

    grid.tbody.find("input:checked").closest("tr").each(function (index) {
        var uid = $(this).attr('data-uid');
        var item = dataSource.getByUid(uid);
        var pensioner = {};
        for (var i = 0; i < settings.grabData.length; i++) {
            var key = settings.grabData[i].key;
            var defaultValue = settings.grabData[i].defaultValue;
            pensioner[key] = (defaultValue == null) ? item[key] : defaultValue;
        }        
        pensioners.push(pensioner);
    });

    if (pensioners.length == 0) {
        bars.ui.error({ title: 'Помилка!', text: 'Документи не відмічені!' });
        return;
    }

    var dstDataSource = {
        pageSize: 12,
        schema: { model: { fields: {} } },
        data: pensioners
    };
    if(settings.srcDataSource != null){ change(settings.srcDataSource, dstDataSource); }

    var blockGridData = new kendo.data.DataSource(dstDataSource);

    var blockGridSettings = { resizable: true, editable: true, dataSource: blockGridData, columns: [] };
    if(settings.srcSettings != null){ change(settings.srcSettings, blockGridSettings); }

    $(settings.windowGridID).kendoGrid(blockGridSettings);
    $(settings.windowID).data('kendoWindow').center().open();
}

function getNameById(valueForCheck, dropDownData, keyForCheck, keyForResult) {
    if (dropDownData != null) {
        for (var i = 0; i < dropDownData.length; i++) {
            if(isNaN(dropDownData[i][keyForCheck])){
                if (dropDownData[i][keyForCheck] == valueForCheck) {
                    return dropDownData[i][keyForResult];
                }
            }
            else{
                if (parseInt(dropDownData[i][keyForCheck]) == parseInt(valueForCheck)) {
                    return dropDownData[i][keyForResult];
                }
            }
        }
    }
    //console.warn(String.format("valueForCheck={0}, keyForCheck={1}, keyForResult={2}", valueForCheck, keyForCheck, keyForResult) + " "+dropDownData);
    return "";      // bad case :(
}

function fillDropDownList(dropDownId, srcDataSource, srcSettings) {
    var dstDataSource = {
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: ""
            }
        },
        schema: {
            data: "Data",
            model: {
                fields: { }
            }
        }
    };
    if(srcDataSource != null){ change(srcDataSource, dstDataSource); }

    var statusDataSource = new kendo.data.DataSource(dstDataSource);

    var dstSettings = { dataSource: statusDataSource };
    if(srcSettings != null){ change(srcSettings, dstSettings); }

    $(dropDownId).kendoDropDownList(dstSettings);
}


// fill any grid
function fillKendoGrid(gridId, srcDataSource, srcSettings, toolbarTemplate, fetchFunc, toolbar) {
    var dstDataSource = {
        type: "aspnetmvc-ajax",
        pageSize: 12,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: ""
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: { fields: { } }
        }
    };
    if(srcDataSource != null){ change(srcDataSource, dstDataSource); }

    var dataSource = new kendo.data.DataSource(dstDataSource);
    if(fetchFunc != null){
        dataSource.fetch( function (data) {
            fetchFunc(data);
        })
    }
    var dstSettings = {
        autoBind: true,
        resizable: true,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true
        },
        toolbar: toolbarTemplate != null ? kendo.template($(toolbarTemplate).html()) : (toolbar != null ? toolbar : null),
        columns: [ ],
        dataBinding: function (res) { },
        dataBound: function () { Waiting(false); },
        dataSource: dataSource,
        filterable: true
    };
    if(srcSettings != null){ change(srcSettings, dstSettings); }

    $(gridId).kendoGrid(dstSettings);
}

function CreateKendoDataSource(srcDataSource) {
    var dstDataSource = {
        type: "aspnetmvc-ajax",
            transport: {
        read: {
            type: "GET",
                dataType: "json",
                url: ""
        }
    },
        schema: {
            data: "Data",
            model: { fields: { } }
        }
    };
    if(srcDataSource != null){ change(srcDataSource, dstDataSource); }
    return new kendo.data.DataSource(dstDataSource);
}

function change(src, dst) {
    for(var key in src){
        if(src[key] == null || src[key] instanceof Array || g_primitives.indexOf(typeof src[key]) != -1){
            // console.log("--------------------------");
            // console.log(key);
            // console.log(src[key]);
            // console.log(typeof src[key]);
            dst[key] = src[key];
        }
        else{
            if(!dst.hasOwnProperty(key)){ dst[key] = {}; }
            arguments.callee(src[key], dst[key]);
        }
    }
}

/// ************ ///
/// String utils ///
/// ************ ///
function Replace(s, oldSymb, newSymb) {
    if(s.indexOf(oldSymb) == -1){ return s; }
    var sNew = "";
    for(var i = 0; i < s.length; i++){
        if(oldSymb == s[i]){
            sNew += newSymb;
        }
        else{
            sNew += s[i];
        }
    }
    return sNew;
}

function PadRight(s, len, symb) {
    if(s.length >= len){ return s; }
    var sNew = "";
    for(var i = 0; i < len; i++){
        if(i < s.length){
            sNew += s[i];
        }
        else{
            sNew += symb;
        }
    }
    return sNew;
}