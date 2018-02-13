//***** GLOBALS     *****
var g_CardtypeInited = false;
//var g_maxCards = 1000;
//*****             *****

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function fillCards(p_cardcode, p_delivery_br, p_cardnum, cardName) {
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/BpkW4/InstantCardApi/createinstantcards"),
        success: function (data) {
            bars.ui.notify("Миттєва картка", "Операція успішно виконана. ("+p_cardnum+" шт. Тип: "+cardName+")", 'success');
            updateMainGrid();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //bars.ui.error({ title: 'Помилка', text: "Невдала спроба сформувати миттєву картку." });
        },
        data: JSON.stringify({p_cardcode: p_cardcode, p_delivery_br: p_delivery_br, p_cardnum: p_cardnum})
    } });
}

function getCardtype(product_code) {
    fillDropDownList("#cardtype", {
        transport: {read: {
            url: bars.config.urlContent("/api/BpkW4/InstantCardApi/cardtype"),
            data: {product_code: product_code}
        }},
        schema: {model: {fields: { card_code: { type: "string" }, sub_name: { type: "string" } }}}
    }, {
        optionLabel: " ",
        dataTextField: "sub_name",
        dataValueField: "card_code"
    });
}

function getProduct() {
    fillDropDownList("#product", {
        transport: {read: {url: bars.config.urlContent("/api/BpkW4/InstantCardApi/product")}},
        schema: {model: {fields: { product_code: { type: "string" }, product_name: { type: "string" } }}}
    }, {
        // dataBinding: function (res) {
        //     if(!g_CardtypeInited && this.dataSource._data && this.dataSource._data.length > 0){
        //         g_CardtypeInited = true;
        //         getCardtype(this.dataSource._data[0].product_code);
        //     }
        // },

        change: function(e) {
            var value = this.value();
            getCardtype(value);
        },

        optionLabel: " ",
        dataTextField: "product_name",
        dataValueField: "product_code"
    });
}

function openSelectInstantCard() {
    $("#dialogSelectInstantCard").data('kendoWindow').center().open();
}

function confirmSelectInstantCard() {
    var cardcount = parseInt($("#cardcount").val());
    if(isNaN(cardcount) || cardcount <= 0){
        bars.ui.error({ title: 'Помилка!', text: 'Не вірна кількість карток!' });
        return;
    }
    var cardtype = $("#cardtype").data("kendoDropDownList").value();
    if(!cardtype){
        bars.ui.error({ title: 'Помилка!', text: 'Не правильний тип картки!' });
        return;
    }
    fillCards(cardtype, null, cardcount, $("#cardtype").data("kendoDropDownList").text());

    $("#cardcount").val("");
    $("#dialogSelectInstantCard").data('kendoWindow').close();
}

function initMainGrid() {
    Waiting(true);

    fillKendoGrid("#gridMain", {
        type: "webapi",
        sort: [ { field: "ID", dir: "desc" } ],
        transport: { read: { url: bars.config.urlContent("/api/BpkW4/InstantCardApi/batchesmmsb") } },
        schema: {
            model: {
                fields: {
                    ID: { type: "number" },
                    NAME: { type: "string" },
                    CARD_CODE: { type: "string" },
                    PRODNAME: { type: "string" },
                    NUMBERCARDS: { type: "number" },
                    LCV: { type: "string" },
                    OB22: { type: "string" },
                    TIP: { type: "string" },
                    REGDATE: { type: "date" },
                    LOGNAME: { type: "string" }
                }
            }
        }
    }, {
        columns: [
            {
                field: "ID",
                title: "Ідентифікатор<br>запиту",
                width: "10%"
            },
            {
                field: "NAME",
                title: "Назва запиту",
                width: "14%"
            },
            {
                field: "CARD_CODE",
                title: "Код карткового<br>продукту",
                width: "14%"
            },
            {
                field: "PRODNAME",
                title: "Назва<br>продукту",
                width: "10%"
            },
            {
                field: "NUMBERCARDS",
                title: "Кількість<br>карток",
                width: "10%"
            },
            {
                field: "LCV",
                title: "Валюта",
                width: "8%"
            },
            {
                field: "OB22",
                title: "ОБ22",
                width: "8%"
            },
            {
                field: "TIP",
                title: "Тип рахунку",
                width: "10%"
            },
            {
                field: "REGDATE",
                title: "Дата<br>реєстрації",
                width: "10%",
                template: "<div style='text-align:center;'>#=(REGDATE == null) ? ' ' : kendo.toString(REGDATE,'dd.MM.yyyy')#</div>"
            },
            {
                field: "LOGNAME",
                title: "Логін<br>Користувача",
                width: "9%"
            }
        ]
    }, null, null);
}

$(document).ready(function () {
    InitGridWindow({ windowID: "#dialogSelectInstantCard", srcSettings: {
        title: "Запит на миттєві картки.",
        activate: function(e) {
            getProduct();
        },
        change: function(e) {
            var value = this.value();
            getCardtype(value);
        }
    } });

    $('#confirmInstantCard').click(confirmSelectInstantCard);
    $('#SelectInstantCardBtn').click(openSelectInstantCard);

    initMainGrid();
});