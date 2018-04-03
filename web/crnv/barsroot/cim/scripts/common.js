// Базовий объект
var CIM = CIM || (function () {
    var _args = {};
    return {
        args: function () { return _args; },
        setVariables: function () {
            _args = arguments;
        },
        onPMFailed: function (error, userContext, methodName) {
            if (error !== null) {
                alert(error.get_message());
            }
        },
        reloadAfterCallback: function () {
            location.href = location.href;
        }
    };
} ());

// текущий экземпляр модуля
var curr_module;

// Загрузка страницы
function pageLoad() {
    // инициализация окна процесса загрузки
    $.ajaxCallHelper.init();

    $("input:submit, input:button").button();
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
    $.ajaxProgress.begin();
}

function endRequest(sender, args) {
    $.ajaxProgress.stop();
    // Обработка исключения 
    if (args.get_error() != undefined) {
        args.set_errorHandled(true);
        alert("error");
        core$ErrorBox2();
    }
}

// Установка дополнительних опций для работы PageMethods в cookieless режиме
function SetUpPageMethod() {
    var path = window.location.pathname;
    path = path.substring(path.lastIndexOf('/') + 1);
    PageMethods.set_path(path);
}