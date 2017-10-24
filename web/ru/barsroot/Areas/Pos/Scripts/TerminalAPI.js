/**
 * Created by serhii.karchavets on 12.10.2016.
 */


/*
 Скрипт по интеграции АБС и POS-терминала для идентификации клиента по БПК
 */

var g_text = "";
var STATE_READ_DATA = 1;
var STATE_SETTLEMENT = 2;
var PRINT_BATCH_TOTALS = 3;
var g_STATE = STATE_READ_DATA;

var IS_DEBUG = false;
function print(o) { if(IS_DEBUG){ console.log(o); } }

var KV = 980;       // todo: add all

// установка и получение cookie
function getCookie(c_name) {
    var c_value = document.cookie;
    var c_start = c_value.indexOf(" " + c_name + "=");
    if (c_start == -1) {
        c_start = c_value.indexOf(c_name + "=");
    }
    if (c_start == -1) {
        c_value = null;
    }
    else {
        c_start = c_value.indexOf("=", c_start) + 1;
        var c_end = c_value.indexOf(";", c_start);
        if (c_end == -1) {
            c_end = c_value.length;
        }
        c_value = unescape(c_value.substring(c_start, c_end));
    }
    return c_value;
}
function setCookie(c_name, value, exdays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
    document.cookie = c_name + "=" + c_value;
}

// текущий тип POS-терминала и порт
var _POSType;
function Set_POSType(POSType) {
    _POSType = POSType;
    setCookie('POSType', POSType, 365);
}
function Get_POSType() {
    if (!_POSType)
        _POSType = getCookie('POSType');

    return _POSType;
}

var _Port;
function Set_Port(Port) {
    _Port = Port;
    setCookie('Port', Port, 365);
}
function Get_Port() {
    if (!_Port)
        _Port = getCookie('Port');

    return _Port;
}

var hResultClientID;

function Complete() {
    g_STATE = STATE_READ_DATA;
    bars.ui.notify('Термінал', g_text, 'success', { autoHideAfter: 5*1000});
    g_text = "";
}

function Settlement(text) {
    Waiting(true);
    g_text = text;      // final message
    g_STATE = STATE_SETTLEMENT;
    IdentClient();
}

function PrintBatchTotals() {
    Waiting(true);
    g_STATE = PRINT_BATCH_TOTALS;
    IdentClient();
}

// идентификация клиента
function IdentClient() {
    // смотрим выбран ли тип POS-терминала и порт
    if (!Get_POSType() || !Get_Port()) {
        on_error(1, 'Не вибрано тип POS-терміналу та/або порт');
        if(IS_DEBUG){console.error("Не вибрано тип POS-терміналу та/або порт");}
        Waiting(false);
        return;
    }

    // проводим идентификацию в зависимостри от типа поса
    switch (Get_POSType()) {
        case 'INPAS':
            IdentClientINPAS(on_success, on_error, on_message);
            break;
        case 'SSI':
            IdentClientSSI(on_success, on_error, on_message);
            break;
        case 'INGENICO':
            IdentClientIngenico(on_success, on_error, on_message);
            break;
    }
}
// остановка идентификации клиента
function StopIdentClient() {
    // проводим идентификацию в зависимостри от типа поса
    switch (Get_POSType()) {
        case 'INPAS':
            StopIdentClientINPAS();
            break;
        case 'SSI':
            StopIdentClientSSI();
            break;
        case 'INGENICO':
            StopIdentClientIngenico();
            break;
    }
}

// идентификация клиента InPas
var objPosInpas;
function IdentClientINPAS(on_success_handler, on_error_handler, on_message_handler) {
    // создаем наш объект
    objPosInpas = new POS_INPAS(Get_Port());

    if(IS_DEBUG){console.log("object created INPAS! "+objPosInpas);}

    // хендлер для запуска получения результата в случае успешной авторизации
    var OnSuccessAuthHandler = function () {
        on_message_handler('message', 'Отримання результату ідентифікації...');

        objPosInpas.GetBatchTotals(
            function (msg) {
                on_message('success', msg);
            }, function (msg) {
                on_message('error', msg);
            }, function (msg) {
                on_message('info', msg);
            });
    };
    // хендлер для запуска авторизации операции в случае успешной инициализации
    var OnSuccessInitHandler = function () {
        on_message_handler('message', 'Зчитування данних...');
        objPosInpas.Auth(OnSuccessAuthHandler, on_error_handler)
    };
    // хендлер для запуска инициализации операции в случае успешного создания
    var OnSuccessCreateAndConfigureHandler = function () {
        on_message_handler('message', 'З`єднання з POS-терміналом...');
        objPosInpas.Init(OnSuccessAuthHandler, on_error_handler)
    };

    // выполняем идентификацию
    on_message_handler('message', 'Ідентифікацію розпочато...');
    objPosInpas.CreateAndConfigure(OnSuccessCreateAndConfigureHandler, on_error_handler);
}
function StopIdentClientINPAS() {
    // принудительно останавливаем работу
    objPosInpas.Stop();
}

// идентификация клиента SSI
var objPosSSI;
function IdentClientSSI(on_success_handler, on_error_handler, on_message_handler) {
    // создаем наш объект
    objPosSSI = new POS_SSI(Get_Port());

    if(IS_DEBUG){console.log("object created SSI! "+objPosSSI);}

    // хендлер для запуска получения результата в случае успешного открытия порта
    var OnSuccessOpenPortHandler = function () {
        on_message_handler('message', 'Зчитування данних...');

        switch (g_STATE){
            case STATE_SETTLEMENT:
                objPosSSI.Settlement(function (msg) {
                    on_message('success', msg);
                }, function (msg) {
                    on_message('error', msg);
                }, function (msg) {
                    on_message('info', msg);
                });
                break;
            case PRINT_BATCH_TOTALS:
                throw new Error("Недозволено для цього терміналу!");
                break;
            default:
                objPosSSI.GetBatchTotals(function (msg) {
                    on_message('success', msg);
                }, function (msg) {
                    on_message('error', msg);
                }, function (msg) {
                    on_message('info', msg);
                });
                break;
        }

    };

    // хендлер для запуска инициализации операции в случае успешного создания
    var OnSuccessCreateAndConfigureHandler = function () {
        on_message_handler('message', 'З`єднання з POS-терміналом...');
        var TimeoutID = setTimeout(function () { objPosSSI.OpenPort(OnSuccessOpenPortHandler, on_error_handler); }, 500);
    };

    // выполняем идентификацию
    on_message_handler('message', 'Ідентифікацію розпочато...');
    var TimeoutID = setTimeout(function () { objPosSSI.CreateAndConfigure(OnSuccessCreateAndConfigureHandler, on_error_handler); }, 500);
}
function StopIdentClientSSI() {
    // принудительно останавливаем работу
    //objPosSSI.Stop();
}


// идентификация клиента Ingenico
var objPosIngenico;
function IdentClientIngenico(on_success_handler, on_error_handler, on_message_handler) {
    // создаем наш объект
    objPosIngenico = new POS_INGENICO(Get_Port());

    if(IS_DEBUG){console.log("object created INGENICO! "+objPosIngenico);}

    // хендлер для запуска получения результата в случае успешного открытия порта
    var OnSuccessOpenPortHandler = function() {
        on_message_handler('message', 'Зчитування данних...');

        switch (g_STATE){
            case STATE_SETTLEMENT:
                setTimeout(function() {
                    objPosIngenico.Settlement(function (msg) {
                        on_message('success', msg);
                    }, function (msg) {
                        on_message('error', msg);
                    }, function (msg) {
                        on_message('info', msg);
                    });
                }, 500);
                break;
            case PRINT_BATCH_TOTALS:
                setTimeout(function() {
                    objPosIngenico.PrintBatchTotals(function (msg) {
                        on_message('success', msg);
                    }, function (msg) {
                        on_message('error', msg);
                    }, function (msg) {
                        on_message('info', msg);
                    });
                }, 500);
                break;
            default:
                setTimeout(function() {
                    objPosIngenico.GetBatchTotals(function (msg) {
                        on_message('success', msg);
                    }, function (msg) {
                        on_message('error', msg);
                    }, function (msg) {
                        on_message('info', msg);
                    });
                }, 500);
                break;
        }
    };
    // хендлер для запуска инициализации операции в случае успешного создания
    var OnSuccessCreateAndConfigureHandler = function() {
        on_message_handler('message', 'З`єднання з POS-терміналом...');
        setTimeout(function() {
            objPosIngenico.OpenPort(OnSuccessOpenPortHandler, on_error_handler);
        }, 500);
    };

    // выполняем идентификацию
    on_message_handler('message', 'Ідентифікацію розпочато...');
    setTimeout(function() {
        objPosIngenico.CreateAndConfigure(OnSuccessCreateAndConfigureHandler, on_error_handler);
    }, 500);
}

function StopIdentClientIngenico() {
    // принудительно останавливаем работу
    objPosIngenico.Stop();
}

// обработчик успешного результата
function on_success(MFO, RNK, FIO) {
    // отображаем найденные данные
    on_message('success', 'Клієнта ідентифіковано: ' + FIO + '(РНК=' + RNK + ')');

    // сохраняем для передачи на сервер
    $('#' + hResultClientID).val(MFO.toString() + ';' + RNK.toString());

    // показываем кнопки действий
    $('#trButtons').show();
}
function on_success_service(arg) {
    // обрабатываем прикладные ошибки
    switch (arg.ErrorCode) {
        case 0: // все ок
            on_success(arg.MFO, arg.RNK, arg.FIO);
            break;
        case 1: // Клієнт зареєстрований у іншому МФО
            on_error(6, 'Помилка перевірки клієнта у БД: ' + arg.ErrorText);
            break;
        case 2: // Клієнта РНК={0} не знайдено, або його картку закрыто
            on_error(6, 'Помилка перевірки клієнта у БД: ' + arg.ErrorText);
            break;
    }
}

// обработчик ошибки
function on_error(err_code, err_text) {
    // действия в зависимотси от кода ошибки
    switch (err_code) {
        case 1:
            if(IS_DEBUG){console.log("on_error - не вибран тип POS-терминала и/или порт");}
            on_message('error', "не вибран тип POS-терминала и/или порт");
            Waiting(false);
            break;
        case 2: // ошибка инициализации ActiveX
        case 3: // Помилка встановлення звя`зку з POS-терміналом
        case 4: // Помилка авторизації операції
        case 5: // Помилка отримання результату операції
        case 6: // Помилка перевірки клієнта у БД
        case 7: // Помилка відкриття COM-порту
        case 8: // Помилка ідентифікації клієнта
        case 9: // Помилка закриття COM-порту
            on_message('error', err_text);
            break;
        default:
            break;
    }
}
function on_error_service(arg) {
    on_error(6, 'Помилка перевірки клієнта: ' + arg.get_message());
}

// выдача сообщения
function on_message(type, text) {
    switch (type) {
        case 'error':
            if(IS_DEBUG){console.error("type" + type + " text="+ text);}
            bars.ui.error({ title: 'Термінал', text: text });
            break;
        case 'success':
            if(IS_DEBUG){console.log("type" + type + " text="+ text);}
            bars.ui.notify('Термінал', text, 'success', { autoHideAfter: 4*1000});
            break;
        case 'message':
            if(IS_DEBUG){console.info("type" + type + " text="+ text);}
            bars.ui.notify("Термінал", text, "info", {autoHideAfter: 2*1000});
            break;
    }
}
