var KEY_CODE_ENTER = 13;

var g_primitives = ["number", "boolean", "string", "function", "undefined"];

function Waiting(flag) {
    kendo.ui.progress($(".search-main"), flag);
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
function fillKendoGrid(gridId, srcDataSource, srcSettings, toolbarTemplate, fetchFunc) {
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
        toolbar: toolbarTemplate != null ? kendo.template($(toolbarTemplate).html()) : null,
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