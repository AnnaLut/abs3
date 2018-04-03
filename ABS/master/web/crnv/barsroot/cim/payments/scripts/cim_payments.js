var diag = null; // объект всплывающего окна контекстного меню

Sys.Application.add_load(function () {
    curr_module = CIM.pay_module();
    curr_module.initialize(CIM.args());
});

// Модуль нерозібрані платежі
CIM.pay_module = function () {
    var module = {}; // внутрішній об'єкт модуля 
    var grid_id = null; // id головного гріда
    var statusDialogTimer; // таймер для показа окна состояния документа

    // ******** public methods ********
    // ініциалізація форми
    module.initialize = function (args) {
        grid_id = args[0];
        if (document.getElementById(grid_id))
            document.getElementById(grid_id).oncontextmenu = function () { return false; };
        if (diag) diag.dialog("destroy");
        diag = $('#dialogDocInfo');
        diag.dialog({
            autoOpen: false,
            resizable: false
        });
        // при відведенні курсору з вікна інф. вікна - ховати його по таймауту
        diag.dialog("widget").unbind().hover(function () { clearTimeout(statusDialogTimer); }, hideStatusDialog);

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
    // привязати документ
    module.DocBind = docBind;
    // ********************************

    // ******** private methods ********
    function confirmAction(result) {
        alert(result);
        //CallPageMethod("PM_SetVisa", "{docRef:" + docRef + "}", OnDocSetVisa);
    }

    // Накладення візи 
    function docSetVisa(obj) {

        var docRef = obj;
        if (!obj) {
            var docdata = eval('(' + $(".selectedRow").attr("docdata") + ')');
            docRef = docdata.rf;
        }
        core$ConfirmBox("Накласти на документ[ref=" + docRef + "] візу валютного контролю", "Візування документу", confirmAction);
    }

    function OnDocSetVisa(result) {
        alert(result.d);
        if (result.d) {
            core$SuccessBox("Візу валютного контролю успішно накладено.", "Візування операції");
        }
    }

    // Повернення візи 
    function docBackVisa(obj) {
        var docRef = obj;
        if (!obj) {
            var docdata = eval('(' + $(".selectedRow").attr("docdata") + ')');
            docRef = docdata.rf;
        }
        CallPageMethod("PM_BackVisa", "{docRef:" + docRef + "}", OnDocBackVisa);
    };

    function OnDocBackVisa(result) {
        alert(result.d);
        if (result.d) {
            core$SuccessBox("Повернення на одну візу назад по документу успішно виконано.", "Повернення документу");
        }
    }
    function docBind(obj) {
        var ref = obj;
        if (!obj) {
            var docdata = eval('(' + $(".selectedRow").attr("docdata") + ')');
            ref = docdata.rf;
        }
        alert("DocBind - " + ref);
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

        var typeName = null;
        if (docdata.pt == 0)
            typeName = jsres$pay_module.real_pay;
        else if (docdata.pt == 1)
            typeName = jsres$pay_module.unbound_real_pay;
        else if (docdata.pt == 2)
            typeName = jsres$pay_module.unbound_fantom_pay;
        var s = new Number(docdata.ts);
        diag.find("#lbDocRef").html(jsres$pay_module.ref.replace("{0}", docdata.rf));
        diag.find("#lbPayType").html(jsres$pay_module.type.replace("{0}", typeName));
        diag.find("#lbTotalSum").html(jsres$pay_module.sum.replace("{0}", s.toFixed(2)).replace("{1}", docdata.kv));

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

        // Привязати документ
        if (docdata.rf)
            diag.find("#lnBindDoc").click(function () {
                diag.dialog('close');
                docBind(docdata.rf);
            });
        else
            disabledLinks.push("#lnBindDoc");

        diag.find(disabledLinks.join(",")).attr("disabled", "disabled").addClass("ui-state-disabled").css("text-decoration", "none");

        diag.dialog('open');
    }
    // ********************************

    return module;
};
