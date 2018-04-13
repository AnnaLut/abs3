var CIM = CIM || {};

/// Ідентифікатор поточного вибраного контракту
var contr_id = null;

// Модуль
CIM.pay_module = function () {
    var module = {}; // внутрішній об'єкт модуля 
    var grid_id = null; // id головного гріда
    var diag = null; // объект всплывающего окна состояния документав
    var statusDialogTimer; // таймер для показа окна состояния документа

    // ******** public methods ********
    // утановка стартових параметрів
    module.setVariables = function () {
        grid_id = arguments[0]; // серверний id таблиці
    }
    // ініциалізація форми
    module.initialize = function () {
        diag = $('#dialogDocInfo');
        diag.dialog({
            autoOpen: false,
            resizable: false
        });
        // при відведенні курсору з вікна інф. вікна - ховати його по таймауту
        diag.dialog("widget").unbind().hover(function () { clearTimeout(statusDialogTimer); }, hideStatusDialog);

        //$(".DocStatusFlag").unbind().hover(showStatusDialog, hideStatusDialog);
        // ховаемо стандартний контекстне меню
        if (document.getElementById(grid_id))
            document.getElementById(grid_id).oncontextmenu = function () { return false; };

        $(".barsGridView td").mousedown(function (e) {
            if (e.button == 2) {
                e.preventDefault;
                $(this).click();
                showStatusDialog($(this));
                return false;
            }
            else if (e.button == 1)
                hideStatusDialog();
            return true;
        });
    };

    // візувати документ
    module.DocSetVisa = docSetVisa;
    // сторнувати документ
    module.DocBackVisa = docBackVisa;

    // ******** private methods ********

    function docSetVisa(obj) {
        if (!obj) {
            var sel_row_id = $('#ctl00_MainContent_gvVCimUnboundPayments_selitems');
            //alert(sel_row_id.text());
            //alert(isRowChecked("ctl00_MainContent_gvVCimUnboundPayments"));
            var row = document.getElementById("ctl00_MainContent_gvVCimUnboundPayments" + "_selitems");
            alert(row.innerHTML);
        }
        //alert("DocSetVisa - " + obj);
    }
    function docBackVisa(obj) {
        alert("DocBackVisa - " + obj);
    };

    // Ховаємо панель-акселератор
    function hideStatusDialog() {
        statusDialogTimer = setTimeout(function () { diag.dialog('close'); }, 500);
    }

    // Показати панель-акселератор з інформацією про документ
    function showStatusDialog(elem) {
        clearTimeout(statusDialogTimer);
        if (!elem) elem = $(this);
        diag.dialog('option', 'title', jsres$pay_module.action);
        var x = elem.offset().left + elem.outerWidth() - 4;
        var y = elem.offset().top - $(document).scrollTop() + elem.outerHeight() - 4;
        diag.dialog("option", "position", [x, y]);
        // очищаємо попередні властивості
        diag.find("a").css("cursor", "pointer")
                        .removeAttr("disabled")
                        .css("text-decoration", "underline")
                        .removeClass("ui-state-disabled")
                        .unbind('click')
                        .hover(function () { $(this).css("text-decoration", "none"); },
                               function () { $(this).css("text-decoration", "underline"); });
        // Інформація про документ
        var row = elem.parent();
        var docdata = eval('(' + row.attr("docdata") + ')');
        diag.find("#lbDocRef").text(jsres$pay_module.ref + docdata.rf);
        var typeName = null;
        if (docdata.pt == 0)
            typeName = jsres$pay_module.real_pay;
        else if (docdata.pt == 1)
            typeName = jsres$pay_module.unbound_real_pay;
        else if (docdata.pt == 2)
            typeName = jsres$pay_module.unbound_fantom_pay;

        diag.find("#lbPayType").text(jsres$pay_module.type + typeName);
        var s = jsres$pay_module.sum;
        alert(s);
        diag.find("#lbTotalSum").text(jsres$pay_module.sum.replace("{0}", docdata.ts).replace("{1}", docdata.kv));

        var disabledLinks = new Array();

        // Карточка документу
        if (docdata.rf)
            diag.find("#lnShowCard").click(function () {
                diag.dialog('close');
                window.showModalDialog('/barsroot/documentview/default.aspx?ref=' + docdata.rf, null, 'dialogHeight:650px; dialogWidth:950px');
            });
        else
            disabledLinks.push("#lnShowCard");

        // Завізувати документ
        if (docdata.rf)
            diag.find("#lnSignDoc").click(function () {
                diag.dialog('close');
                docSetVisa(docdata.rf);
            });
        else
            disabledLinks.push("#lnSignDoc");

        // Сторнувати документ
        if (docdata.rf)
            diag.find("#lnKillDoc").click(function () {
                diag.dialog('close');
                docBackVisa(docdata.rf);
            });
        else
            disabledLinks.push("#lnKillDoc");

        diag.find(disabledLinks.join(",")).attr("disabled", "disabled").addClass("ui-state-disabled").css("text-decoration", "none");

        diag.dialog('open');
    }

    return module;
};

CIM.contract_module = function () {
    var module = {}; // внутренний объект модуля 

    var grid_id = null; // id головного гріда
    var diag = null; // объект всплывающего окна состояния документав
    var statusDialogTimer; // таймер для показа окна состояния документа

    // ******** public methods ********
    // утановка стартових параметрів
    module.setVariables = function () {
        grid_id = arguments[0]; // серверний id таблиці
    }

    module.initialize = function () {

    }
    // Добавити новий контракт
    module.AddContract = addContract;

    // ******** private methods ********

    function addContract(obj) {
        alert(grid_id);
        $(location).attr('href', 'contract_card.aspx?mode=create');
    }
    return module;
};

// Загрузка страницы
Sys.Application.add_load(function () {
});

/// Створити новий інший контракт
function fnCreateNewOtherContract() {
    $(location).attr('href', 'other_contract_card.aspx?mode=create');
}

/// Перехід на картку іншого контракту
function fnShowOtherContractCard() {
    var sel_row_id = $('#ctl00_MainContent_gvVCimOtherContracts_selitems').val().replace(';','');
    if (!sel_row_id){
        alert('Виберіть контракт!');
        return false;
    }

    var contr_id = $('#ctl00_MainContent_gvVCimOtherContracts tr:eq(' + sel_row_id + ') td:eq(0)').text();
    $(location).attr('href', 'other_contract_card.aspx?contr_id=' + contr_id);
}

/// 
function fnShowOtherContractStatus() {

}

/// 
function fnShowOtherContractPayments() {

}

/// 
function fnShowClientCard() {
    var sel_row_id = $('#ctl00_MainContent_gvVCimOtherContracts_selitems').val().replace(';', '');
    if (!sel_row_id) {
        alert('Виберіть контракт!');
        return false;
    }

    var rnk = $('#ctl00_MainContent_gvVCimOtherContracts tr:eq(' + sel_row_id + ') td:eq(0)').text();
    $(location).attr('href', '/barsroot/clientregister/registration.aspx?rnk=' + rnk);
}