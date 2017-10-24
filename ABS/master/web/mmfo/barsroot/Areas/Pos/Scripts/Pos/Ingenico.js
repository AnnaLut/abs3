/**
 * Created by serhii.karchavets on 27.10.2016.
 */

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
    //код состояния терминала - вернул результат с ошибкой
    var _ResultError = 1;
    //код состояния терминала в процессе идентификации карты
    var _ResultInProgress = 2;
    //таймаут идентификации клиента - 5 минут
    var _Timeout = 5 * 60 * 1000 * 60;

    var _Purchase = 0;
    var _Refund = 7;

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
            Waiting(false);
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
            Waiting(false);
        }
    }

    this.GetBatchTotals = function (on_success_handler, on_error_handler, on_message_handler) {
        try{
            var activeXObject = this.ActiveX_Object;

            activeXObject.GetTxnNum();
            if (this.ActiveX_Object.LastErrorCode != 0) {
                throw new Error(this.ActiveX_Object.LastErrorDescription);
            }

            var time = 0;
            var TxnNum = -1;
            while (true){
                if(activeXObject.LastResult != _ResultInProgress){
                    if(IS_DEBUG){console.log("END reading TxnNum...." + activeXObject.LastResult);}

                    if(activeXObject.LastResult == _ResultError){
                        if(IS_DEBUG){console.error("ERROR....");}
                        if(on_error_handler){ on_error_handler('Помилка ідентифікації клієнта: ' + activeXObject.LastErrorDescription); }
                    }
                    else{
                        if(IS_DEBUG){console.log("TxnNum="+activeXObject.TxnNum);}
                        TxnNum = activeXObject.TxnNum;
                    }
                    break;
                }
                time += 1;
                if((time/60/1000) > _Timeout){
                    if(IS_DEBUG){console.error('GetBatchTotals TxnNum Вийшов час очікування відповіді від терміналу');}
                    if(on_error_handler){ on_error_handler("Вийшов час очікування відповіді від терміналу"); }
                    break;
                }
            }

            if(TxnNum > 0){
                var terminalData = [];
                var i;
                for(i = 1; i <= TxnNum;){
                    time = 0;
                    activeXObject.GetTxnDataByOrder(i);
                    while (true){
                        if(activeXObject.LastResult != _ResultInProgress){
                            if(IS_DEBUG){console.log("END GetTxnDataByOrder....i="+ i+" LastResult="+ + activeXObject.LastResult);}

                            if(activeXObject.LastResult == _ResultError){
                                if(IS_DEBUG){console.error("Помилка ідентифікації клієнта GetTxnDataByOrder.... " + activeXObject.LastErrorDescription);}
                            }
                            else{
                                var TerminalID = activeXObject.TerminalID;
                                var Currency = activeXObject.Currency;
                                var Amount = activeXObject.Amount;
                                var TxnType = activeXObject.TxnType;
                                var TrnStatus = activeXObject.TrnStatus;
                                var CurrencyCode = activeXObject.CurrencyCode;
                                var ResponseCode = activeXObject.ResponseCode;
                                if(IS_DEBUG){
                                    console.log(
                                        "Id=" + i,
                                        " ResponseCode="+ResponseCode,
                                        " TerminalID="+TerminalID+
                                        " Currency="+Currency+
                                        " CurrencyCode="+CurrencyCode+
                                        " Amount="+Amount+
                                        " TxnType="+TxnType+
                                        " TrnStatus="+TrnStatus
                                    );
                                }
                                if(ResponseCode == 0 && (TxnType == _Purchase || TxnType == _Refund)){
                                    terminalData.push({
                                        Id: i,
                                        TerminalID: TerminalID,
                                        Currency: Currency,
                                        CurrencyCode: CurrencyCode,
                                        Amount: Amount,
                                        TxnType: TxnType,
                                        TrnStatus: TrnStatus
                                    });
                                }
                            }
                            break;
                        }
                        else {
                            time += 1;
                            if((time/60/1000) > _Timeout){
                                if(IS_DEBUG){console.error('GetBatchTotals GetTxnDataByOrder - Вийшов час очікування відповіді від терміналу');}
                                if(on_error_handler){ on_error_handler("Вийшов час очікування відповіді від терміналу"); }
                                break;
                            }
                        }
                    }
                    i += 1;
                }
                var currencyDict = {};
                if(terminalData.length > 0){
                    var TerminalID = -1;
                    var dataAmount = {};
                    var data = [];
                    for(var j = 0; j < terminalData.length; j++){
                        var txn = terminalData[j];
                        var txnType = txn.TxnType == _Purchase ? "OUTCOME" : "INCOME";         //0 – Purchase  7 – Refund
                        if(dataAmount[txnType] == undefined || dataAmount[txnType] == null){
                            dataAmount[txnType] = {};
                        }
                        if(dataAmount[txnType][txn.CurrencyCode] == undefined || dataAmount[txnType][txn.CurrencyCode] == null){
                            dataAmount[txnType][txn.CurrencyCode] = 0;
                        }
                        dataAmount[txnType][txn.CurrencyCode] += txn.Amount;
                        TerminalID = txn.TerminalID;
                        if(currencyDict[txn.CurrencyCode] == undefined || currencyDict[txn.CurrencyCode] == null){
                            currencyDict[txn.CurrencyCode] = txn.Currency;
                        }
                    }

                    for(var txnType in dataAmount){
                        for(var CurrencyCode in dataAmount[txnType]){
                            data.push({
                                TerminalID: TerminalID,
                                CurrencyCode: CurrencyCode,
                                Currency: currencyDict[CurrencyCode],
                                Amount: dataAmount[txnType][CurrencyCode],
                                TxnType: txnType,
                                TxnName: txnType == "OUTCOME" ? "Видача" : "Поповнення"
                            });
                        }
                    }
                    $("#FireBtn").prop("disabled", false);
                    var ds = new kendo.data.DataSource({ data: data });
                    $("#gridMain").data("kendoGrid").setDataSource(ds);
                    if(on_success_handler){ on_success_handler("Дані отримано!"); }
                }
                else{
                    if(on_error_handler){ on_error_handler("Транзакції поповнення/видачі на терміналі відсутні. Всього операцій:"+TxnNum); }
                }
            }
            else{
                if(on_error_handler){ on_error_handler("Транзакції на терміналі відсутні"); }
            }
        }
        catch (e){
            if(IS_DEBUG){console.error('GetBatchTotals: '+e.message);}
            if(on_error_handler){ on_error_handler(e.message); }
        }
        finally {
            Waiting(false);
            this.ClosePort();
        }
    }

    this.PrintBatchTotals = function (on_success_handler, on_error_handler, on_message_handler){
        try{
            var activeXObject = this.ActiveX_Object;

            this.ActiveX_Object.PrintBatchTotals(_MerchantIndex);

            if (this.ActiveX_Object.LastErrorCode != 0) {
                throw new Error(this.ActiveX_Object.LastErrorDescription);
            }

            var time = 0;
            while (true){
                //0 - Successfull, 1 - Error, 2 - In progress
                if(activeXObject.LastResult != _ResultInProgress){
                    if(IS_DEBUG){console.log("Settlement END...." + activeXObject.LastResult);}

                    if(activeXObject.LastResult == _ResultError){
                        if(IS_DEBUG){console.error("Settlement ERROR....");}
                        if(on_error_handler){ on_error_handler('Помилка ідентифікації клієнта: ' + activeXObject.LastErrorDescription); }
                        break;
                    }
                    else{
                        g_text = "Звіт роздруковано";
                        Complete();
                    }
                    break;
                }
                time += 1;
                if((time/60/1000) > _Timeout){
                    if(IS_DEBUG){console.error('Settlement Вийшов час очікування відповіді від терміналу');}
                    if(on_error_handler){ on_error_handler("Вийшов час очікування відповіді від терміналу"); }
                    break;
                }
            }

        }
        catch (e){
            if(IS_DEBUG){console.error('Settlement: '+e.message);}
            if(on_error_handler){ on_error_handler(e.message); }
        }
        finally {
            Waiting(false);
            this.ClosePort();
        }
    }

    this.Settlement = function (on_success_handler, on_error_handler, on_message_handler) {
        try{
            var activeXObject = this.ActiveX_Object;

            this.ActiveX_Object.Settlement(_MerchantIndex);

            if (this.ActiveX_Object.LastErrorCode != 0) {
                throw new Error(this.ActiveX_Object.LastErrorDescription);
            }

            var res = false;

            var time = 0;
            while (true){
                //0 - Successfull, 1 - Error, 2 - In progress
                if(activeXObject.LastResult != _ResultInProgress){
                    if(IS_DEBUG){console.log("Settlement END...." + activeXObject.LastResult);}

                    if(activeXObject.LastResult == _ResultError){
                        if(IS_DEBUG){console.error("Settlement ERROR....");}
                        if(on_error_handler){ on_error_handler('Помилка ідентифікації клієнта: ' + activeXObject.LastErrorDescription); }
                        break;
                    }
                    else{
                        res = true;
                    }
                    break;
                }
                time += 1;
                if((time/60/1000) > _Timeout){
                    if(IS_DEBUG){console.error('Settlement Вийшов час очікування відповіді від терміналу');}
                    if(on_error_handler){ on_error_handler("Вийшов час очікування відповіді від терміналу"); }
                    break;
                }
            }

            if(res){
                activeXObject.ReqCurrReceipt();
                time = 0;
                while (true){
                    //0 - Successfull, 1 - Error, 2 - In progress
                    if(activeXObject.LastResult != _ResultInProgress){
                        if(IS_DEBUG){console.log("Settlement END...." + activeXObject.LastResult);}

                        if(activeXObject.LastResult == _ResultError){
                            if(IS_DEBUG){console.error("Settlement ERROR....");}
                            if(on_error_handler){ on_error_handler('Помилка ідентифікації клієнта: ' + activeXObject.LastErrorDescription); }
                            break;
                        }
                        else{
                            Complete();
                        }
                        break;
                    }
                    time += 1;
                    if((time/60/1000) > _Timeout){
                        if(IS_DEBUG){console.error('Settlement Вийшов час очікування відповіді від терміналу');}
                        if(on_error_handler){ on_error_handler("Вийшов час очікування відповіді від терміналу"); }
                        break;
                    }
                }
            }

        }
        catch (e){
            if(IS_DEBUG){console.error('Settlement: '+e.message);}
            if(on_error_handler){ on_error_handler(e.message); }
        }
        finally {
            Waiting(false);
            this.ClosePort();
        }
    }

    this.GetBatchTotalsOld = function (on_success_handler, on_error_handler, on_message_handler) {
        try{
            var activeXObject = this.ActiveX_Object;

            this.ActiveX_Object.GetBatchTotals(_MerchantIndex);
            if (this.ActiveX_Object.LastErrorCode != 0) {
                throw new Error(this.ActiveX_Object.LastErrorDescription);
            }
            var TerminaData = null;  // main terminal data

            var time = 0;
            while (true){
                //0 - Successfull, 1 - Error, 2 - In progress
                if(activeXObject.LastResult != _ResultInProgress){
                    if(IS_DEBUG){console.log("END...." + activeXObject.LastResult);}

                    if(activeXObject.LastResult == _ResultError){
                        if(IS_DEBUG){console.error("ERROR....");}
                        if(on_error_handler){ on_error_handler('Помилка ідентифікації клієнта: ' + activeXObject.LastErrorDescription); }
                        break;
                    }
                    else{

                        debugger;

                        var TotalsDebitNum = this.ActiveX_Object.TotalsDebitNum;
                        var TotalsDebitAmt = this.ActiveX_Object.TotalsDebitAmt;
                        TotalsDebitAmt = TotalsDebitAmt / 100;
                        var TotalsCreditNum = this.ActiveX_Object.TotalsCreditNum;
                        var TotalsCreditAmt = this.ActiveX_Object.TotalsCreditAmt;
                        TotalsCreditAmt = TotalsCreditAmt / 100;
                        // var TotalsCancelledNum = this.ActiveX_Object.TotalsCancelledNum;
                        // var TotalsCancelledAmt = this.ActiveX_Object.TotalsCancelledAmt;
                        // TotalsCancelledAmt = TotalsCancelledAmt / 100;

                        TerminaData = [
                            {
                                "TotalsDebitNum": TotalsDebitNum,
                                "TotalsDebitAmt": TotalsDebitAmt,
                                "TotalsCreditNum": TotalsCreditNum,
                                "TotalsCreditAmt": TotalsCreditAmt
                            }
                        ];
                    }
                    break;
                }
                time += 1;
                if((time/60/1000) > _Timeout){
                    if(IS_DEBUG){console.error('Вийшов час очікування відповіді від терміналу');}
                    if(on_error_handler){ on_error_handler("Вийшов час очікування відповіді від терміналу"); }
                    break;
                }
            }

            if(TerminaData != null){
                time = 0;
                this.ActiveX_Object.GetTxnDataByOrder(1);
                while (true){
                    //0 - Successfull, 1 - Error, 2 - In progress
                    if(activeXObject.LastResult != _ResultInProgress){
                        if(IS_DEBUG){console.log("END...." + activeXObject.LastResult);}

                        if(activeXObject.LastResult == _ResultError){
                            if(IS_DEBUG){console.error("ERROR....");}
                            if(on_error_handler){ on_error_handler('Помилка ідентифікації клієнта: ' + activeXObject.LastErrorDescription); }
                            break;
                        }
                        else{
                            TerminaData[0]["ID"] = activeXObject.TerminalID;
                            TerminaData[0]["kv"] = KV;

                            var ds = new kendo.data.DataSource({ data: TerminaData });
                            $("#gridMain").data("kendoGrid").setDataSource(ds);
                            if(on_success_handler){ on_success_handler("Дані отримано!"); }
                        }
                        break;
                    }
                    time += 1;
                    if((time/60/1000) > _Timeout){
                        if(IS_DEBUG){console.error('Вийшов час очікування відповіді від терміналу');}
                        if(on_error_handler){ on_error_handler("Вийшов час очікування відповіді від терміналу"); }
                        break;
                    }
                }
            }
            else{
                if(IS_DEBUG){console.error("TerminaData is null");}
                on_error_handler("Невдала спроба ");
            }
        }
        catch (e){
            if(IS_DEBUG){console.error('GetBatchTotals: '+e.message);}
            if(on_error_handler){ on_error_handler(e.message); }
        }
        finally {
            Waiting(false);
            this.ClosePort();
        }
    }

    // закрытие COM-порта
    this.ClosePort = function () {
        try {
            this.ActiveX_Object.CommClose();
        }
        catch (e) {
            // закрыть не получилось и все
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