var zElementIndex = { up: 0, middle: 0, down: 0 };
var showHide = {};
var intervalObj = {};
var SbonFlag = '1';
var tellerStatusText = { 0: 'Зачекайте, виконується операція', 1: 'Будь ласка, заберіть гроші', 2: 'Будь ласка, заберіть не прийняті гроші' };
var onConfirmClickSwitchValue = 0;
var colorGray = 'atm-color-gray', colorBlue = 'atm-color-blue', colorGreen = 'atm-color-green', colorRed = 'atm-color-red';
var OK = 0, ERROR = 1;
//var OK = 1, ERROR = 0;

//==============методы и объекты для работы ТЕЛЛЕРА

/// проверка ширины
function onWindowResize() {
    if ($('#atm-window').length) {
        if ($(window).width() <= 850)
            $('#atm-window').css({ left: '5%' });
        else if ($(window).width() <= 1024)
            $('#atm-window').css({ left: '15%' });
        else
            $('#atm-window').css({ left: '30%' });
    }
}

/// обработка запросов (POST) для работы АТМ
function Implement(options) {
    options = $.extend({ success: null, error: null, url: '', status: false, data: null, hideConfirm: false, func: null }, options);
    showHide.showPreloaderItems_BackwardWindow();
    if (options.hideConfirm)
        showHide.showHideElements(['#atm-confirm'], 'none');
    $.ajax({
        type: 'POST',
        url: options.url,
        data: options.data,
        success: options.success,
        error: options.error
    });
    if (options.status)
        intervalObj.Run(GetStatus, 500);
}

/// получение статуса операции АТМ
function GetStatus() {
    var http = location.protocol.toLowerCase() === 'http:' ? true : false;
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/teller/tellerATM/GetATMStatus?http=' + http,
        success: function (result) {
            if (result.status)
                $('#text-oper').text(tellerStatusText[result.status.TellerStatusCode]);
        },
        error: function (result) {
            intervalObj.Stop();
        }
    });
}

/// описание объекта для получения изменения статуса АТМ с интервалом 0.5 сек.
function StatusInterval() {
    var value = false;
    var interval = null;

    this.Run = function (func, time) {
        if (!this.isRuning()) {
            interval = setInterval(func, time);
            value = true;
        }
    };

    this.Stop = function () {
        clearInterval(interval);
        value = false;
    };

    this.isRuning = function () {
        return value !== false;
    };    
}

/// объект для работы с показом или скрытием элементов
function ElementsVisibility() {
    this.showHideElements = function (elements, action) {
        for (var i = 0; i < elements.length; ++i)
            $(elements[i]).css('display', action);
    }

    this.showPreloader = function () {
        this.showHideElements(["#preloader"],'block');
        this.showPreloaderItems();
    };

    this.hidePreloader = function () {
        this.showHideElements(["#preloader"], 'none');
    };

    this.showPreloaderItems = function () {
        this.showHideElements(['#preloader', '#preloader-text', '#text-oper', '#teller-preloader-image'], 'block');
        $('#preloader').css('z-index', zElementIndex.middle);
    };

    this.hidePreloaderItems = function () {
        this.showHideElements(["#preloader-text", '#text-oper', '#teller-preloader-image'], 'none');
    }

    this.showPreloaderItems_BackwardWindow = function () {
        $('#atm-window').css('z-index', zElementIndex.down);
        this.showPreloaderItems();
    }

    this.showPreloaderItems_BackwardWindow_BackwardTechnical = function () {
        this.showPreloaderItems_BackwardWindow();
        $('#technical-buttons-window').css('z-index', zElementIndex.down);
    }

    this.showPreloaderItems_HideConfirm = function () {
        this.showPreloaderItems_BackwardWindow();
        this.showHideElements(['#atm-confirm'], 'none');
    }

    this.hidePreloader_CloseConfirm = function () {
        this.hidePreloader();
        this.showHideElements(['#atm-confirm'], 'none');
    }

    this.hidePreloaderItems_UpwardWindow = function () {
        this.hidePreloaderItems();
        $('#atm-window').css('z-index', zElementIndex.up);
    }

    this.hidePreloaderItems_CloseConfirm = function () {
        this.hidePreloaderItems();
        this.showHideElements(['#atm-confirm'], 'none');
    }

    this.hidePreloaderItems_CloseConfirm_UpwardWindow = function () {
        this.hidePreloaderItems_CloseConfirm();
        $('#atm-window').css('z-index', zElementIndex.up);
    }
}

/// Окно подтверждения
function confirmWindow(options) {
    options = $.extend({ func: 0, text: '', value: {} }, options);
    $('#atm-window').css('z-index', zElementIndex.down);
    $('#atm-confirm-txt').html('');
    $('#atm-confirm-txt').append($.parseHTML(options.text));
    onConfirmClickSwitchValue = options.func;
    if (!$.hasData($('#atm-confirm-close'))) {
        $("#atm-confirm-close").unbind("click");
        $('#atm-confirm-close').click(function () { OnConfirmClick(options.value); });
    }
    showHide.hidePreloaderItems();
    $('#atm-confirm').css('z-index', zElementIndex.up);
    showHide.showHideElements(['#atm-confirm'], 'block');
}

/// Обработчик события на положительное подтверждение на запрос
function OnConfirmClick(value) {
    switch (onConfirmClickSwitchValue) {
        case 0:
            break;
        case 1:
            ConfirmCloseAtmForm();
            break;
        case 2:
            BeginCancelOperation();
            break;
        case 3:
            StopOperation();
            break;
        case 4:
            activateTeller(value);
            break;
    }
}

/// Оповещения
function showNotification(text, errType, info) {
    if (errType === 'error') {
        text = text === '' ? 'Виникла помилка при виконанні операції, зверніться будь ласка до адміністратора' : text;
        $('#teller-notify-head-text').addClass('teller-error-txt').text('Помилка');
    }
    else {
        $('#teller-notify-head-text').removeClass('teller-error-txt').text('Інформація');
        if (info && (info !== 'undefined' || info !== 'OK'))
            $('#atm-info').html(info);
    }
    $('#teller-notofication-txt').html('');
    $('#teller-notofication-txt').append($.parseHTML(text));
    showHide.showHideElements(['#teller-notification-window'], 'block');
    if ($('#atm-window').length || $('#technical-buttons-window').length || $('#encashment-window').length || $('#teller-carrying-out-window').length)
        showHide.hidePreloaderItems();
    else
        showHide.hidePreloader();
    if ($('#encashment-window').length)
        $('#encashment-window').css('z-index', zElementIndex.up);
    $("#text-oper").text('Зачекайте, виконується операція');
}

/// закрытие окна оповещений
function notificationClose() {
    showHide.showHideElements(['#teller-notification-window'], 'none');
    if (!$('#atm-window').length && !$('#technical-buttons-window').length && !$('#encashment-window').length && !$('#teller-carrying-out-window').length)
        showHide.hidePreloader();    
    else if ($('#atm-window').length)
        if (+$('#atm-window').css('z-index') === zElementIndex.down)
            $('#atm-window').css('z-index', zElementIndex.up);
    if ($('#technical-buttons-window').length)
        $('#technical-buttons-window').css('z-index', zElementIndex.up);
}

//============= Функции для работы Теллера

/// Стандартный метод для обработки AJAX ошибок
function DefaultError(err) {
    showNotification('','error');
    $('#atm-window').css('z-index', zElementIndex.up);
    showHide.hidePreloaderItems();
    if (intervalObj.isRuning())
        intervalObj.Stop();
}

/// вызов окна для работы с АТМ
function TellerWindow() {
    var ref = GetRef();
    if (!ref)
        return;
    else if (ref === -1)
        ref = 0;
    var url = '/barsroot/teller/teller/atm';
    var isSWI = GetSWI();
    Implement({
        success: TellerWindowSuccess,
        error: DefaultError,
        url: url,
        data: { Ref: ref, SbonFlag: 0, isSWI: isSWI, Method: 'getwindowstatus' }
    });
}

/// обработчик AJAX запроса метода TellerWindow
function TellerWindowSuccess(result) {
    document.getElementById('atm-window-container').innerHTML = result;
    showHide.hidePreloaderItems_UpwardWindow();
}

/// начало внесения денежных средств
function BeginCashInput() {
    if ($('#cant-cancel').length && $('#cant-cancel').val() === '0')
        $('#cant-cancel').val(1);
    var ref = GetRef();
    Implement({
        url: '/barsroot/teller/tellerATM/atmrequest',
        data: { Ref: ref, SbonFlag: 0, Method: 'makerequest' },
        error: DefaultError,
        status: true,
        success: SuccessBeginCashInput
    });
    intervalObj.Run(GetStatus, 500);
}

/// обработчик AJAX запроса метода BeginCashInput
function SuccessBeginCashInput(result) {
    showHide.hidePreloaderItems_UpwardWindow();
    if (result.statusCode === 200 && result.model.Message) {//&& result.model.Message != "OK" && result.model.Message != 'null') {
        showNotification(result.model.Message);
        $('#atm-p-err-text').html(result.model.Message);
    }
    else if (result.statusCode >= 400) {
        var errText = '';
        if (result.P_errtxt)
            errText = result.P_errtxt;
        else if (result.p_errtxt)
            errText = result.p_errtxt;
        showNotification(errText, 'error');
    }
    if (result.model && result.model.StatusText)
        $('#atm-info').html(result.model.StatusText);
    if (intervalObj.isRuning())
        intervalObj.Stop();
}

/// подтверждение внесения наличных в АТМ
function CashInputConfirm() {
    if ($('#cant-cancel').length && $('#cant-cancel').val() === '0')
        $('#cant-cancel').val(1);
    var ref = GetRef();
    showHide.showPreloaderItems_BackwardWindow();
    Implement({
        url: '/barsroot/teller/telleratm/ATMRequest',
        data: { Ref: ref, SbonFlag: 0, Method: 'confirmrequest' },
        error: DefaultError,
        success: SuccessCashInputConfirm,
        status: true
    });
    intervalObj.Run(GetStatus, 500);
}

/// обработчик AJAX запроса метода CashInputConfirm
function SuccessCashInputConfirm(result) {
    SuccessBeginCashInput(result);
    if (result.statusCode === 200) {
        if (result.model.Status === "Done") {
            var stat = $("#atm-window-status").val();
            Restore(result.model.Amount, stat);
            ShowHideChangeButton(result.model.Amount, stat);
        }
        else if (result.model.Status === "ERR") {
            showNotification(result.model.Message, 'error');
        }
    }
}

/// завершение операции
function AtmTempo() {
    confirmWindow({
        func: 3,
        text: 'Закінчити дану операцію?'
    });
}

/// Проверка на завершение операции
function StopOperation() {
    showHide.showPreloaderItems_HideConfirm();
    var ref = GetRef();
    var amount = $('#atm-in-out-sum').html();
    var tempo = +parseFloat($("#atm-sum-dif").val()).toFixed(2);
    var status = $('#atm-window-status').val();
    var info = $('#atm-tempo-in-out-info').text();
    amount = +parseFloat(amount).toFixed(2);
    if (amount < 0)
        amount *= -1;
    if (tempo < 0)
        tempo *= -1;
    var stat = status === 'OUT' || status === 'IN' ? true : false;
    if (info == 'видати з темпокаси' && stat === true) {
        var tempoSum = tempo;
        if (tempo > 0)
            tempoSum = tempo * -1;
        var currency = $('#atm-currency-txt').html();
        Implement({
            url: '/barsroot/api/teller/teller/GetNonAtmAmount?currency=' + currency,
            error: DefaultError,
            success: function (data) {
                if (+data < tempo) {
                    var text = 'Недостатньо грошей в темпокасі<br/>Необхідна: ' + parseFloat(tempo).toFixed(2) + '<br/>Фактична: ' + parseFloat(data).toFixed(2);
                    showNotification(text, 'error');
                    return;
                }
                EndOperation(ref, amount, tempoSum);
            }
        });
    }
    else {
        var nonAtm = tempo > 0 ? +parseFloat(tempo.toString()).toFixed(2) : tempo;
        //info === 'Внести в темпокасу' &&
        nonAtm = +nonAtm;
        if (nonAtm < 0)
            nonAtm = nonAtm * -1;
        EndOperation(ref, amount, nonAtm);
    }
}

/// Завершение операции с АТМ
function EndOperation(ref, amount, tempo) {
    Implement({
        url: '/barsroot/api/teller/teller/ATMRequest',
        data: { Ref: ref, SbonFlag: 0, Amount: amount, NonAmount: tempo, Method: 'endrequest' },
        error: DefaultError,
        success: StopOperationOnSuccess
    });
}

/// функция обработчик при успешном завершении операции
function StopOperationOnSuccess(result) {
    showHide.hidePreloaderItems();
    if (result.Status) {
        var prevStatus = $('#atm-window-status').val();
        if (result.Message === 'Операцію з пристроєм завершено' && result.OperDesc === 'Документ знаходиться в статусі "відмінений"')
            result.Status = 'Done';
        if (result.Status === 'Done' || result.Status === 'OK' || result.Status === 'RJ') {
            document.getElementById('atm-window-container').innerHTML = "";
            showHide.hidePreloader();            
            if (result.Message) {
                showNotification(result.Message, result.Status);
                $('#atm-p-err-text').html(result.Message);
            }
        }
        else if (result.Status === 'ERR')
            showNotification(result.Message, 'error');
        else {
            document.getElementById('atm-window-container').innerHTML = "";
            showHide.showPreloaderItems();
            if (result.OperDesc !== "Документ знаходиться в статусі \"відмінений\"")
                TellerWindow();
        }        
    }
    $('#atm-window').css('z-index', zElementIndex.up);
    if (result.model && result.StatusText)
        $('#atm-info').html(result.StatusText);
}

/// Показ и скрытие кнопки для выдачи сдачи
function ShowHideChangeButton(currentSum, status) {
    var difSum = +parseFloat($("#atm-sum-dif").val()).toFixed(2);
    var button = $('#teller-change-button');
    if (status === 'IN' && difSum < 0) {
        if ($(button).css('display') === 'none')
            showHide.showHideElements([button], 'block');
    }
    else if ($(button).css('display') !== 'none')
            showHide.showHideElements([button], 'none');
}

/// Обработка события для выдачи сдачи
function GiveChange() {
    var ref = GetRef();
    var tempo = +parseFloat($("#atm-sum-tempo").text()).toFixed(2);
    //if (tempo > 0)
    //    tempo = tempo * -1;
    var cur = $('#atm-currency-txt').html();
    showHide.showPreloaderItems_BackwardWindow();
    Implement({
        url: '/barsroot/teller/tellerATM/ChangeRequest',
        data: { Ref: ref, SbonFlag: 0, Amount: tempo, Currency: cur },
        status: true,
        success: onGiveChangeSuccess,
        error: DefaultError
    });
    intervalObj.Run(GetStatus, 500);
}

/// функция при успешном выполнении операции для выдачи сдачи
function onGiveChangeSuccess(result) {
    if (result.status.Result !== ERROR)
        RestoreChange(result.status.Result);
    showNotification(result.status.P_errtxt);
    showHide.hidePreloaderItems_UpwardWindow();
    if (result.status.P_errtxt !== 'OK')
        $('#atm-p-err-text').html(result.status.P_errtxt);
    intervalObj.Stop();
}

/// Пересчет выдачи сдачи
function RestoreChange(amount) {
    var inSum = $('#atm-in-out-sum').text();
    var result = inSum - amount;
    $('#atm-in-out-sum').text(result);
    var tempoSum = (+parseFloat($('#atm-sum-tempo').text()).toFixed(2)) - amount;
    $('#atm-sum-dif').val(tempoSum);
    $('#atm-sum-tempo').text(tempoSum.toFixed(2));
}

/// Закрытие окна об ошибке при вызове АТМ
function CloseAtmErrWindow() {
    document.getElementById('atm-window-container').innerHTML = "";
    showHide.hidePreloader();
}

/// Событие на нажатие кнопки "закрыть окно"
function CloseAtmForm(value) {
    if ($('#cant-cancel').val() === '0')
        confirmWindow({ func: 1, text: 'Закрити вікно?' })
    else if ($('#cant-cancel').val() === '1')
        showNotification('Операцію не завершено!');
}

/// Отмена операции
function CancelOperation() {
    confirmWindow({ func: 2, text: 'Відмінити операцію?' });
}

/// Проведение отмены операции
function BeginCancelOperation() {
    showHide.showPreloaderItems_HideConfirm();
    var ref = GetRef();
    Implement({
        url: '/barsroot/api/teller/teller/atmrequest',
        data: { Ref: ref, SbonFlag: 0, Method: 'CancelAtmWindowOperation' },
        error: DefaultError,
        success: BeginCancelOperationOnSuccess
    });
}

/// Функция для обраь=ботки результете проведения отмены операции
function BeginCancelOperationOnSuccess(result) {
    var prevStatus = $('#atm-window-status').val();
    showHide.hidePreloaderItems();
    if (result.Status) {
        $('#atm-p-err-text').html(result.Message);
        if (result.Status === "Done") {
            $('#atm-window-container').empty();
            showHide.showHideElements(["#trOptions"], 'block');
            showHide.hidePreloader_CloseConfirm();
        }
        else if (result.Status === "RJ")
            showHide.hidePreloader_CloseConfirm();
        else if (result.Status === 'ERR')
            showNotification(result.Message, 'error');
        else {//if (prevStatus !== result.Status) {
            if (result.Message)
                showNotification(result.Message);
            $('#atm-window-container').empty();
            showHide.showPreloaderItems();
            TellerWindow();
        }
        //else if (result.Message)
        //    showNotification(result.Message);
    }
    $('#atm-window').css('z-index', zElementIndex.up);
    showHide.showHideElements(['#atm-confirm'], 'block');
    if (result.StatusText)
        $('#atm-info').html(result.StatusText);
}

/// Подтверждение закрытия окна
function ConfirmCloseAtmForm() {
    $('#atm-window-container').empty();
    showHide.hidePreloader_CloseConfirm();
}

/// Не подтвержение закрытия окна
function CancelCloseAtmWindow() {
    if (!$('#atm-window').length && !$('#encashment-window').length && !$('#encashment-window').length)
        showHide.hidePreloader_CloseConfirm();
    else
        showHide.hidePreloaderItems_CloseConfirm_UpwardWindow();
}

/// Событие на нажатие технических кнопок
function TellerTechnicalButtonSubmit(funcName) {
    showHide.showPreloaderItems_BackwardWindow_BackwardTechnical();
    Implement({
        url: '/barsroot/api/teller/teller/DocsAndTechnicalSubmit',
        data: { Sql: funcName, Method: 'technicalbuttonsubmit' },
        error: DefaultError,
        success: TechnicalButtonSubmitOnSuccess
    });
}

/// Отображение технических кнопок
function showTechnicalButtons() {
    if (!$('#teller-preloader').is(':visible'))
        showHide.showPreloader();
    
    closePopUp();
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/teller/teller/technical',
        success: function (data) {
            showHide.hidePreloaderItems();
            $('#teller-technical-btn-container').html(data);
        },
        error: DefaultError
    });
}

/// функция при успешной обработке события нажатия технической кнопки
function TechnicalButtonSubmitOnSuccess(result) {
    var message = result.P_errtxt ? result.P_errtxt : 'Успішно виконано!';
    message = message === '-99' || message === '99 -' ? 'АТМ недоступний: виконується операція' : message;
    var message_type = result.Result === 0 ? 'error' : 'info';
    $('#technical-buttons-window').css('z-index', zElementIndex.up);
    showHide.hidePreloaderItems();
    showNotification(message, message_type, result.P_errtxt);
}

/// Показ всплывающего окна в header
function showTeller() {
    var tellerOn = $('#btnTeller').hasClass('btn_teller_on');
    if (tellerOn) {
        showHide.showPreloaderItems();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: '/barsroot/api/teller/teller/tellerStatus',
            success: function (data) {
                showHide.hidePreloader();
                if (data.TellerInfo && data.tellerStatus) {
                    $('#teller-info').html(data.TellerInfo);
                    $('#teller-status').html(data.tellerStatus);
                    var toHide = data.IsButtonVisible === 0 ? 'none' : 'block';
                    showHide.showHideElements(['#btnSbon', '#technicalBtn'], toHide);
                }
                showTellerWindow();
            },
            error: function (err) {
                showHide.hidePreloader();
                showNotification("", 'error');
            }
        });
    }
    else {
        showActivateTellerWindow('Активувати Теллера?', true);
    }
}

/// закрытие активного окна
function closeActivateTellerWindow() {
    showHide.showHideElements(['#atm-confirm'], 'none');
    $('#atm-window').css('z-index', zElementIndex.up);
    if (!$('#atm-window').length && !$('#encashment-window').length && !$('#encashment-window').length)
        showHide.hidePreloader();
    else
        showHide.hidePreloaderItems();
    if ($('#encashment-window').length)
        $('#encashment-window').css('z-index', zElementIndex.up);
}

/// показ активного окна
function showActivateTellerWindow() {
    var tellerOn = $('#btnTeller').hasClass('btn_teller_on');
    var text = tellerOn ? 'Деактивувати Теллера?' : 'Активувати Теллера?';
    var active = tellerOn? false: true;
    showHide.showPreloader();
    showHide.hidePreloaderItems();
    showHide.showHideElements(['#atm-confirm'], 'none');
    CheckTellerProcesses(text, active);
    closePopUp();
}

/// Проверка незавершенных действий
function CheckTellerProcesses(text, active) {
    if (!active) {
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: '/barsroot/api/teller/teller/CheckTellerProcesses',
            success: function (result) {
                // Если присутствуют незавершенные операции или остатки в кассе  
                if (result !== null && result.P_errtxt.length > 0 && result.Result === 0)
                    showNotification(result.P_errtxt, 'error');
                // подтверждение об деактивации теллера и невозможности активации в текущую банковскую дату
                else {
                    text = '<span style=\'color:red;\'>УВАГА!</span><span> Повторна активація теллера в банківському дні ' + result.P_errtxt + ' буде неможливою. <br/><br/>Деактивувати теллера?</span>';
                    confirmWindow({ func: 4, text: text, value: active });
                }
            },
            error: DefaultError
        });
    }
    else
        confirmWindow({ func: 4, text: text, value: active });
}

/// Закрытие всплывающего окна в хедере
function closePopUp() {
    var butt = $('#btnTeller');
    if (butt.hasClass('active'))
        $.fn.popupBox('close', { onClose: function () { butt.removeClass('active'); } });
}

/// активировать Теллер
function activateTeller(activate) {
    showHide.showPreloaderItems_HideConfirm();
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/api/teller/teller/setteller',
        data: JSON.stringify({ IsTeller: activate }),
        success: function (result) {
            showHide.hidePreloaderItems();
            $('#main').loader();
            document.location.href = document.location.href;
        },
        error: DefaultError
    });

}

/// Показать информационное окно
function showTellerWindow() {
    showHide.showPreloader();
    showHide.hidePreloaderItems_CloseConfirm();
    var butn = $('#btnTeller');
    $('.toolbar a').not(butn).removeClass('active');
    if (!butn.hasClass('active')) {
        $('#userTeller').popupBox({
            selector: butn, rightMargin: 185, css: { right: '200px' }, onClose: OnPopUpClose
        });
        butn.addClass('active');
        $('#userTeller').css('width', 'auto');
        $('#userTeller').css('height', 'auto');
        $('.popupBox').css('width', 'auto');
    } else {
        $.fn.popupBox('close', { onClose: OnPopUpClose });
    }
}

/// Показать окно для работы с АТМ
function showATMWindow() {
    if ($('#atm-window', $('#mainFrame')[0].contentWindow.document).length) {
        showHide.hidePreloaderItems();
        showNotification('Вікно роботи з АТМ вже запущене');
        return;
    }
    closePopUp();
    TellerWindow();
}

/// При закрытии информационного окна
function OnPopUpClose() {
    var butn = $('#btnTeller');
    butn.removeClass('active');
    if (!$('#atm-window').length && !$('#encashment-window').length && !$('#encashment-window').length)
        showHide.hidePreloader();
}

/// Показ окна с перечнем технических кнопок
function CloseTechnicalWindow() {
    if (!$('#atm-window').length)
        showHide.hidePreloader();
    else
        showHide.hidePreloaderItems();
    if ($('#technical-buttons-window').length)
        $('#technical-buttons-window').css('z-index', 1000);
    $('#teller-technical-btn-container').empty();
}







