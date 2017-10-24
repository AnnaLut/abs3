/**
 * Created by serhii.karchavets on 27.09.2016.
 */

var g_initedGridDocForKvit = false;
var g_mainGridInited = false;
var g_grpid = null;
var g_cDocRef = null;
var g_IsPrintModel = true;

function convertAmount(AMOUNT) {
    if(AMOUNT != null && AMOUNT != ""){
        AMOUNT = AMOUNT / 100.0;
    }
    return kendo.toString(AMOUNT, "n");
}

function clearTmpMsg(swref, mt) {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/swieditmsgcleartmp"),
        success: function (data) {        },
        complete: function(jqXHR, textStatus){ Waiting(false); },
        data: JSON.stringify( { MT: mt, SWREF: swref })
    } });
}

function GenFullMessage(SWREF, MT) {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/genfullmessage"),
        success: function (data) {
            OpenBarsDialog("/barsroot/swift/editmsg?swref=" + SWREF + "&mt=" + MT, {
                width: "520px",
                height: "885px",
                close: function () {
                    clearTmpMsg(SWREF, MT);
                }
            });
        },
        error: function(jqXHR, textStatus, errorThrown){
            //bars.ui.alert({ text: "Помилка розподілення повідомлень." });
        },
        complete: function(jqXHR, textStatus){
            Waiting(false);
        },
        data: JSON.stringify({cSwRef: SWREF, mt: MT})
    } });
}

// message = {cDocRef:cDocRef, cSwRef:cSwRef, nChkGrpId:nChkGrpId, nBackReasonId:nBackReasonId}
function CanselApprove(messagesList, nChkGrpId) {
    var data = [];
    for(var i = 0; i < messagesList.length; i++){
        var row = messagesList[i];
        data.push({cDocRef: row.REF, cSwRef: row.SWREF, nChkGrpId: nChkGrpId, nBackReasonId: -1});
    }
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/canselapprove"),
        success: function (data) {
            bars.ui.notify("Розподілення", "Операцію успішно виконано", 'success');
            updateMainGrid();
            $('.chkFormolsAll').prop('checked', false);
        },
        error: function(jqXHR, textStatus, errorThrown){
            //bars.ui.alert({ text: "Помилка розподілення повідомлень." });
        },
        data: JSON.stringify(data)
    } });
}

// message = {cDocRef:cDocRef, cSwRef:cSwRef, nChkGrpId:nChkGrpId}
function Approve(messagesList) {
    var data = [];
    for(var i = 0; i < messagesList.length; i++){
        var row = messagesList[i];
        data.push({cDocRef: row.REF, cSwRef: row.SWREF, nChkGrpId: g_grpid});
    }

    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/approve"),
        success: function (data) {
            var Errors = data["Errors"];
            if(Errors.length > 0){
                for(var i = 0; i < Errors.length; i++){
                    bars.ui.error({ title: 'Помилка. Не завізовано: '+Errors[i].cSwRef, text: data['ErrorsStr'][i] });
                }
            }
            else{
                bars.ui.notify("Розподілення", "Операцію успішно виконано", 'success');
            }
            updateMainGrid();
            $('.chkFormolsAll').prop('checked', false);
        },
        error: function(jqXHR, textStatus, errorThrown){
            updateMainGrid();
            $('.chkFormolsAll').prop('checked', false);
            //bars.ui.alert({ text: "Помилка розподілення повідомлень." });
        },
        data: JSON.stringify(data)
    } });
}

function updateGridDocForKvit() {
    var grid = $("#gridDocForKvit").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function initGridDocForKvit() {
    Waiting(true);
    fillKendoGrid("#gridDocForKvit", {
            type: "webapi",
            // sort: [ { field: "SWREF", dir: "desc" } ],
            transport: { read: {
                url: bars.config.urlContent("/api/vvisalist"),
                data: function () { return {g_cDocRef: g_cDocRef}; }
            } },
            schema: {
                model: {
                    fields: {
                        OPERATION: { type: "string" },
                        USERNAME: { type: "string" },
                        MARKID: { type: "number" }
                    }
                }
            }
        }, {
            columns: [
                {
                    field: "OPERATION",
                    title: "Група контроля",
                    width: "10%"
                },
                {
                    field: "USERNAME",
                    title: "Виконавець",
                    width: "10%"
                }
            ]
        },
        null);
}

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function checkAll(ele) {
    var grid = $('#gridMain').data('kendoGrid');
    var state = $(ele).is(':checked');
    $('.chkFormols').prop('checked', state == true);
}

function initMainGrid() {
    fillKendoGrid("#gridMain", {
            type: "webapi",
            // sort: [ { field: "SWREF", dir: "desc" } ],
            transport: {
                read: {
                    url: bars.config.urlContent("/api/searchApprovals"),
                    data: function () { return { g_grpid: g_grpid.toString(16) }; }
                }
            },
            schema: {
                model: {
                    fields: {
                        SWREF: { type: "number" },
                        MT: { type: "number" },
                        TRN: { type: "string" },
                        SENDER_BIC: { type: "string" },
                        SENDER_NAME: { type: "string" },
                        RECEIVER_BIC: { type: "string" },
                        RECEIVER_NAME: { type: "string" },
                        CURRENCY: { type: "string" },
                        AMOUNT: { type: "number" },
                        VDATE: { type: "date" },
                        REF: { type: "number" },
                        NEXTVISAGRP: { type: "string" },
                        EDITSTATUS: { type: "number" }
                    }
                }
            }
        }, {
            dataBound: function(e) {
                Waiting(false);

                if(g_initedGridDocForKvit){
                    grid = e.sender;
                    var currentDataItem = grid.dataItem(this.select());
                    g_cDocRef = currentDataItem != null ? currentDataItem.REF : null;
                    updateGridDocForKvit();
                }
            },
            //editable: true,
            reorderable: true,
            change: function (e) {
                grid = e.sender;
                var currentDataItem = grid.dataItem(this.select());
                g_cDocRef = currentDataItem.REF;
                if(!g_initedGridDocForKvit){
                    g_initedGridDocForKvit = true;
                    initGridDocForKvit();
                }
                else{
                    Waiting(true);
                    updateGridDocForKvit();
                }
            },
            columns: [
                {
                    field: "block",
                    title: "",
                    filterable: false,
                    sortable: false,
                    template: "<input type='checkbox' class='chkFormols' style='margin-left: 26%;' />",
                    headerTemplate: "<input type='checkbox' class='chkFormolsAll' id='check-all' onclick='checkAll(this)'/><br><label for='check-all'>Всі</label>",
                    width: "3%"
                },
                {
                    field: "SWREF",
                    title: "SWIFT референс",
                    width: "8%"
                },
                {
                    field: "MT",
                    title: "Тип повідомлення",
                    width: "8%"
                },
                // {
                //     field: "TRN",
                //     title: "TRN",
                //     width: "10%"
                // },
                // {
                //     field: "SENDER_BIC",
                //     title: "SENDER_BIC",
                //     width: "10%"
                // },
                {
                    field: "SENDER_NAME",
                    title: "Відправник",
                    width: "25%"
                },
                // {
                //     field: "RECEIVER_BIC",
                //     title: "RECEIVER_BIC",
                //     width: "10%"
                // },
                {
                    field: "RECEIVER_NAME",
                    title: "Отримувач",
                    width: "20%"
                },
                {
                    field: "CURRENCY",
                    title: "Валюта",
                    width: "6%"
                },
                {
                    field: "AMOUNT",
                    title: "Сума",
                    width: "8%",
                    template:'#= convertAmount(AMOUNT) #',
                    format: '{0:n}',
                    attributes: { "class": "money" }
                },
                // {
                //     field: "VDATE",
                //     title: "VDATE",
                //     width: "10%",
                //     template: "<div style='text-align:center;'>#=(VDATE == null) ? ' ' : kendo.toString(VDATE,'dd.MM.yyyy')#</div>"
                // },
                {
                    field: "REF",
                    title: "Референс",
                    width: "10%"
                }
                // {
                //     field: "NEXTVISAGRP",
                //     title: "NEXTVISAGRP",
                //     width: "10%"
                // },
                // {
                //     field: "EDITSTATUS",
                //     title: "EDITSTATUS",
                //     width: "10%"
                // }
            ]
        },
        "#mainTitle-template"
    );
    setGridNavigationChbx("#gridMain");
}

function confirmCanselApproveReason() {
    $("#dialogCanselApproveReason").data('kendoWindow').close();

    var grid = $('#gridCanselApproveReason').data("kendoGrid");
    if (grid) {
        var row = grid.dataItem(grid.select());
        if (row) {
            var gridMain = $('#gridMain').data("kendoGrid");
            var selectedRows = [];
            var dataSource = gridMain.dataSource;
            gridMain.tbody.find("input:checked").closest("tr").each(function (index) {
                var uid = $(this).attr('data-uid');
                var item = dataSource.getByUid(uid);
                selectedRows.push(item)
            });
            CanselApprove(selectedRows, row.ID);
        }
        else {
            bars.ui.error({ title: 'Помилка', text: 'Не вибрано причину повернення!' });
        }
    }
}

function selectCanselApproveReason() {
    var dstDataSource = {
        pageSize: 12,
        schema: {
            model: {
                fields: {
                    ID: { type: "number" },
                    REASON: { type: "string" }
                }
            }
        },
        //type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/canselreasons"),
                complete: function (data, status) {
                    if (status === "success") {
                        // your code that will be executed once the request is done
                        if (data.responseJSON.length > 0) {
                            $("#dialogCanselApproveReason").data('kendoWindow').center().open();
                        }
                        else {
                            bars.ui.error({ title: 'Помилка', text: 'Причини повернення відсутні!' });
                        }
                    }
                }
            }
        }
    };
    var blockGridData = new kendo.data.DataSource(dstDataSource);
    var blockGridSettings = {
        resizable: true,
        editable: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        dataSource: blockGridData,
        columns: [
            {
                field: "ID",
                title: "ID"
            },
            {
                field: "REASON",
                title: "Назва"
            }
        ]
    };
    $("#gridCanselApproveReason").kendoGrid(blockGridSettings);
}

function confirmSelectOpCode() {
    var gridOpCode = $('#gridSelectOpCode').data("kendoGrid");
    if (gridOpCode) {
        var rowOpCode = gridOpCode.dataItem(gridOpCode.select());
        if (rowOpCode) {
            g_grpid = rowOpCode.GRPID;
            // update main grid
            if(g_mainGridInited){
                updateMainGrid();
            }
            else{
                g_mainGridInited = true;
                Waiting(true);
                initMainGrid();
            }
        }
    }
    $("#dialogSelectOpCode").data('kendoWindow').close();
}

function selectOpCode() {
    var dstDataSource = {
        pageSize: 12,
        schema: {
            model: {
                fields: {
                    GRPID: { type: "number" },
                    GRPNAME: { type: "string" }
                }
            }
        },
        //type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/listApprovals"),
                complete: function (data, status) {
                    if (status === "success") {
                        // your code that will be executed once the request is done
                        if (data.responseJSON.length > 0) {
                            $("#dialogSelectOpCode").data('kendoWindow').center().open();
                        }
                        else {
                            bars.ui.error({ title: 'Помилка', text: 'Візи відсутні!' });
                        }
                    }
                }
            }
        }
    };
    var blockGridData = new kendo.data.DataSource(dstDataSource);
    var blockGridSettings = {
        resizable: true,
        editable: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        dataSource: blockGridData,
        columns: [
            {
                field: "GRPID",
                title: "Номер візи"
            },
            {
                field: "GRPNAME",
                title: "Назва"
            }
        ]
    };
    $("#gridSelectOpCode").kendoGrid(blockGridSettings);
}


function onClickBtn(btn) {
    if(btn.id == "chbxPrintModel"){
        g_IsPrintModel = !g_IsPrintModel;
        return;
    }

    var grid = $('#gridMain').data("kendoGrid");
    var row = null;
    var selectedRows = [];

    if(btn.id === "btnPrint" || btn.id === "pbApplyToAll" || btn.id === "pbStorno" || btn.id === "pbPrevVisa" || btn.id === "btnView"){
        var dataSource = grid.dataSource;
        grid.tbody.find("input:checked").closest("tr").each(function (index) {
            var uid = $(this).attr('data-uid');
            var item = dataSource.getByUid(uid);
            selectedRows.push(item)
        });
        if(selectedRows.length == 0){
            bars.ui.error({ title: 'Помилка', text: 'Документи не відмічені!' });
            return;
        }
    }
    else if(btn.id === "btnViewDoc" || btn.id === "btnEdit"){
        row = grid.dataItem(grid.select());
        if(row == null){
            bars.ui.error({ title: 'Помилка', text: 'Рядок не вибрано!' });
            return;
        }
    }

    var i = 0;
    switch (btn.id){
        case "btnPrint":
            var refsForPrint = [];
            for(i = 0; i < selectedRows.length; i++){
                refsForPrint.push(selectedRows[i].REF);
            }
            Waiting(true);
            AJAX({ srcSettings: {
                url: bars.config.urlContent("/api/approvalgetfileforprint"),
                success: function (data) {
                    barsie$print(data);
                },
                complete: function(jqXHR, textStatus){ Waiting(false); },
                data: JSON.stringify( { Refs: refsForPrint, IsPrintModel: g_IsPrintModel })
            } });

            break;

        case "pbApplyToAll":
            bars.ui.confirm({text: "Завізувати?"}, function () {
                Approve(selectedRows);
            });

            break;

        case "pbFindMatch":
            selectOpCode();
            break;

        case "pbStorno":
            selectCanselApproveReason();
            break;

        case "pbPrevVisa":
            bars.ui.confirm({text: "Повернути (на попередню візу)?"}, function () {
                CanselApprove(selectedRows, g_grpid);
            });
            break;

        case "btnView":
            Waiting(true);
            var url = "/barsroot/documentview/view_swift.aspx?swref=";
            for(i = 0; i < selectedRows.length; i++){
                url += selectedRows[i].SWREF;
                if(i < selectedRows.length - 1){
                    url += ";";
                }
            }
            window.showModalDialog(encodeURI(url), null, "dialogWidth:800px; dialogHeight:600px; center:yes; status:no");
            Waiting(false);
            break;

        case "btnViewDoc":
            Waiting(true);
            var urlDoc = "/barsroot/documentview/default.aspx?ref=" + row.REF;
            window.showModalDialog(encodeURI(urlDoc), null, "dialogWidth:800px; dialogHeight:600px; center:yes; status:no");
            Waiting(false);
            break;

        case "btnEdit":
            if(row.EDITSTATUS !== 1){
                bars.ui.error({ title: 'Помилка', text: 'Не дозволено!' });
                return;
            }
            GenFullMessage(row.SWREF, row.MT);
            break;

        default:
            break;
    }
}

$(document).ready(function (){
    $("#title").html("SWIFT. Візування повідомлень");

    InitGridWindow({ windowID: "#dialogSelectOpCode", srcSettings: { 
        title: "Вибір віз.",
        close: function () {
            if(g_grpid == null){
                bars.ui.notify("Вибір віз", "Виберіть тип візи!", "error");
                selectOpCode();
            }
        }
    } });
    InitGridWindow({ windowID: "#dialogCanselApproveReason", srcSettings: { title: "Вибір причини повернення." } });

    $('#confirmSelectOpCode').click(confirmSelectOpCode);
    $('#confirmCanselApproveReason').click(confirmCanselApproveReason);
    selectOpCode();
});