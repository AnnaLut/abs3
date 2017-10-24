var PAGE_INITIAL_COUNT = 10;

var portDataSource = [
    { name: "COM 1", id: 1 },
    { name: "COM 2", id: 2 },
    { name: "COM 3", id: 3 }
];

var POSTypeDataSource = [
    { name: "Ingenico", id: "INGENICO" }
     ,{ name: "Hypercom", id: "SSI" }
    //,{ name: "InPas (VeriFone Vx510)", id: "INPAS" }
];

/// ******************************************************************************

function onPrintBtn() {
    PrintBatchTotals();
}

function onFireBtn() {
    var grid = $('#gridMain').data("kendoGrid");
    if(grid){
        var data = grid.dataSource.data();
        var textAmount = "<br>";
        var dataForSend = [];
        for (var i = 0; i < data.length; i++) {
            var item = data[i];
            var strAmount = kendo.format("{0:n}", (item.Amount/100).toFixed(2));
            textAmount += item.TxnName;
            textAmount += ", Валюта: <strong>";
            textAmount += item.Currency;
            textAmount += "</strong>, Сума: <strong>";
            textAmount += strAmount;
            textAmount += "</strong><br>";

            dataForSend.push({
                sum: item.Amount,
                operation_type: item.TxnType,
                kv: item.CurrencyCode,
                TerminaID: item.TerminalID
            });

        }
        if(dataForSend.length > 0){
            bars.ui.confirm({text: "Обробити дані та провести звірку на терміналі? " + textAmount}, function () {
                Pay(dataForSend, true);
            });
            return;
        }
    }
    bars.ui.error({ title: 'Термінал', text: "Дані відсутні!" });
}

function Pay(dataForSend, isClearData) {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/pos/pos/postotalapply"),
        success: function (data) {
            Waiting(false);

            var text = "Операція успішно виконана!";
            if(data.length > 0){
                var refs = " (";
                for(var i = 0; i < data.length; i++){
                    refs += data[i];
                    if(i < data.length - 1){
                        refs += ",";
                    }
                }
                refs += ")";
                text += refs;
            }
            // Settlement - close terminal day !!!
            Settlement(text);

            if(isClearData){
                $("#FireBtn").prop("disabled", true);
                var grid = $('#gridMain').data("kendoGrid");
                grid.dataSource.data([]);
                //bars.ui.notify('Термінал', text, 'success', { autoHideAfter: 5*1000});
            }
        },
        error: function(jqXHR, textStatus, errorThrown){ Waiting(false); },
        data: JSON.stringify(dataForSend)
    } });
}

function initMainGrid() {
    $("#gridMain").kendoGrid({
        resizable: true,
        editable: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        reorderable: true,
        pageable: {
            messages: {
                display: "Елементів: {2}",
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            refresh: true,
            pageSizes: [PAGE_INITIAL_COUNT, 50, 200, 1000, "All"],
            buttonCount: 5
        },
        columns: [
            //{ field: "Id", title: "Номер<br>транзцкції" },
            { field: "TerminalID", title: "ID<br>терміналу" },
            { field: "Currency", title: "Валюта" },
            { field: "CurrencyCode", title: "Код<br>валюти" },
            {
                field: "Amount",
                title: "Сума",
                template: '#=kendo.toString((Amount/100).toFixed(2),"n")#',
                format: '{0:n}',
                attributes: { "class": "money" }
            },
            { field: "TxnName", title: "Тип<br>транзакції" },
            { field: "TxnType", title: "ID<br>транзакції" }
            //{ field: "TrnStatus", title: "Статус<br>транзакції" }
        ],
        dataSource: {
            data: [],
            pageSize: PAGE_INITIAL_COUNT,
            serverPaging: false,
            serverFiltering: false,
            serverSorting: false
        }
    });
}

function Select() {
    Waiting(true);

    var deviceType = $("#deviceTypes").val();
    var COMPort = $("#COMPort").val();

    Set_POSType(deviceType);
    Set_Port(COMPort);

    $("#FireBtn").prop("disabled", true);
    var grid = $("#gridMain").data("kendoGrid");
    grid.dataSource.data([]);       // clear grid data
    IdentClient();  // продолжаем идентификацию
}

var BUTTONTS_DEVICES = {
    INGENICO: ["#ReadDataBtn", "#FireBtn", "#PrintBtn"],
    SSI: ["#FireBtnSSI"],
    INPAS: ["#ReadDataBtn", "#FireBtn"]
};

// hide/show UI component after device selection
function selectDeviceUpdate(value) {
    var curBtnsArr = BUTTONTS_DEVICES[value];
    if(curBtnsArr != undefined){
        var i;
        for(i = 0; i < curBtnsArr.length; i++){ $(curBtnsArr[i]).show(); }
        for(k in BUTTONTS_DEVICES){
            if(k != value){
                var btnsArr = BUTTONTS_DEVICES[k];
                for(i = 0; i < btnsArr.length; i++){
                    var btn = btnsArr[i];
                    if(curBtnsArr.indexOf(btn) == -1){ $(btn).hide(); }
                }
            }
        }
    }
}

function ddListSelect(id, v, dataSource) {
    if(v){
        var dropdownlist = $(id).data("kendoDropDownList");
        for(i = 0; i < dataSource.length; i++){
            if(dataSource[i].id === v){
                dropdownlist.select(i);
                dropdownlist.trigger("change");
                break;
            }
        }
    }
}

$(document).ready(function () {
    initMainGrid();

	$("#title").html("Імпорт документів із POS-термінала в АБС");

    var Port = Get_Port();
    var POSType = Get_POSType();

    var i;
    var hideElems = ["#PrintBtn"];
    for(i = 0; i < hideElems.length; i++){
        $(hideElems[i]).hide();
    }

    $("#deviceTypes").kendoDropDownList({
        dataTextField: "name",
        dataValueField: "id",
        dataSource: POSTypeDataSource,
        change: function(e) { selectDeviceUpdate(this.value()); }
    });
    ddListSelect("#deviceTypes", POSType, POSTypeDataSource);

    $("#COMPort").kendoDropDownList({
        dataTextField: "name",
        dataValueField: "id",
        dataSource: portDataSource
    });
    ddListSelect("#COMPort", Port, portDataSource);

    selectDeviceUpdate($("#deviceTypes").data("kendoDropDownList").value());   // hide/show UI component after device selection

    $('#FireBtnSSI').click(function () {
        bars.ui.confirm({text: "Обробити дані та провести звірку на терміналі?"}, function () { Select(); });
    });
    $('#ReadDataBtn').click(Select);
    $('#FireBtn').click(onFireBtn);
    $('#PrintBtn').click(onPrintBtn);

    $("#FireBtn").prop("disabled", true);

});