var Features ={
    SendToBankOld: false
};

// Базовий объект
var CIM = CIM || (function () {
    var _args = {};
    var _isDebug = false;
    var _ContractClass = {
        ContrId: null, ContrType: null, ContrTypeName: null, Num: null, Rnk: null,
        Kv: null, Sum: null, BenefId: null, StatusId: 0,
        StatusName: null, Comments: null, Branch: null, BranchName: null,
        ClientInfo: null, BeneficiarInfo: null, DateOpenS: null, DateCloseS: null
    };
    
    return {
        args: function () { return _args; },
        ContractClass: function () { return _ContractClass; },
        setVariables: function () {
            _args = arguments;
        },
        onPMFailed: function (error, userContext, methodName) {
            if (error !== null) {
                core$ErrorBoxEx(error);
            }
        },
        formatNum: function (val,precision){
            if(!precision) precision = 2;
            return (isNaN(val))?(Number(0).toFixed(precision)):(Number(val).toFixed(precision));
        },
        reloadAfterCallback: function () {
            $.ajaxProgress.block();
            location.href = location.href.replace('#', '');;
        },
        setDebug: function (flag) {
            _isDebug = flag;
        },
        reloadPage: function ()
        {
            $.ajaxProgress.block();
            location.href = location.href.replace('#', '');
        },
        debug: function (message, obj) {
            if (_isDebug) {
                for(var i=1; i<arguments.length; i++)
                    message += "[" + JSON.stringify(arguments[i]) + "]\n";
                alert("CIM::debug\n" + message);
            }
        }
    };
}());

// текущий экземпляр модуля
var curr_module;

// Загрузка страницы
function pageLoad() {
    // инициализация окна процесса загрузки
    $.ajaxCallHelper.init();

    $("input:submit, input:button, button").button();

    $(".btn-add-ico").button({ icons: { primary: "ui-icon-plusthick" } });
    $(".btn-pin-ico").button({ icons: { primary: "ui-icon-pin-s" } });
    $(".btn-disk-ico").button({ icons: { primary: "ui-icon-disk" } });
    $(".btn-back-ico").button({ icons: { primary: "ui-icon-circle-arrow-w" } });

    // добавляем возможность схлопывания всех панелей
    $("legend").wrapInner("<span href=# title='Сховати\\показати' style='cursor:hand'></span>").click(function () { $(this).next().toggle(); });

    $(".ctrl-date").datepicker({
        changeMonth: true,
        changeYear: true,
        buttonImageOnly: true,
        buttonImage: "/Common/Images/default/16/calendar.png ",
        showButtonPanel: true,
        showOn: "button"
    });

    // иницализация всех числовых контролов
    //$('.numeric').numeric({ negative: false });
    $('.numeric').inputmask("decimal", { radixPoint: "." });
}

function getParByName(name) {
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regexS = "[\\?&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(window.location.search);
    if (results == null)
        return "";
    else
        return decodeURIComponent(results[1].replace(/\+/g, " "));
}

// Перехват завершения загрузки страницы
Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequest);
Sys.WebForms.PageRequestManager.getInstance().add_initializeRequest(initializeRequest);

function initializeRequest(sender, args) {
    if (document.forms[0] && document.forms[0].__EVENTARGUMENT && document.forms[0].__EVENTARGUMENT.value == "Bars$exportExcel") {
        args.set_cancel(true);
        sender._form["__EVENTTARGET"].value = args.get_postBackElement().id.replace(/\_/g, "$");
        sender._form["__EVENTARGUMENT"].value = "Bars$exportExcel";
        sender._form.submit();
        return;
    }
    $.ajaxProgress.begin();
}

function endRequest(sender, args) {
    $.ajaxProgress.stop();
    // Обработка исключения 
    if (args.get_error() != undefined) {
        args.set_errorHandled(true);
        core$ErrorBox2();
    }
}

// Установка дополнительних опций для работы PageMethods в cookieless режиме
function SetUpPageMethod() {
    var path = window.location.pathname;
    path = path.substring(path.lastIndexOf('/') + 1);
    PageMethods.set_path(path);
}
