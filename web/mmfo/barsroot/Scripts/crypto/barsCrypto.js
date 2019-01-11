// Базовий объект работы с криптографией 
var barsCrypto = window.barsCrypto || (function () {
    var _options = {};
    var _isDebug = false;
    var _alertWindow = false;
    var _currModule = null;
    var _moduleTypes = { VEG: 'VEG', VG2: 'VG2' }; // enum for supported modules
    var _extend = function (o1, o2) {
        var o = {};
        for (var attrname in o1) { o[attrname] = o1[attrname]; }
        for (attrname in o2) { o[attrname] = o2[attrname]; }
        return o;
    };
    var _encodeToHex = function (str) {
        var r = '';
        var e = str.length;
        var c = 0;
        var h;
        while (c < e) {
            h = str.charCodeAt(c++).toString(16);
            while (h.length < 2) h = '0' + h;
            r += h;
        }
        return r.toUpperCase();
    }
    var _decodeFromHex = function (str) {
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
    // convert string Unicode -> Win1251
    var charsMap = { 0: 0, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9, 10: 10, 11: 11, 12: 12, 13: 13, 14: 14, 15: 15, 16: 16, 17: 17, 18: 18, 19: 19, 20: 20, 21: 21, 22: 22, 23: 23, 24: 24, 25: 25, 26: 26, 27: 27, 28: 28, 29: 29, 30: 30, 31: 31, 32: 32, 33: 33, 34: 34, 35: 35, 36: 36, 37: 37, 38: 38, 39: 39, 40: 40, 41: 41, 42: 42, 43: 43, 44: 44, 45: 45, 46: 46, 47: 47, 48: 48, 49: 49, 50: 50, 51: 51, 52: 52, 53: 53, 54: 54, 55: 55, 56: 56, 57: 57, 58: 58, 59: 59, 60: 60, 61: 61, 62: 62, 63: 63, 64: 64, 65: 65, 66: 66, 67: 67, 68: 68, 69: 69, 70: 70, 71: 71, 72: 72, 73: 73, 74: 74, 75: 75, 76: 76, 77: 77, 78: 78, 79: 79, 80: 80, 81: 81, 82: 82, 83: 83, 84: 84, 85: 85, 86: 86, 87: 87, 88: 88, 89: 89, 90: 90, 91: 91, 92: 92, 93: 93, 94: 94, 95: 95, 96: 96, 97: 97, 98: 98, 99: 99, 100: 100, 101: 101, 102: 102, 103: 103, 104: 104, 105: 105, 106: 106, 107: 107, 108: 108, 109: 109, 110: 110, 111: 111, 112: 112, 113: 113, 114: 114, 115: 115, 116: 116, 117: 117, 118: 118, 119: 119, 120: 120, 121: 121, 122: 122, 123: 123, 124: 124, 125: 125, 126: 126, 127: 127, 1027: 129, 8225: 135, 1046: 198, 8222: 132, 1047: 199, 1168: 165, 1048: 200, 1113: 154, 1049: 201, 1045: 197, 1050: 202, 1028: 170, 160: 160, 1040: 192, 1051: 203, 164: 164, 166: 166, 167: 167, 169: 169, 171: 171, 172: 172, 173: 173, 174: 174, 1053: 205, 176: 176, 177: 177, 1114: 156, 181: 181, 182: 182, 183: 183, 8221: 148, 187: 187, 1029: 189, 1056: 208, 1057: 209, 1058: 210, 8364: 136, 1112: 188, 1115: 158, 1059: 211, 1060: 212, 1030: 178, 1061: 213, 1062: 214, 1063: 215, 1116: 157, 1064: 216, 1065: 217, 1031: 175, 1066: 218, 1067: 219, 1068: 220, 1069: 221, 1070: 222, 1032: 163, 8226: 149, 1071: 223, 1072: 224, 8482: 153, 1073: 225, 8240: 137, 1118: 162, 1074: 226, 1110: 179, 8230: 133, 1075: 227, 1033: 138, 1076: 228, 1077: 229, 8211: 150, 1078: 230, 1119: 159, 1079: 231, 1042: 194, 1080: 232, 1034: 140, 1025: 168, 1081: 233, 1082: 234, 8212: 151, 1083: 235, 1169: 180, 1084: 236, 1052: 204, 1085: 237, 1035: 142, 1086: 238, 1087: 239, 1088: 240, 1089: 241, 1090: 242, 1036: 141, 1041: 193, 1091: 243, 1092: 244, 8224: 134, 1093: 245, 8470: 185, 1094: 246, 1054: 206, 1095: 247, 1096: 248, 8249: 139, 1097: 249, 1098: 250, 1044: 196, 1099: 251, 1111: 191, 1055: 207, 1100: 252, 1038: 161, 8220: 147, 1101: 253, 8250: 155, 1102: 254, 8216: 145, 1103: 255, 1043: 195, 1105: 184, 1039: 143, 1026: 128, 1106: 144, 8218: 130, 1107: 131, 8217: 146, 1108: 186, 1109: 190 };
    var _unicodeToWin1251 = function (s) {
        var L = [];
        for (var i = 0; i < s.length; i++) {
            var ord = s.charCodeAt(i);
            if (!(ord in charsMap))
                throw "Character " + s.charAt(i) + " isn't supported by win1251! " + s;
            L.push(String.fromCharCode(charsMap[ord]));
        }
        return L.join('');
    }
    var encode_utf8 = function (s) {
        return unescape(encodeURIComponent(s));
    }
    var decode_utf8 = function (s) {
        return decodeURIComponent(escape(s));
    }
    // polyfill for IE - convert Date to string
    var _toISOString = function (date) {
        function pad(number) {
            var r = String(number);
            if (r.length === 1)
                r = '0' + r;
            return r;
        }
        return date.getUTCFullYear()
            + '-' + pad(date.getUTCMonth() + 1)
            + '-' + pad(date.getUTCDate())
            + 'T' + pad(date.getUTCHours())
            + ':' + pad(date.getUTCMinutes())
            + ':' + pad(date.getUTCSeconds())
            + '.' + String((date.getUTCMilliseconds() / 1000).toFixed(3)).slice(2, 5)
            + 'Z';
    }
    var _verifySignatureService = function (data, cbSuccess, cbError) {
        var jsonArg = JSON.stringify(data);
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: jsonArg,
            dataType: "json",
            url: '/barsroot/checkinner/Service.asmx/VerifySignature',
            success: cbSuccess,
            error: cbError
        });
    }
    return {
        // enum of supported modules
        ModuleTypes: _moduleTypes,
        // get init options
        getOptions: function () { return _options; },
        // инициализация
        init: function (options) {
            //if (_currModule) return;
            _options = _extend(barsCrypto.options, options);
            switch (_options.ModuleType) {
                case _moduleTypes.VEG: _currModule = barsCrypto.vega_module(); break;
                case _moduleTypes.VG2: _currModule = barsCrypto.vega2_module(); break;
                default: alert("Вказаний код модуля [" + _options.ModuleType + "] не реалізований"); break;
            }
            if (_currModule)
                _currModule.initialize(_options);
        },
        // верисия ПЗ
        getVersion: function (cbSuccess, cbError) {
            return _currModule.getVersion(cbSuccess, cbError);
        },
        getModuleVersions: function (cbSuccess, cbError) {
            return _currModule.getModuleVersions(cbSuccess, cbError);
        },
        getStatus: function () {
            return _currModule.getStatus();
        },
        // update
        getUpdate: function (data, cbSuccess, cbError) {
            return _currModule.getUpdate(data, cbSuccess, cbError);
        },
        // update
        startIe: function (data, cbSuccess, cbError) {
            if (!_currModule)
                _currModule = barsCrypto.vega2_module();
            return _currModule.startIe(data, cbSuccess, cbError);
        },
        // start BarsCryptor 
        startBarsCryptor: function () {
            var ifrm = document.createElement("iframe");
            ifrm.setAttribute("src", "barscryptor:///");
            ifrm.style.width = "1px";
            ifrm.style.height = "1px";
            document.body.appendChild(ifrm);
            ifrm.focus();
        },
        // подготовка буфера для подписи (конвертация UNICODE -> WIN1251 -> HEX)
        prepareBuffer: function (buffer) {
            return _encodeToHex(_unicodeToWin1251(buffer));
        },
        // подписать буфер
        signBuffer: function (buffer, cbSuccess, cbError) {
            return _currModule.signBuffer(buffer, cbSuccess, cbError);
        },
        // проверка подписи
        verifySign: function (buffer_hex, keyid, sign_hex, cbSuccess, cbError) {
            return _currModule.verifySign(buffer_hex, keyid, sign_hex, cbSuccess, cbError);
        },
        // установка режима отладки
        setDebug: function (flag, alertWindow) {
            _isDebug = flag;
            _alertWindow = !!alertWindow;
        },
        // окно отладки
        debug: function (message, params) {
            if (_isDebug) {
                if (typeof console !== 'undefined') {
                    console.log(_toISOString(new Date()) + " [" + _currModule.tag + "] " + message, params, Array.prototype.slice.call(arguments, 2));
                }
                if (!_alertWindow) return;
                for (var i = 1; i < arguments.length; i++) {
                    message += "\n arg" + i + "(" + arguments[i] + ") :\n";
                    for (var key in arguments[i])
                        message += "   " + key + " : " + arguments[i][key] + " \n";
                }
                alert(_currModule.tag + "::debug\n" + message);
            }
        },
        encodeToHex: function (str) {
            return _encodeToHex(str);
        },
        decodeFromHex: function (str) {
            return _decodeFromHex(str);
        },
        processDoc: function (doc_obj, cbSuccess, cbError) {
            barsCrypto.debug("processDoc.1, doc_obj", doc_obj);
            // асинхронный цикл проверки всех внутр ЭЦП
            function VerifyIntSignRecursive(context, lev, doc_obj, cbSuccess, cbError) {
                // проверка не нужна или дошли до дна рекурсии
                barsCrypto.debug("processDoc.2, VerifyIntSignRecursive ", { "doc_obj.needIntCheck()": doc_obj.needIntCheck(), "lev": lev });
                if (!doc_obj.needIntCheck() || lev == 0) {
                    cbSuccess(context);
                    return;
                }
                // беремо елемент з внутрішнім підписом
                var item = doc_obj.int_ecp[lev - 1];
                // перевіряємо підпис в залежності від типу
                if (item.sign_type == 'VEG') {
                    // перевіряємо чи ініціалізовано підпис
                    if (!context.SignVega1) {
                        cbError('Неможливо перевірити підпис, ЕЦП Вега1 не ініціалізована');
                        return;
                    }
                    // перевіряємо підпис
                    context.SignVega1.verifySign(item.buffer_hex, item.keyid, item.sign_hex, function () {
                        VerifyIntSignRecursive(context, lev - 1, doc_obj, cbSuccess, cbError);
                    }, cbError);
                } else if (item.sign_type == 'VG2') {
                    // перевіряємо чи ініціалізовано підпис
                    if (_options.ModuleType !== item.sign_type) {
                        cbError('Неможливо перевірити підпис, ЕЦП Вега2 не ініціалізована');
                        return;
                    }
                    // перевіряємо підпис
                    var verifyInfo = {
                        Id: doc_obj.ref,
                        Level: lev,
                        KeyId: item.key_id,
                        Buffer: item.buffer_hex,
                        Sign: item.sign_hex,
                        BufferType: 'int',
                        ModuleName: 'vega2'
                    };
                    _verifySignatureService({ verifyInfo: verifyInfo },
                        function (response) {
                            if (response.d && response.d.Status !== 0) {
                                cbError(response.d.ErrorMessage);
                                return;
                            }
                            VerifyIntSignRecursive(context, lev - 1, doc_obj, cbSuccess, cbError);
                        },
                        cbError);

                    /*_currModule.verifySign(item.buffer_hex, item.key_id, item.sign_hex,
                        function () {
                            VerifyIntSignRecursive(context, lev - 1, doc_obj, cbSuccess, cbError);
                        }, cbError);*/
                } else {
                    cbError('Невідомий тип підпису для перевірки sign_type = ' + item.sign_type);
                    return;
                }
            }
            // проверка внешней ЭЦП
            function VerifyExtSign(context, doc_obj, cbSuccess, cbError) {
                if (!doc_obj.needExtCheck() || !doc_obj.ext_ecp) {
                    cbSuccess(context);
                    return;
                }
                var item = doc_obj.ext_ecp;
                // перевіряємо підпис в залежності від типу
                if (item.sign_type == 'VEG') {
                    // перевіряємо чи ініціалізовано підпис
                    if (!context.SignVega1) {
                        cbError('Неможливо перевірити підпис, ЕЦП Вега1 не ініціалізована');
                        return;
                    }
                    // перевіряємо підпис
                    context.SignVega1.VerifySign(doc_obj.ext_ecp.buffer_hex, doc_obj.ext_ecp.keyid, doc_obj.ext_ecp.sign_hex, function () { cbSuccess(context); }, cbError);
                } else if (item.sign_type == 'VG2') {
                    // перевіряємо чи ініціалізовано підпис
                    if (_options.ModuleType !== item.sign_type) {
                        cbError('Неможливо перевірити підпис, ЕЦП Вега2 не ініціалізована');
                        return;
                    }
                    // перевіряємо підпис
                    var verifyInfo = {
                        Id: doc_obj.ref,
                        KeyId: item.key_id,
                        Buffer: item.buffer_hex,
                        Sign: item.sign_hex,
                        BufferType: 'ext',
                        ModuleName: 'vega2'
                    };
                    _verifySignatureService({ verifyInfo: verifyInfo },
                        function (response) {
                            if (response.d && response.d.Status !== 0) {
                                cbError(response.d.ErrorMessage);
                                return;
                            }
                            cbSuccess(context);
                        },
                        cbError);
                    //_currModule.verifySign(item.buffer_hex, item.key_id, item.sign_hex, function () { cbSuccess(context); }, cbError);
                } else {
                    cbError('Невідомий тип підпису для перевірки sgntype_code = ' + doc_obj.ext_ecp.sgntype_code);
                    return;
                }
            }
            // Накладення внутрішнього підпису
            function IntSign(context, doc_obj, cbSuccess, cbError) {
                if (!doc_obj.needIntSign()) {
                    cbSuccess(context, '');
                    return;
                }

                _currModule.signBuffer(doc_obj.int_buffer_hex, function (intSign) { cbSuccess(context, intSign); }, cbError);
            }
            // Накладення зовнішнього підпису
            function ExtSign(context, doc_obj, cbSuccess, cbError) {
                if (!doc_obj.needExtSign()) {
                    cbSuccess(context, '');
                    return;
                }

                _currModule.signBuffer(doc_obj.ext_buffer_hex, function (extSign) { cbSuccess(context, extSign); }, cbError);
            }

            // результат роботи функції
            var result = {
                intSign: '',
                extSign: ''
            }

            // Проверка предидущих внутренних ЭЦП
            VerifyIntSignRecursive(this, doc_obj.int_ecp.length, doc_obj,
                function (context) {
                    // проверка предыдущей внешней ЭЦП
                    VerifyExtSign(context, doc_obj,
                        function (context) {
                            // Накладення внутрішнього підпису
                            IntSign(context, doc_obj,
                                function (context, intSign) {
                                    result.intSign = intSign;
                                    // Накладення зовнішнього підпису
                                    ExtSign(context, doc_obj,
                                        function (context, extSign) {
                                            result.extSign = extSign;
                                            cbSuccess(result);
                                        },
                                        function (errorText, errorCode) {
                                            cbError('Помилки накладення зовнішньої ЕЦП: ' + errorText, errorCode);
                                        });
                                },
                                function (errorText, errorCode) {
                                    cbError('Помилки накладення внутрішньої ЕЦП: ' + errorText, errorCode);
                                });
                        },
                        function (errorText) {
                            cbError('Помилки перевірки зовнішньої ЕЦП: ' + errorText);
                        });
                },
                function (errorText) {
                    cbError('Помилки перевірки внутрішньої ЕЦП: ' + errorText);
                });
        }
    }
}());

// default options
barsCrypto.options = {
    ModuleType: barsCrypto.ModuleTypes.VEG, // default cryptolib
    RegionCode: '',                         // group code for VEGA
    BankDate: ''                            // bankdate 
};

// base constnts
barsCrypto.constants = {
    Version: "1.0.0.1",
    BarsCryptorHttpsUrl: "https://local.barscryptor.net:31139/",
    BarsCryptorHttpUrl: "http://127.0.0.1:31140/",
    // errors 
    ENotStarted: 100
};

// localization (todo - put each in separate files)
barsCrypto.resource = {
    lang: 'ua',
    errorSign: 'Помилки при накладенні ЕЦП',
    vega: {
        incorrectOptions: 'Не вказані обов`язкові параметри ініціалізації !',
        missingActiveX: 'Не знайдено програмного забезпечення для накладення ЕЦП (ActiveX). Зверніться до адміністратора.',
        missingComponents: 'Система безпеки не ініціалізована. Можливо не встановлені всі необхідні компоненти. Зверніться до адміністратора.'
    },
    vega2: {
        incorrectOptions: 'Не вказані обов`язкові параметри ініціалізації ключа',
        getKeysError: 'Помилка отримання ключів',
        vega2DeviceNotFound: 'Тип токена [{0}] не знайдено у списку доступних. Зверніться до адміністратора.',
        tokenInitError: 'Помилка ініціалізації токена',
        barsCryptorNotFound: 'Не запущено або не встановлено ПЗ BarsCryptor.',
        keyNotFound: 'Сертифікат з серійним номером [{0}] відсутній на пристрої.',
        keysMissing: 'Не знайдено пристрій (смарт-карту або токен).',
        alienCAKey: 'Сертифікат [{0}] видано іншим ЦСК, відмінним від дозволеного в системі.',
        keysReadError: 'Помилка отримання ключів'
    }
};

// объект Документ для підпису
function oSignDoc() {
    this.ref; // референс
    this.f_sign; // флаг необходимости наложениях подписи
    this.f_check; // флаг необходимости проверки предыдущей подписи
    this.int_buffer_hex; // буффер для внутренней подписи (HEX)
    this.int_ecp = []; // массив ранее наложеных внутренних подписей
    this.ext_buffer_hex; // буффер для внешней подписи (HEX)
    this.ext_ecp; // екземпляр ранее наложеной внешней подписи	
    /* Структура объекта подписи
		{
			id - идентификатор
			sgntype_code - тип подписи
			buffer_hex - буффер для проверки подписи
			keyid - ключ для проверки подписи
			sign_hex - подпись
		}
	*/

    // Проверяет нужна ли на текущем документе внутрення ЭЦП
    this.needIntSign = function () {
        return (1 == this.f_sign || 3 == this.f_sign);
    }
    // Проверяет нужна ли на текущем документе внешняя ЭЦП
    this.needExtSign = function () {
        return (2 == this.f_sign || 3 == this.f_sign);
    }
    // Проверяет нужна ли на текущем документе проверка внутренней ЭЦП
    this.needIntCheck = function () {
        return this.needIntSign && (1 == this.f_check || 3 == this.f_check);
    }
    // Проверяет нужна ли на текущем документе проверка внешней ЭЦП
    this.needExtCheck = function () {
        return this.needExtSign && (2 == this.f_check || 3 == this.f_check);
    }
}

// робота з підписом Вега1
barsCrypto.vega_module = function () {
    var module = {};                   // module object
    module.tag = "vega ActiveX";       // module tag for logging

    // ------ private variables --------
    var _isInitialized = false;
    var _activeXName = "BARSAX.RSAC";  // register ActiveX name
    var _aSigner; 					   // activeX object
    var _userKeyId;                    // user key identifier
    var _options;

    // ******** public methods ***************************************************
    module.initialize = function (options) {
        barsCrypto.debug("initialize", { "options": options, "constants": barsCrypto.constants });
        // check parameters
        if (!options.KeyId || !options.RegionCode || !options.BankDate) {
            alert(barsCrypto.resource.vega.incorrectOptions);
            return;
        }
        _userKeyId = options.KeyId;
        if (_userKeyId.length == 6) _userKeyId = options.RegionCode + options.KeyId;
        _options = options;
    }

    // init ActiveX
    function _initActiveX(cbSuccess, cbError) {
        barsCrypto.debug("_initActiveX.1", { "_isInitialized": _isInitialized });
        if (_isInitialized) {
            cbSuccess(this);
            return
        };
        try {
            var parentDocument = window.top;
            if (parent.frames.length != 0 && parent.frames["header"]) // find in barsweb iframes
                parentDocument = parent.frames["header"];
            else if (parent.parent.frames.length != 0 && parent.parent.frames["header"]) // if window is child 
                parentDocument = parent.parent.frames["header"];

            if (parentDocument.gActiveXObject) { // if find - reassign to local object
                _aSigner = parentDocument.gActiveXObject;
                barsCrypto.debug("_initActiveX.2, AX from parent", {});
            } else { // create new instance
                _aSigner = new ActiveXObject(_activeXName);
                parentDocument.gActiveXObject = _aSigner; // reassign to global object
                barsCrypto.debug("_initActiveX.2, create new AX", {});
            }
        }
        catch (e) {
            cbError(barsCrypto.resource.vega.missingActiveX);
            return;
        }
        if (!_aSigner.IsInitialized) _aSigner.Init('VEG');
        if (!_aSigner.IsInitialized) {
            cbError(barsCrypto.resource.vega.missingComponents);
            return;
        }
        _isInitialized = true;
        // need for SEP2
        _aSigner.BufferEncoding = "WIN";
        _aSigner.BankDate = _options.BankDate;
        _aSigner.IdOper = _userKeyId;
        // пишем в протокол REF документа
        if (_aSigner.GetMajorVersion == 1 && _aSigner.GetMinorVersion > 22 && _options.docRef)
            _aSigner.ProtData = _options.docRef;
        barsCrypto.debug("_initActiveX.3", { "MajorVersion": _aSigner.GetMajorVersion, "MinorVersion": _aSigner.GetMinorVersion });
        cbSuccess(this);
    }

    // Перевірка підпису
    module.verifySign = function (buffer_hex, keyid, sign_hex, cbSuccess, cbError) {
        barsCrypto.debug("verifySign.1 ", { "buffer_hex": buffer_hex, "keyid": keyid, "sign_hex": sign_hex });
        var cbSuccessFunc = function () {
            var errText = '';
            var res = _aSigner.SilentVerifySignatureHex(buffer_hex, sign_hex, keyid, errText);
            barsCrypto.debug("verifySign.2", { "res": res });
            if (res == '') {
                cbSuccess();
                return;
            }
            else {
                cbError(res);
                return;
            }
        };
        _initActiveX(cbSuccessFunc, cbError);
    }

    // put signature on buffer_hex
    module.signBuffer = function (buffer_hex, cbSuccess, cbError) {
        barsCrypto.debug("signBuffer.1", { "buffer_hex": buffer_hex });
        var cbSuccessFunc = function () {
            var sign = _aSigner.SignBufferHex(buffer_hex);
            barsCrypto.debug("signBuffer.2", { "sign": sign });
            if (0 == sign.length) {
                cbError(barsCrypto.resource.errorSign);
            }
            else {
                cbSuccess(sign);
            }
        };
        _initActiveX(cbSuccessFunc, cbError);
    }

    // export all public functions
    return module;
}

// робота з підписом Вега2
barsCrypto.vega2_module = function () {
    // URL вызова утилиты barscryptor
    var barscryptor_url = barsCrypto.constants.BarsCryptorHttpsUrl;
    if (location.protocol === "http:")
        barscryptor_url = barsCrypto.constants.BarsCryptorHttpUrl;

    // ------ глобальные параметры --------
    var module = {}; // внутренний объект модуля 
    module.tag = "vega2 BarsCryptor"; // module tag for logging
    var VG2TokenId = 'vega2';
    var _passCheckCa = false;
    var loadedKey = '';  // Ид. инициализированного ключа
    var _userKeyId;   // Key identifier
    var _userKeyHash; // Key hash 
    var _caKey; // CA key hash
    var _userCaKey; // current CA key hash

    // ******** private methods ***************************************************
    //region bc_* - BarsCryptor functions
    // service function for make request to BarsCryptor
    function bc_makeQuery(json, url, timeout, cbSuccess, cbError) {
        $.ajax({
            type: 'POST',
            url: url,
            crossDomain: true,
            headers: { 'Access-Control-Allow-Origin': 'x-requested-with', 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            data: json,
            dataType: 'json',
            timeout: (timeout ? timeout : 60000), // sets timeout limit to 60 seconds
            success: cbSuccess,
            error: cbError
        });
    };
    function bc_makeGetQuery(url, cbSuccess, cbError) {
        $.ajax({
            type: 'GET',
            url: url,
            success: cbSuccess,
            error: cbError
        });
    }

    // retrieve list of tokens (supptorted devices)
    function bc_getTokens(cbSuccess, cbError) {
        var url = barscryptor_url + 'tokens';
        bc_makeQuery('', url, 3000, cbSuccess, cbError);
    };
    // initialize single token (device)
    function bc_init(Token, cbSuccess, cbError) {
        var url = barscryptor_url + 'init';
        bc_makeQuery(JSON.stringify(Token), url, 10000, cbSuccess, cbError);
    };
    function bc_update(data, cbSuccess, cbError) {
        var url = barscryptor_url + 'update';
        bc_makeQuery(JSON.stringify(data), url, 10000, cbSuccess, cbError);
    };
    function bc_startie(data, cbSuccess, cbError) {
        var url = barscryptor_url + 'startie';
        bc_makeQuery(JSON.stringify(data), url, 10000, cbSuccess, cbError);
    };
    // retrive keys list from selected token (device)
    function bc_getKeys(Token, cbSuccess, cbError) {
        var url = barscryptor_url + 'keys';
        bc_makeQuery(JSON.stringify(Token), url, 50000, cbSuccess, cbError);
    };
    // call validate signature
    function bc_validate(obj, cbSuccess, cbError) {
        var url = barscryptor_url + 'validate';
        bc_makeQuery(JSON.stringify(obj), url, 10000, cbSuccess, cbError);
    };
    // call put signature
    function bc_sign(obj, cbSuccess, cbError) {
        var url = barscryptor_url + 'sign';
        bc_makeQuery(JSON.stringify(obj), url, 60000, cbSuccess, cbError);
    };

    // retrieve devices list from BarsCryptor and activate device with id - VG2TokenId
    function _initTokenList(cbSuccess, cbError) {
        var selectedToken;
        barsCrypto.debug("_initTokenList.1", {});
        bc_getTokens(
            // callback success
            function (response) {
                barsCrypto.debug("_initTokenList.2 bc_getTokens", { "response": response });
                // проверяем доступность токена vega2
                var VG2TokenIdCheck = false;
                for (var i = 0; i < response.Tokens.length; i++) {
                    var item = response.Tokens[i];
                    if (item.TokenId == VG2TokenId) {
                        selectedToken = item;
                        VG2TokenIdCheck = true;
                        break;
                    }
                }
                barsCrypto.debug("_initTokenList.2 selectedToken", { "selectedToken": selectedToken });
                if (!VG2TokenIdCheck) {
                    cbError(barsCrypto.resource.vega2.vega2DeviceNotFound.replace('{0}', VG2TokenId));
                    return;
                }
                // инициализируем токен
                bc_init(selectedToken,
                    function (response) {
                        barsCrypto.debug("_initTokenList.3 bc_init", { "response": response });
                        if (response.State == 'OK') {
                            cbSuccess(selectedToken);
                        }
                        else cbError(barsCrypto.resource.vega2.tokenInitError + ': ' + response.Error);
                    },
                    function (jqXHR, textStatus, errorThrown) {
                        cbError(barsCrypto.resource.vega2.tokenInitError);
                    });
            },
            // callback error
			function (jqXHR, textStatus, errorThrown) {
			    cbError(barsCrypto.resource.vega2.barsCryptorNotFound + '[' + JSON.stringify(errorThrown) + ']', barsCrypto.constants.ENotStarted);
			}
        );
    }

    // init key with id=_userKeyHash on selected device
    function _initKey(cbSuccess, cbError) {
        if (!_userKeyHash && !_userKeyId) {
            cbError(barsCrypto.resource.vega2.incorrectOptions);
            return;
        }
        // load once per session
        if (loadedKey && loadedKey == _userKeyHash) {
            cbSuccess(loadedKey);
            return;
        }
        _initTokenList(
            // callback success
            function (selectedToken) {
                barsCrypto.debug("_initKey.1", { "selectedToken": selectedToken });
                bc_getKeys(selectedToken,
                    // callback success
                    function (response) {
                        barsCrypto.debug("_initKey.2 bc_getKeys", { "response": response });
                        if (response.State === 'OK') {
                            var keyFound = false;
                            for (var i = 0; i < response.Keys.length; i++) {
                                if (_userKeyHash) // search by hash
                                {
                                    if (response.Keys[i].Id === _userKeyHash) {
                                        keyFound = true;
                                        break;
                                    }
                                }
                                else if (_userKeyId) // search by cert serial number, first in list !! 
                                {

                                    if (response.Keys[i].SubjectSN === _userKeyId) {
                                        // check CA 
                                        if (!_passCheckCa) {
                                            if (response.Keys[i].AuthorityKey != _caKey) {
                                                cbError(barsCrypto.resource.vega2.alienCAKey.replace('{0}', response.Keys[i].Name));
                                                return;
                                            }
                                        }
                                        keyFound = true;
                                        _userKeyHash = response.Keys[i].Id;
                                        _userCaKey = response.Keys[i].AuthorityKey;
                                        break;
                                    }
                                }
                            }
                            if (!keyFound) {
                                cbError(barsCrypto.resource.vega2.keyNotFound.replace('{0}', _userKeyHash || _userKeyId));
                                return;
                            }

                            // save last successfully load key
                            loadedKey = _userKeyHash;
                            barsCrypto.debug("_initKey.3", { "loadedKey": loadedKey });
                            cbSuccess(loadedKey);
                        }
                        else {
                            if (!response.Error) cbError(barsCrypto.resource.vega2.keysMissing);
                            else cbError(barsCrypto.resource.vega2.keysReadError + ': ' + response.Error);
                        }
                    },
                    // callback error
                    function () {
                        cbError(barsCrypto.resource.vega2.getKeysError);
                    });
            },
            // callback error
			cbError);
    }

    // ******** public methods ***************************************************
    module.getVersion = function (cbSuccess, cbError) {
        var url = barscryptor_url + 'version?_t' + (new Date()).getTime();
        bc_makeGetQuery(url, cbSuccess, cbError);
    }
    module.getModuleVersions = function (cbSuccess, cbError) {
        var url = barscryptor_url + 'versions?_t' + (new Date()).getTime();
        bc_makeGetQuery(url, cbSuccess, cbError);
    }
    module.getStatus = function () {
        var res = {};
        res.userKeyId = _userKeyId;
        res.userKeyHash = _userKeyHash;
        res.userCaKey = _userCaKey;
        return res;
    }
    module.getUpdate = function (data, cbSuccess, cbError) {
        bc_update(data, cbSuccess, cbError);
    }
    module.startIe = function (data, cbSuccess, cbError) {
        bc_startie(data, cbSuccess, cbError);
    }
    module.initialize = function (options) {
        barsCrypto.debug("initialize", { "options": options, "constants": barsCrypto.constants });
        _userKeyId = options.KeyId;
        _userKeyHash = options.KeyHash;
        _caKey = options.CaKey;
        _passCheckCa = options.PassCheckCa;
    }

    // check signature
    module.verifySign = function (buffer_hex, keyid, sign_hex, cbSuccess, cbError) {
        barsCrypto.debug("verifySign.1", { "buffer_hex": buffer_hex, "keyid": keyid, "sign_hex": sign_hex });
        var cbSuccessFunc = function (VG2Token) {
            var inData = {
                Buffer: buffer_hex,
                Sign: sign_hex,
                TokenId: VG2TokenId,
                Encoding: "UTF8"
            }
            bc_validate(inData,
                function (response) {
                    if (response.State == 'OK') cbSuccess();
                    else cbError('Помилка перевірки підпису: ' + response.Error);
                },
                cbError);
        };
        _initTokenList(cbSuccessFunc, cbError);
    }

    // put signature on buffer_hex
    module.signBuffer = function (buffer_hex, cbSuccess, cbError) {
        barsCrypto.debug("signBuffer.1", { "buffer_hex": buffer_hex });
        var cbSuccessFunc = function (selectedKeyId) {
            // data for signature
            var inData = {
                IdOper: selectedKeyId,
                TokenId: VG2TokenId,
                Buffer: buffer_hex,
                Encoding: 'UTF8'
            }
            // call sign
            bc_sign(inData,
                function (response) {
                    barsCrypto.debug("signBuffer.2", { "inData": inData, "response": response });
                    if (response.State == 'OK') cbSuccess(response.Sign);
                    else {
                        if (response.Error === "Ошибка при получении контекста провайдера") {
                            var updateServer = "http://10.7.98.10/BarsCryptorUpdate";
                            //updateServer = "http://10.10.10.96:10601/BarsCryptorUpdate";
                            alert("Втрачено зв'язок з драйвером присторою, перевірте пристрій та спробуйте повторити операцію.");
                            bc_update({ UpdateServer: updateServer }, function () { }, function () {  });
                            return;
                        }
                        cbError(barsCrypto.resource.errorSign + ': ' + response.Error)
                    };
                },
                cbError);
        };
        _initKey(cbSuccessFunc, cbError);
    }

    // export all public functions
    return module;
}

// класс-интерфейс для работы с подписью 
function oSign() {
    // ------ Инициализация объекта --------
    this.initVEG = function (DOCKEY, REGNCODE, BDATE) {
        this.SignVega1 = new oSignVega1(DOCKEY, REGNCODE, BDATE);
    }
    this.initVG2 = function (DOCKEY) {
        this.SignVega2 = oSignVega2(DOCKEY);
    }

    // --------- параметры подписи -------------
    this.SignVega1; // обьект для роботи з Вега1
    this.SignVega2; // обьект для роботи з Вега2

    this.SGNTypeCode = function () {
        if (this.SignVega2) {
            return 'VG2';
        } else if (this.SignVega1) {
            return 'VEG';
        } else {
            alert('ЕЦП не ініціалізована');
        }
    }
    this.DOCKEY = function () {
        switch (this.SGNTypeCode()) {
            case 'VEG':
                return this.SignVega1.DOCKEY;
            case 'VG2':
                return this.SignVega2.GetUserKeyId();
        }
    }

    // Перевірка підпису
    this.VerifySign = function (buffer_hex, keyid, sign_hex, cbSuccess, cbError) {
        if (this.SignVega2) {
            this.SignVega2.VerifySign(buffer_hex, keyid, sign_hex, cbSuccess, cbError);
        } else if (this.SignVega1) {
            this.SignVega1.VerifySign(buffer_hex, keyid, sign_hex, cbSuccess, cbError);
        } else {
            cbError('ЕЦП не ініціалізована');
        }
    }

    // Накладення підпису
    this.Sign = function (buffer_hex, cbSuccess, cbError) {
        if (this.SignVega2) {
            this.SignVega2.Sign(buffer_hex, cbSuccess, cbError);
        } else if (this.SignVega1) {
            this.SignVega1.Sign(buffer_hex, cbSuccess, cbError);
        } else {
            cbError('ЕЦП не ініціалізована');
        }
    }

    // Обработка документа
    this.processDoc = function (doc_obj, cbSuccess, cbError) {
        // асинхронный цикл проверки всех внутр ЭЦП
        function VerifyIntSignRecursive(context, lev, doc_obj, cbSuccess, cbError) {
            // проверка не нужна или дошли до дна рекурсии
            if (!doc_obj.needIntCheck() || lev == 0) {
                cbSuccess(context);
                return;
            }

            // беремо елемент з внутрішнім підписом
            var item = doc_obj.int_ecp[lev - 1];

            // перевіряємо підпис в залежності від типу
            if (item.sgntype_code == 'VEG') {
                // перевіряємо чи ініціалізовано підпис
                if (!context.SignVega1) {
                    cbError('Неможливо перевірити підпис, ЕЦП Вега1 не ініціалізована');
                    return;
                }
                // перевіряємо підпис
                context.SignVega1.VerifySign(item.buffer_hex, item.keyid, item.sign_hex, function () {
                    VerifyIntSignRecursive(context, lev - 1, doc_obj, cbSuccess, cbError);
                }, cbError);
            } else if (item.sgntype_code == 'VG2') {
                // перевіряємо чи ініціалізовано підпис
                if (!context.SignVega2) {
                    cbError('Неможливо перевірити підпис, ЕЦП Вега2 не ініціалізована');
                    return;
                }
                // перевіряємо підпис
                context.SignVega2.VerifySign(item.buffer_hex, item.keyid, item.sign_hex, function () {
                    VerifyIntSignRecursive(context, lev - 1, doc_obj, cbSuccess, cbError);
                }, cbError);
            } else {
                cbError('Невідомий тип підпису для перевірки sgntype_code = ' + item.sgntype_code);
                return;
            }
        }
        // проверка внешней ЭЦП
        function VerifyExtSign(context, doc_obj, cbSuccess, cbError) {
            if (!doc_obj.needExtCheck() || !doc_obj.ext_ecp) {
                cbSuccess(context);
                return;
            }

            // перевіряємо підпис в залежності від типу
            if (doc_obj.ext_ecp.sgntype_code == 'VEG') {
                // перевіряємо чи ініціалізовано підпис
                if (!context.SignVega1) {
                    cbError('Неможливо перевірити підпис, ЕЦП Вега1 не ініціалізована');
                    return;
                }
                // перевіряємо підпис
                context.SignVega1.VerifySign(doc_obj.ext_ecp.buffer_hex, doc_obj.ext_ecp.keyid, doc_obj.ext_ecp.sign_hex, function () { cbSuccess(context); }, cbError);
            } else if (doc_obj.ext_ecp.sgntype_code == 'VG2') {
                // перевіряємо чи ініціалізовано підпис
                if (!context.SignVega2) {
                    cbError('Неможливо перевірити підпис, ЕЦП Вега2 не ініціалізована');
                    return;
                }
                // перевіряємо підпис
                context.SignVega2.VerifySign(doc_obj.ext_ecp.buffer_hex, doc_obj.ext_ecp.keyid, doc_obj.ext_ecp.sign_hex, function () { cbSuccess(context); }, cbError);
            } else {
                cbError('Невідомий тип підпису для перевірки sgntype_code = ' + doc_obj.ext_ecp.sgntype_code);
                return;
            }
        }
        // Накладення внутрішнього підпису
        function IntSign(context, doc_obj, cbSuccess, cbError) {
            if (!doc_obj.needIntSign()) {
                cbSuccess(context, '');
                return;
            }

            context.Sign(doc_obj.int_buffer_hex, function (intSign) { cbSuccess(context, intSign); }, cbError);
        }
        // Накладення зовнішнього підпису
        function ExtSign(context, doc_obj, cbSuccess, cbError) {
            if (!doc_obj.needExtSign()) {
                cbSuccess(context, '');
                return;
            }

            context.Sign(doc_obj.ext_buffer_hex, function (extSign) { cbSuccess(context, extSign); }, cbError);
        }

        // результат роботи функції
        var result = {
            intSign: '',
            extSign: ''
        }

        // Проверка предидущих внутренних ЭЦП
        VerifyIntSignRecursive(this, doc_obj.int_ecp.length, doc_obj,
            function (context) {
                // проверка предыдущей внешней ЭЦП
                VerifyExtSign(context, doc_obj,
                    function (context) {
                        // Накладення внутрішнього підпису
                        IntSign(context, doc_obj, function (context, intSign) {
                            result.intSign = intSign;
                            // Накладення зовнішнього підпису
                            ExtSign(context, doc_obj, function (context, extSign) {
                                result.extSign = extSign;
                                cbSuccess(result);
                            },
                                            function (errorText) {
                                                cbError('Помилки накладення зовнішньої ЕЦП: ' + errorText);
                                            });
                        },
                                        function (errorText) {
                                            cbError('Помилки накладення внутрішньої ЕЦП: ' + errorText);
                                        });
                    },
                    function (errorText) {
                        cbError('Помилки перевірки зовнішньої ЕЦП: ' + errorText);
                    });
            },
			function (errorText) {
			    cbError('Помилки перевірки внутрішньої ЕЦП: ' + errorText);
			});
    }
}




