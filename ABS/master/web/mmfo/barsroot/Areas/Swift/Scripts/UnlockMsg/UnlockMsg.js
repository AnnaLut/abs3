var g_mt = "";

//var toolbar = $("#grid").find(".k-grid-toolbar");
var g_gridMainToolbar = [
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Розблокувати" id="btnUnblock" ><i class="pf-icon pf-16 pf-ok"></i></a>' },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Видалити повідомлення" id="btnDelete" ><i class="pf-icon pf-16 pf-delete"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Видалити повідомлення з документом" id="btnDeleteWithDoc" ><i class="pf-icon pf-16 pf-arrow_left"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Роздрукувати вибрані повідомлення" id="btnPrint" ><i class="pf-icon pf-16 pf-print"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Виигрузити в Excel" id="btnExcel" ><i class="pf-icon pf-16 pf-exel"></i></a>'    }
];
function enableEditBtn() {
    g_gridMainToolbar.push(
        { template: '<a class="k-button" onclick="onClickBtn(this)" title="Редагувати повідомлення" id="btnEdit" ><i class="pf-icon pf-16 pf-view_options"></i></a>'    }
    );
}

function linkToSWREF(SWREF) {
    return '<a href="#" onclick="OpenSWREF(\''+SWREF+'\')" style="color: blue">' + SWREF + '</a>';
}

function OpenSWREF(SWREF) {
    if(SWREF != null && SWREF !== "null"){
        OpenBarsDialog("/barsroot/documentview/view_swift.aspx?swref=" + SWREF);
    }
    else{ bars.ui.error({ title: 'Помилка', text: "Неправильний SWREF!" }); }
}

function GetAndFillRowData(SWREF, SENDER, RECEIVER) {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/swiunlockmsgdetail"),
        success: function (data) {
            var line = "";
            line += "Sender  :\t" + SENDER + "\n";
            line += "Receiver:\t" + RECEIVER + "\n";

            if(data["Data"].length > 0){
                line += data["Data"][0]["RESULT"];
            }
            $("#textAreaClaimsRow").show();
            $("#textAreaClaimsRow").val(line);
        },
        complete: function(jqXHR, textStatus){ Waiting(false); },
        data: JSON.stringify( { SWREF: SWREF, SENDER: SENDER, RECEIVER: RECEIVER })
    } });
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

function onClickBtn(btn) {
    var grid = $('#gridMain').data("kendoGrid");

    if(btn.id == "btnExcel"){
        grid.saveAsExcel();
        return;
    }
    else if(btn.id == "btnEdit"){
        var row = grid.dataItem(grid.select());
        if(row){
            Waiting(true);
            AJAX({ srcSettings: {
                url: bars.config.urlContent("/api/swiunlockmsgedit"),
                success: function (data) {
                    OpenBarsDialog("/barsroot/swift/editmsg?swref=" + row.SWREF + "&mt=" + row.MT, {
                        width: "520px",
                        height: "885px",
                        close: function () {
                            clearTmpMsg(row.SWREF, row.MT);
                        }
                    });
                },
                complete: function(jqXHR, textStatus){ Waiting(false); },
                data: JSON.stringify( { SWREF: row.SWREF, MT: row.MT })
            } });
        }
        else{
            bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
        }
        return;
    }

    var forAction = [];
    grid.tbody.find("input:checked").closest("tr").each(function (index) {
        var uid = $(this).attr('data-uid');
        var item = grid.dataSource.getByUid(uid);
        forAction.push(item.SWREF);
    });

    if(forAction.length == 0){
        bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
        return;
    }

    var aType = "";
    var p_retOpt = -1;
    switch (btn.id){
        case "btnUnblock":
            aType = "Unblock";
            break;

        case "btnDelete":
            p_retOpt = 0;
            aType = "Delete";
            break;

        case "btnDeleteWithDoc":
            p_retOpt = 1;
            aType = "Delete";
            break;

        case "btnPrint":
            var SWREF = "";
            for(var i = 0; i < forAction.length; i++){
                SWREF += forAction[i];
                if(i < forAction.length - 1){
                    SWREF += ";";
                }
            }
            OpenSWREF(SWREF);
            break;
    }

    if(aType != ""){
        bars.ui.confirm({text: "Обробити повідомлення?"}, function () {
            Waiting(true);
            AJAX({ srcSettings: {
                url: bars.config.urlContent("/api/swiunlockmsgaction"),
                success: function (data) {
                    bars.ui.alert({ text: "Операція успішно виконана." });
                    $('.chkFormolsAll').prop('checked', false);
                    $("#textAreaClaimsRow").hide();
                    $("#textAreaClaimsRow").val("");
                    updateMainGrid();
                },
                complete: function(jqXHR, textStatus){ Waiting(false); },
                data: JSON.stringify( { aType: aType, swrefs: forAction, p_retOpt: p_retOpt })
            } });
        });
    }
}

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function initMainGrid() {

    Waiting(true);
    fillKendoGrid("#gridMain", {
        type: "webapi",
        // sort: [ { field: "SWREF", dir: "desc" } ],
        transport: {
            read: {
                url: bars.config.urlContent("/api/swiunlockmsg"),
                data: function () { return { mt: g_mt }; }
            }
        }, pageSize: 10,
        schema: {
            model: {
                fields: {
                    SWREF: { type: "number" },
                    MT: { type: "number" },
                    TRN: { type: "string" },
                    SENDER: { type: "string" },
                    SENDER_NAME: { type: "string" },
                    RECEIVER: { type: "string" },
                    RECEIVER_NAME: { type: "string" },
                    CURRENCY: { type: "string" },
                    AMOUNT: { type: "number" },
                    DATE_PAY: { type: "date" },
                    DATE_REC: { type: "date" },
                    VDATE: { type: "date" }
                }
            }
        }
    }, {
        change: function () {
            var grid = $('#gridMain').data("kendoGrid");
            var row = grid.dataItem(grid.select());
            if(row){
                GetAndFillRowData(row.SWREF, row.SENDER, row.RECEIVER);
            }
        },
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
        reorderable: true,
        excel: {
            allPages: true,
            fileName: "unlock_msgs.xlsx",
            proxyURL: bars.config.urlContent('/Swift/UnlockMsg/ConvertBase64ToFile/')
        },

        //selectable: "multiple",
        columns: [
            {
                field: "block",
                title: "",
                filterable: false,
                sortable: false,
                template: "<input type='checkbox' class='chkFormols' style='margin-left: 26%;' />",
                headerTemplate: "<input type='checkbox' class='chkFormolsAll' id='check-all' onclick='checkAll(this)'/><label for='check-all'> Всі</label>",
                width: "4%"
            },
            {
                template:'#= linkToSWREF(SWREF) #',
                field: "SWREF",
                title: "Реф.",
                width: "8%"
            },
            {
                field: "MT",
                title: "Тип",
                width: "5%"
            },
            {
                field: "TRN",
                title: "SWIFT реф.",
                width: "11%"
            },
            {
                field: "SENDER",
                title: "Відправник",
                width: "8%"
            },
            {
                field: "RECEIVER",
                title: "Отримувач",
                width: "10%"
            },
            {
                field: "CURRENCY",
                title: "Валюта",
                width: "5%"
            },
            {
                field: "AMOUNT",
                title: "Сума",
                template: '#=kendo.toString(AMOUNT,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "8%"
            },
            {
                field: "DATE_REC",
                title: "Дата запису",
                width: "10%",
                template: "<div style='text-align:center;'>#=(DATE_REC == null) ? ' ' : kendo.toString(DATE_REC,'dd.MM.yyyy')#</div>"
            },
            {
                field: "DATE_PAY",
                title: "Дата оплати",
                width: "10%",
                template: "<div style='text-align:center;'>#=(DATE_PAY == null) ? ' ' : kendo.toString(DATE_PAY,'dd.MM.yyyy')#</div>"
            },
            {
                field: "VDATE",
                title: "Дата валют.",
                width: "9%",
                template: "<div style='text-align:center;'>#=(VDATE == null) ? ' ' : kendo.toString(VDATE,'dd.MM.yyyy')#</div>"
            }
        ],
        pageable: {
            messages: {
                allPages: "Всі"
            },
            refresh: true,
            pageSizes: [10, 50, 200, 1000, "All"],
            buttonCount: 5
        }
        }
        ,null               //toolbarTemplate
        ,null               //fetchFunc
        ,g_gridMainToolbar  //toolbar
    );
    setGridNavigationChbx("#gridMain");
}

function checkAll(ele) {
    var grid = $('#gridMain').data('kendoGrid');
    var state = $(ele).is(':checked');
    $('.chkFormols').prop('checked', state == true);
}

$(document).ready(function () {
    $("#title").html("Управління формуванням повідомлень");

    g_mt = bars.extension.getParamFromUrl('mt');
    if(g_mt == "3_0"){
        enableEditBtn();
    }

    initMainGrid();
});