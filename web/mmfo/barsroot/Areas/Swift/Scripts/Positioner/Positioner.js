var PAGE_INITIAL_COUNT = 30;
var GRID_MAIN_HEIGHT = 200;
var POS_BTNS_ACTIONS = {"btDel": "DEL", "btPayCheck": "PAYCHECK", "btPay": "PAY", "btPayNotAcc": "PAYNOTACC"};
var POS_BTNS_CONFIRM_TXT = {
    "btDel": "Повернути документ відправнику?",
    "btPayCheck": "Оплатити відмічені документи через рахунок ",
    "btPay": "Оплатити відмічені документи з покриттям через рахунок ",
    "btPayNotAcc": "Оплатити без підбору рахунка?"
};

var g_gridCorrespondentInited = false;
var g_kv = null;
var g_pap = 1;

//var toolbar = $("#grid").find(".k-grid-toolbar");
var g_gridMainToolbar = [
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Повернути відправнику" id="btDel" ><i class="pf-icon pf-16 pf-delete"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Оплатити відмічені" id="btPayCheck" ><i class="pf-icon pf-16 pf-ok"></i></a>' },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Оплатити з покриттям" id="btPay" ><i class="pf-icon pf-16 pf-money"></i></a>'    },
    { template: '<a class="k-button" onclick="onClickBtn(this)" title="Оплатити без коррахунку" id="btPayNotAcc"><i class="pf-icon pf-16 pf-money_banknote-server"></i></a> '    }
];

function linkToSWREF(SWREF) {
    return '<a href="#" onclick="OpenSWREF(\''+SWREF+'\')" style="color: blue">' + SWREF + '</a>';
}

function OpenSWREF(SWREF) {
    if(SWREF != null && SWREF !== "null"){
        OpenBarsDialog("/barsroot/documentview/Default.aspx?ref=" + SWREF);
    }
    else{ bars.ui.error({ title: 'Помилка', text: "Неправильний REF!" }); }
}

function onClicRadio(elem) {
    var pap = parseInt(elem.value);
    if(pap != g_pap){
        g_pap = pap;
        updateGrid("#gridCorrespondent");
    }
}

function onClicCheckBox(elem) {
    var grid = $("#gridCorrespondent").data("kendoGrid");
    if(Boolean(elem.checked)){
        grid.showColumn("lcv");
    }
    else{
        grid.hideColumn("lcv");
    }
}

function onClickBtn(btn) {
    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());
    if(!row){
        bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
        return;
    }

    var confirmText = POS_BTNS_CONFIRM_TXT[btn.id];
    var d = { p_ref: row.REF, p_type: POS_BTNS_ACTIONS[btn.id] };       // main data for action

    var gridAcc = $('#gridCorrespondent').data("kendoGrid");
    if(btn.id != "btPayNotAcc"){
        if(btn.id != "btDel"){
            if(!gridAcc){
                bars.ui.error({ title: 'Помилка', text: "Не обрано коррахунок!" });
                return;
            }
            var rowAcc = gridAcc.dataItem(gridAcc.select());
            if(!rowAcc){
                bars.ui.error({ title: 'Помилка', text: "Не обрано коррахунок!" });
                return;
            }
            d["p_acc"] = rowAcc.acc;
        }
        if(btn.id == "btPay" || btn.id == "btPayCheck"){
            confirmText += rowAcc.nls + "?";
        }
    }

    bars.ui.confirm({text: confirmText}, function (){
        Waiting(true);
        AJAX({ srcSettings: {
            url: bars.config.urlContent("/api/positioneraction"),
            success: function (data) {
                g_kv = null;
                if(gridAcc){
                    gridAcc.dataSource.data([]);        // clear ACC grid
                }
                updateGrid("#gridMain");

                if(btn.id == "btPay"){
                    var ref_nos = data["ref_nos"];

                    var DialogOptions = 'dialogHeight:480px; dialogWidth:640px; scroll: no';
                    var DialogObject = {windowName: "DialogPositionerMt"};
                    var returnValue = window.showModalDialog("/barsroot/swi/positioner_mt.aspx?acc=" + d["p_acc"] + "&ref=" + ref_nos
                        , DialogObject, DialogOptions);

                    if (returnValue != true) {
                        bars.ui.error({ title: 'Увага', text: "Створено документ: " + ref_nos });
                    }
                    else {
                        bars.ui.alert({ text: "Операція успішно виконана." });
                    }
                }
                else{
                    bars.ui.alert({ text: "Операція успішно виконана." });
                }
            },
            complete: function(jqXHR, textStatus){ Waiting(false); },
            data: JSON.stringify(d)
        } });
    });
}

function initMainGrid() {

    fillKendoGrid("#gridMain", {
        type: "webapi",
        // sort: [ { field: "SWREF", dir: "desc" } ],
        transport: {
            read: {
                url: bars.config.urlContent("/api/positionersearch"),
                data: function () { return { Ref: null }; }
            }
        }, pageSize: PAGE_INITIAL_COUNT,
        schema: {
            model: {
                fields: {
                    REF: { type: "number" },
                    tt: { type: "string" },
                    vob: { type: "number" },
                    trn_amount: { type: "number" },
                    s: { type: "number" },
                    nlsa: { type: "string" },
                    kv: { type: "number" },
                    nlsb: { type: "string" },
                    kv2: { type: "number" },
                    dk: { type: "number" },
                    bank_bic: { type: "string" },
                    bank_name: { type: "string" },
                    nazn: { type: "string" }
                }
            }
        }
    }, {
        change: function () {
            var grid = this;
            var row = grid.dataItem(grid.select());
            if(row){
                if(g_kv != row.kv){
                    g_kv = row.kv;
                    if(g_gridCorrespondentInited){
                        updateGrid("#gridCorrespondent");
                    }
                    else{
                        Waiting(true);
                        g_gridCorrespondentInited = true;
                        initCorrespondentGrid();
                    }
                }
            }
        },
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
        reorderable: true,
            dataBound: function () {
                Waiting(false);
                $('#gridMain .k-grid-content').height(GRID_MAIN_HEIGHT);
            },
        columns: [
            {
                template:'#= linkToSWREF(REF) #',
                field: "REF",
                title: "Референс",
                width: "7%"
            },
            {
                field: "tt",
                title: "Код операції",
                width: "5%"
            },
            {
                field: "vob",
                title: "Вид",
                width: "4%"
            },
            {
                field: "trn_amount",
                title: "Сума проплати",
                width: "8%",
                template: '#=(trn_amount == null) ? "" : kendo.toString(trn_amount,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" }
            },
            {
                field: "s",
                title: "Сума документа",
                template: '#=(s == null) ? "" : kendo.toString(s,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "8%"
            },
            {
                field: "nlsa",
                title: "Рахунок А",
                width: "8%"
            },
            {
                field: "kv",
                title: "Валюта А",
                width: "6%"
            },
            {
                field: "nlsb",
                title: "Рахунок Б",
                width: "8%"
            },
            {
                field: "kv2",
                title: "Валюта Б",
                width: "6%"
            },
            {
                field: "dk",
                title: "ДК",
                width: "3%"
            },
            {
                field: "bank_bic",
                title: "Код банку отримувача",
                width: "9%"
            },
            {
                field: "bank_name",
                title: "Назва банку отримувача",
                width: "20%"
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
        ,null               //toolbarTemplate
        ,null               //fetchFunc
        ,g_gridMainToolbar  //toolbar
    );
    //setGridNavigation("#gridMain");
}

function initCorrespondentGrid() {

    fillKendoGrid("#gridCorrespondent", {
            type: "webapi",
            // sort: [ { field: "SWREF", dir: "desc" } ],
            transport: {
                read: {
                    url: bars.config.urlContent("/api/positionercorrespondentsearch"),
                    data: function () { return { kv: g_kv, pap: g_pap }; }
                }
            }, pageSize: PAGE_INITIAL_COUNT,
            schema: {
                model: {
                    fields: {
                        acc: { type: "number" },
                        nls: { type: "string" },
                        nms: { type: "string" },
                        kv: { type: "number" },
                        lcv: { type: "string" },
                        ostc: { type: "string" },
                        ostb: { type: "string" },
                        bic: { type: "string" }
                    }
                }
            }
        }, {
            change: function () {
                var grid = this;
                var row = grid.dataItem(grid.select());
                if(row){

                }
            },
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
            reorderable: true,
            dataBound: function () {
                Waiting(false);
                $('#gridCorrespondent .k-grid-content').height(GRID_MAIN_HEIGHT);
            },
            columns: [
                {
                    field: "acc",
                    title: "Ід. рахунку",
                    width: "12%"
                },
                {
                    field: "nls",
                    title: "Номер рахунку",
                    width: "12%"
                },
                {
                    field: "nms",
                    title: "Назва рахунку",
                    width: "12%"
                },
                {
                    field: "kv",
                    title: "Код валюти",
                    width: "12%"
                },
                {
                    field: "lcv",
                    title: "Код валюти ISO",
                    width: "12%"
                },
                {
                    field: "ostc",
                    title: "Фактичний залишок",
                    width: "12%",
                    attributes: { "class": "money" }
                },
                {
                    field: "ostb",
                    title: "Плановий залишок",
                    width: "12%",
                    attributes: { "class": "money" }
                },
                {
                    field: "bic",
                    title: "Код банку",
                    width: "16%"
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
        ,"#gridCorrespondent-template"               //toolbarTemplate
        ,null               //fetchFunc
        ,null  //toolbar
    );

    onClicCheckBox({checked: false});

    //setGridNavigation("#gridMain");
}

$(document).ready(function () {
    $("#title").html("Позиціонер банку");

    Waiting(true);
    initMainGrid();
});