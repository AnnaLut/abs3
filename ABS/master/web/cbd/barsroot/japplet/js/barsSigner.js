// Базовий объект работы с подписью 
var barsSign = window.barsSign || (function () {
    var _options = {};
    var _isDebug = false;
    var _currModule = null;
    var _moduleTypes = { AX: 0, JAVA: 1, SL: 2, AW: 3 }; // 0 - activeX, 1 - javaApplen, 2 - Silverlight, 3 - Awesomium
    var _extend = function (o1, o2) {
        var o = {};
        for (var attrname in o1) { o[attrname] = o1[attrname]; }
        for (attrname in o2) { o[attrname] = o2[attrname]; }
        return o;
    };

    return {
        // типа Enum списка реализованых модулей
        ModuleTypes: _moduleTypes,
        // опции для инициализации
        getOptions: function () { return _options; },
        // инициализация
        init: function (options) {
            _options = _extend(barsSign.options, options);
            switch (_options.ModuleType) {
                case _moduleTypes.AX: _currModule = barsSign.activex_module(); break;
                case _moduleTypes.JAVA: _currModule = barsSign.java_module(); break;
                default: alert("Вказаний код модуля [" + _options.ModuleType + "] не реалізований"); break;
            }
            if (_currModule)
                _currModule.initialize(_options);
        },
        // подписать буфер
        signBuffer: function (strBuf) {
            return _currModule.signBuffer(strBuf);
        },
        // проверка подписи
        checkSign: function (strBuf, strSignBuf, keyId) {
            return _currModule.checkSign(strBuf, strSignBuf, keyId);
        },
        // показать настройки
        showOptions: function () {
            if (_currModule)
                _currModule.showOptions();
        },
        // показать настройки
        showLogFile: function () {
            if (_currModule)
                _currModule.showLogFile();
        },
        // устновка режима отладки
        setDebug: function (flag) {
            _isDebug = flag;
        },
        // получить флаг отладки
        getDebug: function (flag) {
            return _isDebug;
        },
        // окно отладки
        debug: function (message) {
            if (_isDebug) {
                for (var i = 1; i < arguments.length; i++) {
                    message += "\n arg" + i + "(" + arguments[i] + ") :\n";
                    for (var key in arguments[i])
                        message += "   " + key + " : " + arguments[i][key] + " \n";
                }
                alert("barsSign::debug\n" + message);
            }
        },
        encodeToHex: function (str) {
            var r = "";
            var e = str.length;
            var c = 0;
            var h;
            while (c < e) {
                h = str.charCodeAt(c++).toString(16);
                while (h.length < 2) h = "0" + h;
                r += h;
            }
            return r;
        },
        decodeFromHex: function (str) {
            var r = "";
            var e = str.length;
            var s;
            while (e >= 0) {
                s = e - 2;
                r = String.fromCharCode("0x" + str.substring(s, e)) + r;
                e = s;
            }
            return r;
        }
    };
}());

// константы
barsSign.constants = {
    Version: "1.0.0.1",                 // версия скрипта
    ActiveX: {
        Name: "BARSAX.RSAC"             // имя ActiveX
    },
    Java: {
        AppletPage: "/barsroot/japplet/barsApplet.html"
    }
};

// умолчательные параметры
barsSign.options = {
    SignType: "VEG",                    // криптопровайдер 
    ModuleType: 0,                      // тип клиентского софта для роботы 
    BufferEncoding: "WIN",              // кодировка строки буфера
    BankDate: "2014/08/11 12:08:00",    // опционально - текущая дата в формате YYYY/MM/DD HH:mm:ss
    KeyId: "289YID00"                   // идентификатор ключа - берем из настроек
};

// локализация - потом винести в отдельние js-файлы для разных локалей 
barsSign.res = {
    lang: "ua",
    ActiveX: {
        notInit: "ActiveX не ініціалізовано",
        notInstall: "Не знайдено програмного забезпечення для накладення ЕЦП (ActiveX). Зверніться до адміністратора."
    },
    Java: {

    }
};

// 
barsSign.activex_module = function () {
    var module = {}; // внутренний объект модуля 
    var aSigner = null;
    //var aName = "BARSAX.RSAC";
    var isInitialized = false;

    //#region ******** public methods ********
    module.initialize = function (options) {
        try {
            aSigner = new ActiveXObject(barsSign.constants.ActiveX.Name);
            if (!aSigner.IsInitialized) aSigner.Init(options.SignType);
            if (!aSigner.IsInitialized) {
                alert(barsSign.res.ActiveX.notInit);
            } else {
                aSigner.BufferEncoding = options.BufferEncoding;
                aSigner.BankDate = options.BankDate;
                aSigner.IdOper = options.KeyId;
                isInitialized = true;
            }
        }
        catch (e) {
            alert(barsSign.res.ActiveX.notInstall);
            return false;
        }
        if (options.CallBackOnSuccess)
            options.CallBackOnSuccess(true);
        barsSign.debug("ActiveX успішно ініціалізовано", options, barsSign.options);
        return true;
    };

    module.signBuffer = _signBuffer;
    module.checkSign = _checkSign;
    module.showOptions = _showOptions;
    module.showLogFile = _showLogFile;
    //#endregion 

    // ******** private methods ********
    function _signBuffer(strBuf) {
        var strSingBuf = aSigner.SignBuffer(strBuf);
        barsSign.debug("Call activex_module::signBuffer(strBuf)", { "strBuf": strBuf, "strSingBuf": strSingBuf });
        return strSingBuf;
    }

    function _checkSign(strBuf, strSignBuf, keyId) {
        var res = aSigner.VerifySignatureHex(strBuf, strSignBuf, keyId || aSigner.IdOper);
        barsSign.debug("Call activex_module::checkSign(strSignBuf)", { "strSignBuf": strSignBuf, "strBuf": strBuf, "keyId": keyId, "res": res });
        return res === 0;
    }

    function _showOptions() {
        alert("Налаштування недоступні.");
    }

    function _showLogFile() {
        alert("Перегляд файлу недоступный.");
    }
    //#endregion

    return module;
};

barsSign.java_module = function () {
    var module = {}; // внутренний объект модуля 
    // constants
    //var appletPageUrl = '/barsroot/japplet/barsApplet.html?v1.0'; // адре
    var appletObj = null;
    var iframeElement = null;
    var isInitialized = false;

    //#region ******** public methods ********
    module.initialize = function (options) {
        // проверяем есть ли уже созданый объект на странице - если нету
        if (!window.top.$("#ifBarsApplet").size()) {
            // создаем iframe, куда грузим наш аплет
            iframeElement = $("<iframe id='ifBarsApplet' src='" + getAppletHtmlPage(options) + "' />");
            //if (window.top.$("#dvJavaFrame").size() > 0)
            //    window.top.$("#dvJavaFrame").append(iframeElement);
            //else
            window.top.$("body").append(iframeElement.hide());
            iframeElement.load(function () {
                isInitialized = true;
                appletObj = window.top.$("#ifBarsApplet").contents().find("#barsApplet")[0];
                if (options.CallBackOnSuccess) {
                    appletObj.callbackMethod("init", "onInit");
                    options.CallBackOnSuccess(true);
                }
                //barsSign.debug("init :: AppletIsAccessible", appletObj.AppletIsAccessible);
            });
        }
            // если есть 
        else {
            appletObj = window.top.$("#ifBarsApplet").contents().find("#barsApplet")[0];
            isInitialized = !!appletObj;
            if (options.CallBackOnSuccess)
                options.CallBackOnSuccess(true);
            //barsSign.debug("reinit :: AppletIsAccessible", appletObj.AppletIsAccessible);
        }
        //barsSign.debug("javaapplet успішно ініціалізовано", options, barsSign.options);
    };

    module.signBuffer = _signBuffer;
    module.checkSign = _checkSign;
    module.showOptions = _showOptions;
    module.showLogFile = _showLogFile;
    //#endregion 

    // ******** private methods ********
    function getAppletHtmlPage(options) {
        return barsSign.constants.Java.AppletPage + "?v" + barsSign.constants.Version + ((barsSign.getDebug()) ? (Math.random()) : (""));
    }

    function _signBuffer(strBuf) {
        if (!isInitialized) return;
        var strSingBuf = appletObj.SignBuffer(strBuf);
        barsSign.debug("Call java_module::signBuffer(strBuf)", { "strBuf": strBuf, "strSingBuf": strSingBuf });
        return strSingBuf;
    }

    function _checkSign(strBuf, strSignBuf, keyId) {
        alert(strBuf);
        alert(strSignBuf);
        var res = appletObj.CheckSign(strBuf, strSignBuf);
        barsSign.debug("Call java_module::checkSign(strSignBuf)", { "strSignBuf": strSignBuf, "strBuf": strBuf, "keyId": keyId, "res": res });
        //appletObj.paViewLogFile();
        return res;
    }

    function _showOptions() {
        if (!isInitialized) return;
        appletObj.paShowOptions();
        //appletObj.barsSecurity.ShowOptions();
    }

    function _showLogFile() {
        if (!isInitialized) return;
        appletObj.paViewLogFile();
    }
    //#endregion
    return module;
};