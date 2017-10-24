/**
 * Created by serhii.karchavets on 27.10.2016.
 */

var CURR_DICT = {1: "UAH", 2: "USD", 3: "EUR"};

var g_TerminaDataState = 0;

var g_HOST_ERRORS = {
    3 : "Format error",
    4 : "Retain card",
    5 : "External decline",
    12 : "Invalid transaction",
    13 : "Merchant limit exceeded",
    14 : "Invalid track 2",
    20 : "Verification fault",
    30 : "Invalid format",
    33 : "Expired card",
    54 : "Expired card",
    41 : "Lost card",
    43 : "Stolen card",
    51 : "Insufficient funds",
    55 : "Invalid PIN, PIN tries exceeded",
    58 : "Invalid processing code",
    62 : "Invalid MAC",
    78 : "Original request not found",
    81 : "Wrong format of customer information field",
    82 : "Prepaid code not found",
    89 : "Invalid terminal id.",
    91 : "Destination not available",
    94 : "Duplicate transmission",
    96 : "System error"
};


// Взаимодействие с терминалом SSI
function POS_SSI(Port) {
    // ---- приватные константы
    //var _const_timeout = new Number(10);

    // ---- публичные константы
    this.ActiveX_Name = 'AxECRClass';
    this.Name = 'SSI';

    // ---- приватные свойства
    var _ActiveX_Object;
    var _Port;
    var _PortOpened = false;

    var _IsStoped = false;

    // ---- конструктор
    __POS_SSI = function POS_SSI(that, Port) {
        _Port = Port;
    }(this, Port);

    // ---- приватные методы

    // ---- публичные методы
    // создание и конфигурация ActiveX
    this.CreateAndConfigure = function (on_success_handler, on_error_handler) {
        try {
            // контейнер для ActiveX
            //var ContDiv = document.createElement('div');
            //document.appendChild(ContDiv);

            // добавляем object на страницу
            var ObjID = 'AxECRClass';
            // ContDiv.innerHTML = '<object id="' + ObjID + '" data="data:application/x-oleobject;base64,rWCh77tu2BGO2Lh6ZvwQOgADAAA=" classid="CLSID:EFA160AD-6EBB-11D8-8ED8-B87A66FC103A" viewastext></object>';
            //
            // var ContDiv1 = document.createElement('div');
            // document.appendChild(ContDiv1);
            // ContDiv1.innerHTML = '<object id="' + ObjID + '" data="data:application/x-oleobject;base64,rWCh77tu2BGO2Lh6ZvwQOgADAAA=" classid="CLSID:EFA160AD-6EBB-11D8-8ED8-B87A66FC103A" viewastext></object>';

            // получаем ссылку на object
            this.ActiveX_Object = document.getElementById(ObjID);

            // устанавливаем таймаут
            // this.ActiveX_Object.SetPurchTimeout(_const_timeout);
            ///SetPurchTimeout - in seconds ; max = 420 sec (7 minutes)

            on_success_handler();
        }
        catch (e) {
            on_error_handler(2, 'Помилка створення/конфігурації ActiveX (' + objPosSSI.ActiveX_Name + '): ' + e.message);
            Waiting(false);
        }
        finally { Waiting(false); }
    };
    // откритие COM-порта
    this.OpenPort = function (on_success_handler, on_error_handler) {
        print("SSI:Try Open Port:"+_Port+" COM:"+this.ActiveX_Object+" _PortOpened:"+_PortOpened);

        try {
            if(!_PortOpened){
                this.ActiveX_Object.PosOpen(_Port);
                _PortOpened = true;
                print("SSI:OpenPort "+_Port);
            }
            on_success_handler();
        }
        catch (e) {
            on_error_handler(7, 'Помилка відкриття COM-порту: ' + e.message);
            Waiting(false);
        }
    };

    this.Settlement = function (on_success_handler, on_error_handler, on_message_handler){
        try {
            Complete();
        }
        catch (e) {
            print('Settlement: '+e.message);
            on_error_handler('Помилка ідентифікації клієнта: ' + e.message);
        }
        finally { this.ClosePort(); }
    };

    //callback from COM-object
    this.BatchTotalsCallback = function (res) {
        print("BatchTotalsCallback:"+res);

        if (res == 0) {

            function add(arrContainer, terminalID, amount, txnType, CC, CCcode) {
                if(amount > 0.0){
                    arrContainer.push({
                        TerminalID: terminalID,
                        CurrencyCode: CCcode,
                        Currency: CC,
                        Amount: amount,
                        TxnType: txnType,
                        TxnName: txnType == "OUTCOME" ? "Видача" : "Поповнення"
                    });
                }
            }
            try{
                var terminalID = "-1"; //Math.random().toString();      // terminal hasn't API for get terminalID
                var data = [];
                for(var k in CURR_DICT){
                    this.ActiveX_Object.PosGetMultiCurrencyReportByIndex(k);

                    var outCome = parseFloat(this.ActiveX_Object.DebitsAmount)*100;
                    var inCome = parseFloat(this.ActiveX_Object.CreditsAmount)*100;
                    var CC = this.ActiveX_Object.CurrencyCode;

                    add(data, terminalID, outCome.toFixed(2), "OUTCOME", CURR_DICT[k], CC);
                    add(data, terminalID, inCome.toFixed(2), "INCOME", CURR_DICT[k], CC);
                }
                var ds = new kendo.data.DataSource({ data: data });
                $("#gridMain").data("kendoGrid").setDataSource(ds);

                var dataForSend = [];
                for (var i = 0; i < data.length; i++) {
                    var item = data[i];
                    dataForSend.push({
                        sum: item.Amount,
                        operation_type: item.TxnType,
                        kv: item.CurrencyCode,
                        TerminaID: item.TerminalID
                    });
                }
                if(dataForSend.length > 0){
                    Pay(dataForSend, false);
                }
                else{
                    bars.ui.error({ title: 'Термінал', text: "Дані відсутні!" });
                }
            }catch (e){

            }finally { this.ClosePort(); }
        }
        else {
            this.ClosePort();
            if (g_TerminaDataState == 1) { g_TerminaDataState = 0; }
            on_error(5, "Невдала спроба. (Помилка отримання результату операції) " + g_HOST_ERRORS[parseInt(res)]);
        }
    };

    // получение результата операции идентификации
    this.GetBatchTotals = function (on_success_handler, on_error_handler, on_message_handler){
        try {
            Waiting(true);
            print("SSI:GetBatchTotals");

            this.ActiveX_Object.PosSettleMultiCurrency("0");  // OK
        }
        catch (e) {
            this.ClosePort();
            print('GetBatchTotals: '+e.message);
            on_error_handler('Помилка ідентифікації клієнта: ' + e.message);
        }
    };

    // закрытие COM-порта
    this.ClosePort = function () {
        try {
            Waiting(false);
            this.ActiveX_Object.PosClose();
            _PortOpened = false;
            print("SSI:ClosePort "+_Port);
        }
        catch (e) {
            // закрыть не получилось и все
        }
    };

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