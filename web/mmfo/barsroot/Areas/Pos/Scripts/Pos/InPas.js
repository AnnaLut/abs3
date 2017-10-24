/**
 * Created by serhii.karchavets on 27.10.2016.
 */

var STATUS_HOSTERROR = 1;
var STATUS_HOSTDECLINE = 2;
var STATUS_HOSTAPPROVE = 3;

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
    this.ActiveX_Name = 'InpasEcrCom';
    //this.ActiveX_Name = 'KKM.PosKKM';
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
    }(this, Port);

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
        }
        finally { Waiting(false); }
    };
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
        }
    };

    this.Settlement = function (on_success_handler, on_error_handler, on_message_handler){
        try {
            var res = this.ActiveX_Object;

            this.ActiveX_Object.SetValue(this.OperTag, "L");        // "L" - close day

        }
        catch (e) {
            if(IS_DEBUG){console.error('Settlement: '+e.message);}
            on_error_handler('Помилка ідентифікації клієнта: ' + e.message);
        }
        finally {
            Waiting(false);
            // закрываем соединение с POSом
            this.Stop();
        }
    };

    this.GetBatchTotals = function (on_success_handler, on_error_handler, on_message_handler){
        try {
            // если остановили насильно, то выходим
            if (_IsStoped) return;

            print("InPas::GetBatchTotals");

            // сброс текущей операции
             //this.ActiveX_Object.ResetOperData();


            //
            // //this.ActiveX_Object.SetValue("OPER", "q");
            // this.ActiveX_Object.SetValue("OPER", "T");
            // this.ActiveX_Object.SetGuardTimer(_const_inpas_timer3);
            // var res = this.ActiveX_Object.Auth();
            // if (res != 0)
            // {
            //     this.Stop();
            //     on_error_handler("InPas::GetBatchTotals - ERROR Auth");
            //     return;
            // }
            //
            // var i = 0;
            // do { i = this.ActiveX_Object.GetState(); }
            // while ((i != -2) && (i != 0) && (i != -1) && (i != 4));
            //
            // res = this.ActiveX_Object.GetResult();
            // print("res:("+res + ") "+_Enum_GetResult_Errors[res.toString()]);
            // if (res == STATUS_HOSTAPPROVE)
            // {
            //     // var cheque_no = this.ActiveX_Object.GetValue("TERM_TOTALS_OW");
            //     // print("cheque_no:" + cheque_no);
            //     //
            //     // var TERM_TOTALS = this.ActiveX_Object.GetValue('TERM_TOTALS');
            //     // print("TERM_TOTALS:" + TERM_TOTALS);
            //     //
            //     var Term_Id = this.ActiveX_Object.GetValue('Term_Id');
            //     print("Term_Id:"+Term_Id);
            //
            //     Term_Id = this.ActiveX_Object.GetValue('rsp.Term_Id');
            //     print("rsp.Term_Id:"+Term_Id);
            //
            //     // var KKM_TermName = this.ActiveX_Object.GetValue('KKM_TermName');
            //     // print("KKM_TermName:"+KKM_TermName);
            // }
        }
        catch (e) {
            if(IS_DEBUG){console.error('Помилка отримання результату операції: ' + e.message);}
            on_error_handler('Помилка отримання результату операції: ' + e.message);
        }
        finally {
            Waiting(false);
            // закрываем соединение с POSом
            this.Stop();
        }
    };

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
        }
    };
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
        }
    };
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
        }
    };

    // принудительная остановка
    this.Stop = function () {
        try {
            this.ActiveX_Object.Abort();

            this.ActiveX_Object.Close(); // !!! реально порт не закрывает
            this.ActiveX_Object.Dispose();

            _IsStoped = true;

            print("InPas::Stop");
        }
        catch (e) {
            // завершить не получилось и все
        }
    }
}