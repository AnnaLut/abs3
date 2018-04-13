/*
    Скрипт по интеграции АБС и POS-терминала для идентификации клиента по БПК
*/

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

// инициализация страницы
$(function () {
    $('#dialogSelectDevice').dialog({
        autoOpen: false,
        width: 350,
        height: 200,
        modal: true,
        buttons: {
            "Ok": function () {
                Set_POSType($('#deviceTypes').val());
                Set_Port($('#COMPort').val());
                $(this).dialog("close");

                // продолжаем идентификацию
                IdentClient();
            }
        },
        close: function () {
            if (!Get_POSType()) alert('Тип POS-терміналу не вибрано!');
            if (!Get_Port()) alert('COM-порт не вибрано!');
        }
    });

    $('#dialogMessages').dialog({
        autoOpen: false,
        width: 350,
        height: 250,
        modal: true,
        close: function () {
            // принудительная остановка
            StopIdentClient();
        }
    });
    $('#dialogMessages').parent().appendTo($("form:first"));

    $('#trButtons').hide();
});

// вибор типа POS-терминала и порта
function OpenSelectDialog() {
    $('#dialogSelectDevice').dialog('open');
}

// отображение диалога сообщений
function ShowMessages() {
    $('#dialogMessages').dialog('open');
}
// спрятать диалог сообщений
function HideMessages() {
    $('#dialogMessages').dialog('close');
}

// идентификация клиента
function IdentClient() {
    // смотрим выбран ли тип POS-терминала и порт
    if (!Get_POSType() || !Get_Port()) {
        on_error(1, 'Не вибрано тип POS-терміналу та/або порт');
        return;
    }

    // прячем контролы и удаляем предидущие результаты
    $('#trButtons').hide();
    $('#' + hResultClientID).val('');

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

    // хендлер для проверки клиента в случае успешного получения результата
    var OnSuccessGetResultHandler = function (code_ru, rnk) {
        on_message_handler('message', 'Перевірка клієнта у БД...');
        Bars.UserControls.WebServices.BPKIdentification.CheckClient(code_ru, rnk, on_success_service, on_error_service);
    };
    // хендлер для запуска получения результата в случае успешной авторизации
    var OnSuccessAuthHandler = function () { on_message_handler('message', 'Отримання результату ідентифікації...'); objPosInpas.GetResult(OnSuccessGetResultHandler, on_error_handler) };
    // хендлер для запуска авторизации операции в случае успешной инициализации
    var OnSuccessInitHandler = function () { on_message_handler('message', 'Запит картки та ПІН-коду...'); objPosInpas.Auth(OnSuccessAuthHandler, on_error_handler) };
    // хендлер для запуска инициализации операции в случае успешного создания
    var OnSuccessCreateAndConfigureHandler = function () { on_message_handler('message', 'З`єднання з POS-терміналом...'); objPosInpas.Init(OnSuccessInitHandler, on_error_handler) };

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

    // хендлер для проверки клиента в случае успешного получения результата
    var OnSuccessGetResultHandler = function (code_ru, rnk) {
        // закрываем порт
        objPosSSI.ClosePort();

        on_message_handler('message', 'Перевірка клієнта у БД...');
        Bars.UserControls.WebServices.BPKIdentification.CheckClient(code_ru, rnk, on_success_service, on_error_service);
    };
    // хендлер для запуска получения результата в случае успешного открытия порта
    var OnSuccessOpenPortHandler = function () { on_message_handler('message', 'Запит картки та ПІН-коду...'); var TimeoutID = setTimeout(function () { objPosSSI.GetResult(OnSuccessGetResultHandler, on_error_handler); }, 500); };
    // хендлер для запуска инициализации операции в случае успешного создания
    var OnSuccessCreateAndConfigureHandler = function () { on_message_handler('message', 'З`єднання з POS-терміналом...'); var TimeoutID = setTimeout(function () { objPosSSI.OpenPort(OnSuccessOpenPortHandler, on_error_handler); }, 500); };

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

    // хендлер для проверки клиента в случае успешного получения результата
    var OnSuccessGetResultHandler = function (code_ru, rnk) {
        // закрываем порт
        objPosIngenico.ClosePort();

        on_message_handler('message', 'Перевірка клієнта у БД...');
        Bars.UserControls.WebServices.BPKIdentification.CheckClient(code_ru, rnk, on_success_service, on_error_service);
    };
    // хендлер для запуска получения результата в случае успешного открытия порта
    var OnSuccessOpenPortHandler = function() {
        on_message_handler('message', 'Запит картки та ПІН-коду...');
        setTimeout(function() {
            objPosIngenico.GetResult(OnSuccessGetResultHandler, on_error_handler);
        }, 500);
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
            // не вибран тип POS-терминала и/или порт
            OpenSelectDialog();
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
    // показываем диалог
    ShowMessages();

    // цвет текста от типа сообщения
    var Color = 'black';
    var ImgUrl = '/Common/Images/default/48/warning.png';

    switch (type) {
        case 'error':
            Color = 'red';
            ImgUrl = '/Common/Images/default/48/stop.png';
            break;
        case 'success':
            Color = 'green';
            ImgUrl = '/Common/Images/default/48/check.png';
            break;
        case 'message':
            Color = 'black';
            ImgUrl = '/Common/Images/default/48/warning.png';
            break;
    }

    $('#lbMessages').css('color', Color);
    $('#imgMessage').attr('src', ImgUrl);

    // текст
    $('#lbMessages').text(text);
}

// Взаимодействие с терминалом InPas
function POS_INPAS(Port) {
    // приватные перечни
    var _Enum_Init_Errors = {
        '-2000': 'ERR_RS232_BASE',
        '-2001': 'ERR_RS232_OPENPORT',
        '-2002': 'ERR_RS232_SETPARAM',
        '-2003': 'ERR_RS232_SETTIMEOUTS',
        '-2004': 'ERR_RS232_RESET',
        '-2005': 'ERR_RS232_WRONGCALL',
        '-2006': 'ERR_RS232_WRITE',
        '-2007': 'ERR_RS232_READ',
        '-2008': 'ERR_RS232_SETSIGNAL',
        '-2009': 'ERR_RS232_CHECKLINE',
        '-2010': 'ERR_RS232_GETPARAM',
        '-2011': 'ERR_RS232_GETTIMEOUTS',
        '1': 'ERR_RS232_UNHANDLED_EXCEPTION',
        '0': 'NO_ERROR'
    };

    var _Enum_GetState_Errors = {
        '-3': 'STATE_STOP_EOT - выполнение операции приостановлено на момент получения ответа от хоста, терминал прислал на кассу EOT',
        '-2': 'STATE_STOP - выполнение приостановлено, операция не может быть выполнена в данное время',
        '-1': 'STATE_NOTREADY - COM-объект не готов к выполнению операции',
        '0': 'STATE_IDLE - COM-объект находится в состоянии ожидания, готов к началу выполнения операции',
        '1': 'STATE_DC4_PREAUTH - состояние выполнения операции',
        '2': 'STATE_PREAUTH - состояние выполнения операции',
        '3': 'STATE_AUTH - проводится обмен с ПЦ',
        '4': 'STATE_COMPLETE - COM-объект находится в состоянии «операция завершена», можно прочитать полученные значения тегов',
        '5': 'STATE_SESSION_NUMBER - COM-объект находится в состоянии «номер сессии получен» и номер сессии можно прочитать 1С'
    };

    var _Enum_GetResult_Errors = {
        '0': 'STATUS_BUSY - операция выполняется',
        '1': 'STATUS_HOSTERROR - ошибка выполнения операции',
        '2': 'STATUS_HOSTDECLINE - хост авторизации отклонил выполнения операции',
        '3': 'STATUS_HOSTAPPROVE - хост авторизации одобрил выполнения операции'
    };

    // ---- приватные константы
    var _const_inpas_loging = 0,
        _const_inpas_timer2 = 5000,
        _const_inpas_timer3 = 120000, // тайм-аут выполнения действий Init и тп
        _const_inpas_mode = 1;

    // ---- публичные константы
    this.ActiveX_Name = 'KKM.PosKKM';
    this.Name = 'INPAS';
    this.OperTag = 'OPER';
    this.OperValue = 'B';

    // ---- приватные свойства
    var _ActiveX_Object;
    var _Port;

    var _TimerInterval = 1000;
    var _TimerLag = 1000;

    var _IsStoped = false;

    // ---- конструктор
    __POS_INPAS = function POS_INPAS(that, Port) {
        _Port = Port;
    }(this, Port)

    // ---- приватные методы    

    // ---- публичные методы
    // создание и конфигурация ActiveX
    this.CreateAndConfigure = function (on_success_handler, on_error_handler) {
        try {
            this.ActiveX_Object = new ActiveXObject(this.ActiveX_Name);
            this.ActiveX_Object.Configure(_Port, _const_inpas_loging, _const_inpas_timer2, _const_inpas_timer3);

            on_success_handler();
        }
        catch (e) {
            on_error_handler(2, 'Помилка створення/конфігурації ActiveX (' + objPosInpas.ActiveX_Name + '): ' + e.message);
            return;
        }
    }
    // инициализация связи с POS
    this.Init = function (on_success_handler, on_error_handler) {
        try {
            // если остановили насильно, то выходим
            if (_IsStoped) return;

            // ставим тайм-аут ActiveX 
            this.ActiveX_Object.SetGuardTimer(_const_inpas_timer3);

            // запрос на инициализацию и обработка его результата
            var res = this.ActiveX_Object.Init();
            if (res != 0) {
                this.Stop();
                on_error_handler(3, 'Помилка встановлення звя`зку з POS-терміналом: ' + _Enum_Init_Errors[res.toString()]);
                return;
            }

            // ожидание результата выполнения операции (рекурсивно)
            this.InitRecursive(on_success_handler, on_error_handler, 0);
        }
        catch (e) {
            on_error_handler(3, 'Помилка встановлення звя`зку з POS-терміналом: ' + e.message);
            return;
        }
    }
    // инициализация связи с POS (рекурсивно)
    this.InitRecursive = function (on_success_handler, on_error_handler, timer) {
        try {
            // если остановили насильно, то выходим
            if (_IsStoped) return;

            // получение статуса выполнения и его обработка
            var res = this.ActiveX_Object.GetState();

            // успешное выполнение
            if (res == 0) {
                on_success_handler();
                return;
            }

            // ошибки выполнения
            if (res == -2 || res == -3) {
                this.Stop();
                on_error_handler(3, 'Помилка встановлення звя`зку з POS-терміналом: ' + _Enum_GetState_Errors[res.toString()]);
                return;
            }

            // проверяем наш тайм-аут
            if (timer > _const_inpas_timer3 + _TimerLag) {
                this.Stop();
                on_error_handler(3, 'Помилка встановлення звя`зку з POS-терміналом: перевищено інтервал очікування відповіді.');
                return;
            }

            // запускаем процедуру рекурсивно
            var _this = this;
            var TimeoutID = setTimeout(function () { _this.InitRecursive(on_success_handler, on_error_handler, timer + _TimerInterval) }, _TimerInterval);
        }
        catch (e) {
            on_error_handler(3, 'Помилка встановлення звя`зку з POS-терміналом: ' + e.message);
            return;
        }
    }
    // авторизация операции полученя баланса
    this.Auth = function (on_success_handler, on_error_handler) {
        try {
            // если остановили насильно, то выходим
            if (_IsStoped) return;

            // сброс текущей операции
            this.ActiveX_Object.ResetOperData();

            // установка операции получения баланса по карте
            this.ActiveX_Object.SetValue(this.OperTag, this.OperValue);

            // ставим тайм-аут ActiveX 
            this.ActiveX_Object.SetGuardTimer(_const_inpas_timer3);

            // запрос на инициализацию и обработка его результата
            var res = this.ActiveX_Object.Auth();
            if (res != 0) {
                this.Stop();
                on_error_handler(4, 'Помилка авторизації операції (' + this.OperValue + '): код помилки = ' + res.toString()); // !!! нет перечня ошибок операции Auth
                return;
            }

            // ожидание результата выполнения операции (рекурсивно)
            this.AuthRecursive(on_success_handler, on_error_handler, 0);
        }
        catch (e) {
            on_error_handler(4, 'Помилка авторизації операції: ' + e.message);
            return;
        }
    }
    // авторизация операции (рекурсивно)
    this.AuthRecursive = function (on_success_handler, on_error_handler, timer) {
        try {
            // если остановили насильно, то выходим
            if (_IsStoped) return;

            // получение статуса выполнения и его обработка
            var res = this.ActiveX_Object.GetState();

            // успешное выполнение
            if (res == 4) {
                on_success_handler();
                return;
            }

            // ошибки выполнения
            if (res == 0 || res == -1 || res == -2 || res == -3) {
                this.Stop();
                on_error_handler(4, 'Помилка авторизації операції (' + this.OperValue + '): ' + _Enum_GetState_Errors[res.toString()]);
                return;
            }

            // проверяем наш тайм-аут
            if (timer > _const_inpas_timer3 + _TimerLag) {
                this.Stop();
                on_error_handler(4, 'Помилка авторизації операції (' + this.OperValue + '): перевищено інтервал очікування відповіді.');
                return;
            }

            // запускаем процедуру рекурсивно
            var _this = this;
            var TimeoutID = setTimeout(function () { _this.AuthRecursive(on_success_handler, on_error_handler, timer + _TimerInterval) }, _TimerInterval);
        }
        catch (e) {
            on_error_handler(4, 'Помилка авторизації операції: ' + e.message);
            return;
        }
    }
    // получение результата операции идентификации
    this.GetResult = function (on_success_handler, on_error_handler) {
        try {
            // если остановили насильно, то выходим
            if (_IsStoped) return;

            // получение результата операции "баланс"
            var res = this.ActiveX_Object.GetResult();

            // разбор полученных параметров
            if (res == 3) {
                var PAN = this.ActiveX_Object.GetValue('PAN');
                var CardHolder = this.ActiveX_Object.GetValue('CardHolder');
                var CARD_NAME = this.ActiveX_Object.GetValue('CARD_NAME');
                var AMOUNT = this.ActiveX_Object.GetValue('AMOUNT');
                var CHEQUE_NO = this.ActiveX_Object.GetValue('CHEQUE_NO');

                // В параметре CHID приходит составной ключ код РУ и РНК клиента - это то что нужно АБС
                var CHID = this.ActiveX_Object.GetValue('CHID');
				
                // передаем код РУ и РНК
                var code_ru = CHID.substring(0, 4);
                var rnk = parseInt(CHID.substring(4), 10);
                on_success_handler(code_ru, rnk);
            }
            else {
                on_error_handler(5, 'Помилка отримання результату операції: ' + _Enum_GetResult_Errors[res.toString()]);
            }

            // закрываем соединение с POSом
            this.Stop();
        }
        catch (e) {
            on_error_handler(5, 'Помилка отримання результату операції: ' + e.message);
            return;
        }
    }

    // принудительная остановка
    this.Stop = function () {
        try {
            this.ActiveX_Object.Abort();

            this.ActiveX_Object.Close(); // !!! реально порт не закрывает
            this.ActiveX_Object.Dispose();

            _IsStoped = true;
        }
        catch (e) {
            // завершить не получилось и все
        }
    }
}

// Взаимодействие с терминалом SSI
function POS_SSI(Port) {
    // ---- приватные константы
    var _const_timeout = new Number(10);

    // ---- публичные константы
    this.ActiveX_Name = 'AxECRClass';
    this.Name = 'SSI';

    // ---- приватные свойства
    var _ActiveX_Object;
    var _Port;

    var _IsStoped = false;

    // ---- конструктор
    __POS_SSI = function POS_SSI(that, Port) {
        _Port = Port;
    }(this, Port)

    // ---- приватные методы

    // ---- публичные методы
    // создание и конфигурация ActiveX
    this.CreateAndConfigure = function (on_success_handler, on_error_handler) {
        try {
            // контейнер для ActiveX
            var ContDiv = document.createElement('div');       
            document.appendChild(ContDiv);

            // добавляем object на страницу
            var ObjID = 'AxECRClass';
            ContDiv.innerHTML = '<object id="' + ObjID + '" data="data:application/x-oleobject;base64,rWCh77tu2BGO2Lh6ZvwQOgADAAA=" classid="CLSID:EFA160AD-6EBB-11D8-8ED8-B87A66FC103A" viewastext></object>';

			var ContDiv1 = document.createElement('div');       
            document.appendChild(ContDiv1);
            ContDiv1.innerHTML = '<object id="' + ObjID + '" data="data:application/x-oleobject;base64,rWCh77tu2BGO2Lh6ZvwQOgADAAA=" classid="CLSID:EFA160AD-6EBB-11D8-8ED8-B87A66FC103A" viewastext></object>';
			
            // получаем ссылку на object
            this.ActiveX_Object = document.getElementById(ObjID);

            // устанавливаем таймаут
            // this.ActiveX_Object.SetPurchTimeout(_const_timeout);

            on_success_handler();
        }
        catch (e) {
            on_error_handler(2, 'Помилка створення/конфігурації ActiveX (' + objPosSSI.ActiveX_Name + '): ' + e.message);
            return;
        }
    }
    // откритие COM-порта
    this.OpenPort = function (on_success_handler, on_error_handler) {
        try {
            this.ActiveX_Object.PosOpen(_Port);

            on_success_handler();
        }
        catch (e) {
            on_error_handler(7, 'Помилка відкриття COM-порту: ' + e.message);
            return;
        }
    }
    // получение результата операции идентификации
    this.GetResult = function (on_success_handler, on_error_handler) {
        try {
            // В параметре CHID приходит составной ключ код РУ и РНК клиента - это то что нужно АБС
            var CHID = this.ActiveX_Object.PosCardIdent();

            // если пришло умолчательное значение, то идентификация не успешная
            if (CHID == '--------') {
                throw new Error('Результатом ідентифікації є пусте значення');
            }

            // передаем код РУ и РНК
            var code_ru = CHID.substring(0, 4);
            var rnk = parseInt(CHID.substring(4), 10);

            on_success_handler(code_ru, rnk);
        }
        catch (e) {
            this.ClosePort();
            on_error_handler(8, 'Помилка ідентифікації клієнта: ' + e.message);
            return;
        }
    }
    // закрытие COM-порта
    this.ClosePort = function () {
        try {
            this.ActiveX_Object.PosClose();
        }
        catch (e) {
            // закрыть не получилось и все
            return;
        }
    }

    // принудительная остановка
    this.Stop = function () {
        try {
            this.ActiveX_Object.PosAbortTrx();

            _IsStoped = true;
        }
        catch (e) {
            // завершить не получилось и все
        }
    }
}

// Взаимодействие с терминалом Ingenico
function POS_INGENICO(Port) {

    // ---- публичные константы
    this.ActiveX_Name = 'ECRCommX.BPOS1Lib';
    this.Name = 'Ingenico';

    // ---- приватные свойства
    var _Port;  
    var _IsStoped = false;

    //скорость передачи данных
    var _BaudRate = 9600;
    //язык описания ошибок (0 - english, 1 - українська, 2 - русский)
    var _ErrorLanguage = 1;
    //торговый индекс, начинается с 1
    var _MerchantIndex = 1;
    //код валюты транзакции (грн)
    var _CurrencyCode = 845;
    //номер счета (0 - DEFAULT; 1 - SAVINGS; 2 - CHECKING; 3 - CREDIT; 4 - UNIVERSAL;)
    var _AccountNumber = 1;
    //код состояния терминала - вернул результат с ошибкой 
    var _ResultError = 1;
    //код состояния терминала в процессе идентификации карты 
    var _ResultInProgress = 2;
    //время запроса к терминалу - каждые пол секунды
    var _RequestTime = 500;
    //таймаут идентификации клиента - 5 минут
    var _Timeout = 5 * 60 * 1000;

    // ---- конструктор
    __POS_INGENICO = function POS_INGENICO(that, Port) {
        _Port = Port;
    }(this, Port);

    // ---- публичные методы
    // создание и конфигурация ActiveX
    this.CreateAndConfigure = function (on_success_handler, on_error_handler) {
        try {
            this.ActiveX_Object = new ActiveXObject("ECRCommX.BPOS1Lib");
            this.ActiveX_Object.SetErrorLang(_ErrorLanguage);
            on_success_handler();
        }
        catch (e) {
            on_error_handler(2, 'Помилка створення/конфігурації ActiveX (' + objPosIngenico.ActiveX_Name + '): ' + e.message);
            return;
        }
    }
    // откритие COM-порта
    this.OpenPort = function (on_success_handler, on_error_handler) {
        try {
            this.ActiveX_Object.CommOpenAuto(_BaudRate);
            if (this.ActiveX_Object.LastErrorCode != 0) {
                throw new Error(this.ActiveX_Object.LastErrorDescription);
            }
            on_success_handler();
        }
        catch (e) {
            on_error_handler(7, 'Помилка відкриття COM-порту: ' + e.message);
            return;
        }
    }
    // получение результата операции идентификации
    this.GetResult = function (on_success_handler, on_error_handler) {
        try {
            var activeXObject = this.ActiveX_Object;
            this.ActiveX_Object.IdentifyCard(_MerchantIndex, _CurrencyCode, _AccountNumber);
            if (this.ActiveX_Object.LastErrorCode != 0) {
                throw new Error(this.ActiveX_Object.LastErrorDescription);
            }
            
            //опрашиваем терминал через определенное время, прошла ли идентификация карты
            var timer = 0; 
            var timeoutId = setTimeout(function getIdentResult() {
                
                //таймер отвечает за проверку таймаута
                timer += _RequestTime;
                
                //если терминал ещё не идентифицировал и не прошел таймаут - опрашиваем ещё раз
                if (activeXObject.LastResult == _ResultInProgress && timer < _Timeout) {
                    timeoutId = setTimeout(getIdentResult, _RequestTime);
                //если уже завершил идентификацию
                } else {
                    
                    //больше не опрашиваем
                    clearTimeout(timeoutId);
                    
                    //далее обрабатываем различные ошибки
                    //если прошел таймаут
                    if (timer >= _Timeout) {
                        on_error_handler(8, 'Помилка ідентифікації клієнта: ' + 'Вийшов час очікування відповіді від терміналу');
                        return;
                    }
                    
                    //если идентификация прошла с ошибкой
                    if (activeXObject.LastResult == _ResultError) {
                        on_error_handler(8, 'Помилка ідентифікації клієнта: ' + activeXObject.LastErrorDescription);
                        return;
                    }

                    //если пришел пустой код клиента
                    if (!activeXObject.RNK || !activeXObject.RNK.length) {
                        on_error_handler(8, 'Помилка ідентифікації клієнта: ' + 'Кодом клієнта є пусте значення');
                        return;
                    }
                    
                    //если ошибок нет - передаем код РУ и РНК для идентификации
                    var code_ru = activeXObject.RNK.substring(0, 4);
                    var rnk = parseInt(activeXObject.RNK.substring(4), 10);

                    on_success_handler(code_ru, rnk);
                }
            }, _RequestTime);
        }
        catch (e) {
            this.ClosePort();
            on_error_handler(8, 'Помилка ідентифікації клієнта: ' + e.message);
            return;
        }
    }
    // закрытие COM-порта
    this.ClosePort = function () {
        try {
            this.ActiveX_Object.CommClose();
        }
        catch (e) {
            // закрыть не получилось и все
            return;
        }
    }

    // принудительная остановка
    this.Stop = function () {
        try {
            this.ActiveX_Object.CommClose();

            _IsStoped = true;
        }
        catch (e) {
            // завершить не получилось и все
        }
    }
}
