/// action:
/// list - список вариантов для инкассации (полное (извлечение), частичное (извлечение), внесение)
/// form или любое другое значение - показ формы для инкассации
function showEncashmentWindow(action) {
    var url = action === 'list' ? '/barsroot/teller/teller/encashmentlist' : '/barsroot/teller/teller/encashmentform';
    showHide.showPreloaderItems();
    closePopUp();
    $.ajax({
        type: "POST",
        url: url,
        success: function (result) {
            showHide.hidePreloaderItems();
            $('#teller-encashment-window-container').html(result);
        },
        error: DefaultError
    });
}

/// Показ окна с перечнем не привязанніх операций
function showIncompleteOpers() {
    showHide.showPreloaderItems();
    closePopUp();
    $.ajax({
        type: "POST",
        url: '/barsroot/teller/teller/IncompleteOpers',
        success: function (result) {
            showKendoWindow("Завершення операцій", result);
        },
        error: DefaultError
    });
}

/// Показ всплывающего окна Kendo
function showKendoWindow(title, content) {
    showHide.hidePreloaderItems();
    if (!$("#incomplete-container").length) {
        $('body').append("<div id='incomplete-container'></div>");
    }
    $("#incomplete-container").html(content);
    $("#incomplete-container").kendoWindow({
        width: "80%",
        height: '80%',
        title: title,
        visible: false,
        actions: ["Close"],
        close: function (e) {
            $("#incomplete-container").empty();
            if ($('#atm-window').length || $('#encashment-window').length || $('#technical-buttons-window').length) {
                $('#preloader').css('z-index', zElementIndex.down);
                showHide.hidePreloaderItems();
            }
            else
                showHide.hidePreloader();
        }
    }).data("kendoWindow").center().open();
}

/// Привязка данных с АТМ к операции
function resolveATMFault(atmId, tellerId) {
    var url = '/barsroot/api/teller/teller/ResolveATMFault?atmId=' + atmId + '&tellerId=' + tellerId;
    $.ajax({
        type: "POST",
        url: url,
        success: function (result) {
            if (result.Result == 0) {
                bars.ui.alert({
                    text: 'Виконано успішно!',
                    close: function (e) {
                        $("#incomplete-opers").data("kendoGrid").dataSource.read();
                    }
                });
            }
            else if (result.Result == 1) {
                bars.ui.error({
                    text: result.P_errtxt
                });
            }
        },
        error: DefaultError
    });
}

/// Показ окна для инкассации
function EncashmentWindow(encashmentType) {
    $('#preloader').css('z-index', zElementIndex.up);
    showHide.showPreloaderItems();
    $('#teller-encashment-window').css('z-index', zElementIndex.down);
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/teller/teller/EncashmentWindow',
        data: JSON.stringify({ data: encashmentType }),
        success: function (result) {
            $('#teller-encashment-window').css('z-index', zElementIndex.up);
            showHide.hidePreloaderItems();
            $('#preloader').css('z-index', zElementIndex.down);
            $('#teller-encashment-window-container').html(result);
            if (encashmentType === 'PARTIAL') {
                OnDropDownChange();
                $('#currency-dropdown').change(function () { OnDropDownChange(); });
            }
            //countTempo(encashmentType);
            showHide.showHideElements(['#teller-encashment-window-container'], 'block');
        },
        error: function (err) {
            CloseEncashmentWindow(true);
            showNotification("", 'error');
            $('#teller-encashment-window').css('z-index', zElementIndex.up);
        }
    });
}

/// Проверка - нет ли незаконченных операций
/// Если нет - показ окна инкассации (функция showEncashmentWindow)
function loadEncashmentWindow(encashmentType) {
    var operation = encashmentType === 'INPUT' ? 'I' : 'O';
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/api/teller/teller/IfEncashmentAlowed?operation=' + operation,
        success: function (result) {
            if (result === true)
                EncashmentWindow(encashmentType);
            else {
                showHide.showPreloader();
                showHide.hidePreloaderItems();
                $('#teller-encashment-window-container').html('');
                $('#atm-confirm-txt').text('Є незавершені операції! Продовжити?');
                showHide.showHideElements(['#atm-confirm'], 'block');
                $('#atm-confirm-close').unbind('click');
                $('#preloader').css('z-index', zElementIndex.down);
                $('#atm-confirm').css('z-index', zElementIndex.up);
                $('#atm-confirm-close').click(function () {
                    $('#preloader').css('z-index', zElementIndex.up);
                    showHide.showHideElements(['#atm-confirm'], 'none');
                    EncashmentWindow(encashmentType);
                });
                //showHide.showHideElements(['#teller-confirm-window'], 'block');
            }
        },
        error: function (err) {
            CloseEncashmentWindow(true);
            showNotification("", 'error');
        }
    });
}



///Закрытие окна инкассации
function CloseEncashmentWindow(encashmentType) {
    closePopUp();
    var key = $('#in-cashin-started').val();
    var nonAmount = +parseFloat($('#nonAmount_tempo').val()).toFixed(2);
    var tempo = +parseFloat($('#tempo-input').val()).toFixed(2);
    if ((key === "0" || !$('#in-cashin-started').length) && (tempo.toString() === 'NaN' || nonAmount === tempo)) {
        $('#teller-encashment-window-container').html('');
        $('#currency-dropdown').unbind('change');
        if ($('#atm-window').length || $('#encashment-window').length || $('#technical-buttons-window').length) {
            $('#preloader').css('z-index', zElementIndex.down);
            showHide.hidePreloaderItems();
        }
        else
            showHide.hidePreloader();
    }
    else if (tempo.toString() !== 'NaN' && nonAmount !== tempo)
        showNotification("Відміна процесу неможлива. Сума темпокаси не відповідає початковому значенню. Завершіть будь ласка інкасацію");
    else {
        $('#preloader').css('z-index', zElementIndex.middle);
        showNotification("Відміна процесу неможлива. Завершіть будь ласка інкасацію");
    }
}

/// Обработчик события нажатия на кнопку инкассации через АТМ:
/// Первое нажатие - выполняется фкункция StartCashin
/// Последующие нажатия - выполняется функция StoreCashin
function OnCashinClick() {
    var started = $('#in-cashin-started').val();
    if (started === '0')
        StartCashin();
    else
        StoreCashin();
}

/// Начало операции инкассации
function StartCashin(btn) {
    if ($('#cashin-btn').hasClass(colorGray))
        return;
    $('#currency-dropdown').prop('disabled', true);
    $('#encashment-window').css('z-index', zElementIndex.down);
    var curr = $('#currency-dropdown').val();
    $('#currency-dropdown').prop('disabled', 'disabled');
    showHide.showPreloaderItems();
    
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/teller/telleratm/Cashin',
        data: JSON.stringify({ Currency: curr, Method: 'Start_Cashin' }),
        success: function (result) {
            if (result.model) {
                if (result.model.Result == 1) {
                    $('#start-cashin-btn').removeClass(colorBlue).addClass(colorGray);
                    $('#store-cashin-btn').removeClass(colorGray).addClass(colorBlue);
                    $('#end-cashin-btn').removeClass(colorGray).addClass(colorBlue);
                    $('#cancel-cashin-btn').removeClass(colorGray).addClass(colorRed);
                    $('#in-cashin-started').val("1");
                    $('#cashin-btn').text('Підтвердити внесення');
                    $('#end-cashin-btn').hide();
                    $('#disabled-btn').text('Підтвердити');
                    $('#disabled-btn').show();
                }
                $('#encash-info').html(result.model.P_errtxt);
                showNotification(result.model.P_errtxt);
            }
            if (result.statusCode === 500) {
                showNotification("", 'error');
                showHide.hidePreloaderItems();
            }
            intervalObj.Stop();
            $('#encashment-window').css('z-index', 500);
        },
        error: function (err) {
            showNotification("", 'error');
            intervalObj.Stop();
            $('#encashment-window').css('z-index', 500);
        }
    });
    intervalObj.Run(GetStatus, 500);
}

/// Продолжение операции инкассации (повторное внесение или накручивание наличных с временного контейнера на барабаны)
function StoreCashin(btn) {
    if ($('#cashin-btn').hasClass(colorGray))
        return;    
    //var interval = new StatusInterval();
    $('#encashment-window').css('z-index', zElementIndex.down);
    showHide.showPreloaderItems();
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/teller/telleratm/Cashin',
        data: JSON.stringify({ method: 'StoreCashin' }),
        success: function (result) {
            $('#end-cashin-btn').show();
            $('#disabled-btn').hide();
            var tempo = parseFloat($('#tempo-input').val()).toFixed(2);
            var txt = '';
            intervalObj.Stop();
            if (result.statusCode === 500 && result.P_errtxt) {
                showNotification(result.P_errtxt, 'error');
                return;
            }
            if (!isNaN(tempo)) {
                txt = 'Темпокаса: ' + tempo + '<br/>' + result.model.P_errtxt;
                if ($('#end-cashin-btn').hasClass(colorGray)) {
                    $('#end-cashin-btn').removeClass(colorGray);
                    $('#end-cashin-btn').addClass(colorGreen);
                }
            }
            else {
                txt = 'Темпокаса: невірне або не задане значення<br/>' + result.model.P_errtxt;
                if (!$('#end-cashin-btn').hasClass(colorGray)) {
                    $('#end-cashin-btn').removeClass(colorGreen);
                    $('#end-cashin-btn').addClass(colorGray);
                }
            }
            $('#encash-info').html(txt);
            showNotification(result.model.P_errtxt);
            $('#encashment-window').css('z-index', 500);
        },
        error: function (err) {
            showNotification("", 'error');
            intervalObj.Stop();
            $('#encashment-window').css('z-index', 500);
        }
    });
    intervalObj.Run(GetStatus, 500);
}

/// Закрытие окна инкассяции при переходе на TOX
function CloseCarryingOut() {
    $('#teller-encashment-window-container').empty();
    showHide.hidePreloader();
}

/// Операция внесения наличных (к примеру в АТМ)
function endCashin(encashingType) {
    if ($('#end-cashin-btn').hasClass(colorGray))
        return;
    intervalObj.Stop();
    $('#encashment-window').css('z-index', zElementIndex.down);
    showHide.showPreloaderItems();
    var tempo = parseFloat($('#tempo-input').val()).toFixed(2);
    var curCode = $('#currency-dropdown').val();
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/api/teller/teller/Encashment',
        data: JSON.stringify({ nonAmount: tempo, currency: curCode, method: 'EndCashin', EncashmentType: encashingType }),
        success: function (result) {
            onEncashmentResult(result.Result, result.P_errtxt, true);
            if (result.Result === OK)
                $('#in-cashin-started').val("0");
        },
        error: DefaultError
    });
}

/// Формирование операции для проводки инкассации через ТОХ (Вилучення)
function endCashout(type) {
    if ($('#end-cashin-btn').hasClass(colorGray))
        return;
    $('#encashment-window').css('z-index', zElementIndex.down);
    showHide.showPreloaderItems();
    var tempo = +parseFloat($('#tempo-input').val()).toFixed(2);
    var curCode = $('#currency-dropdown').val();
    var nonAtm = +parseFloat($('#nonAmount_tempo').val()).toFixed(2);
    if (tempo > nonAtm) {
        showNotification('Перевищено ліміт темпокаси<br/>Сума в темпокасі: ' + nonAtm + '<br/>Сума запиту: ' + tempo, 'error');
        return;
    }
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/api/teller/teller/Encashment',
        data: JSON.stringify({ NonAmount: tempo, Currency: curCode, Method: 'EndCashOut', EncashmentType: type }),
        success: function (result) {
            onEncashmentResult(result.Result, result.P_errtxt, true);
        },
        error: DefaultError
    });
}

/// Функция для показа сообщений при инкассации
function onEncashmentResult(result, text, emptyContainer) {
    if (result === 1) {
        $('#in-cashin-started').val("0");
        showNotification(text);
    }
    else if (result === 0)
        showNotification(text, 'error');
    $('#encash-info').html(result.p_errtxt);
    if (emptyContainer)
        $('#teller-encashment-window-container').empty();
}

/// отмена инкассации
function CancelCashin(btn) {
    $('#encashment-window').css('z-index', zElementIndex.down);
    showHide.showPreloaderItems();
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/api/teller/teller/Encashment',
        data: JSON.stringify({ Method: 'CancelCashin' }),
        success: function (result) {
            onEncashmentResult(result.Result, resulr.P_errtxt, false);
        },
        error: DefaultError
    });
}

/// Показ окна для подтверждения отмены инкассации
function showConfirmCloseEncashinWindow() {
    $('#encashment-window').css('z-index', zElementIndex.down);
    $('#teller-confirm-txt').text('Відмінити операцію?');
    $('#atm-confirm-close').unbind('click');
    $('#atm-confirm-close').click(function () { CancelCashin($('#cancel-cashin-btn')); });
    showHide.showHideElements(['#teller-confirm-window'], 'block');
}

/// Сумма темпокассы
function countTempo(encashmentType) {
    var isValid = checkOnValidFields();
    var max = +parseFloat($('#nonAmount_tempo').val()).toFixed(2);
    //if (isValid === true) {
    //    var tempo = +parseFloat($('#tempo-input').val()).toFixed(2);
    //    var encashType = $('#encashment-type').val();
    //    if (encashType !== 'INPUT' && tempo > max) {
    //        blockEndCashin(true, 'Введена сума перевищує наявну: максимальна сума ' + max);
    //        return;
    //    }
    //    blockEndCashin(false, 'Сума темпокаси: ' + tempo);
    //}
    //else
    //    blockEndCashin(true, 'Сума темпокаси не відповідає числовому значенню');

}

/// Проверка на валидность введенных данных
function checkOnValidFields() {
    var tempoInput = $('#tempo-input').val();
    if (tempoInput === '') {
        tempoInput = parseFloat($('#nonAmount_tempo').val()).toFixed(2);
        $('#tempo-input').val(tempoInput);
    }
    var tempo = parseFloat(tempoInput).toFixed(2);
    if (isNaN(tempo))
        return false;
    if ($('.available-sum').length) {
        var list = $('.available-sum');
        for (var i = 0; i < list.length; ++i) {
            var item = list[i];
            if (isNaN($(item).val()))
                return false;
        }
    }
    return true;
}

//TODO: сменить перемену классов на смену кнопок
/// Блокировка кнопки конца инкассации
function blockEndCashin(value, text) {
    if (value === true)
        $('#end-cashin-btn').removeClass(colorGreen).addClass(colorGray);
    else if ($('#end-cashin-btn').hasClass(colorGray))
        $('#end-cashin-btn').removeClass(colorGray).addClass(colorGreen);
    $('#encash-info').html(text);
}

/// получение объекта с перечнем количества выбранных купюр, их номиналов и кода валюты
function GetPartialEncashinObj() {
    var data = [];
    var curCode = $('#currency-dropdown').val();
    var list = $('.available-sum');
    for (var i = 0; i < list.length; ++i) {
        var count = parseInt($(list[i]).val());
        var item = $('.available-nom')[i];
        var nominal = $(item).text();
        data.push({ cur_code: curCode, nominal: nominal, count: count });
    }
    return data;
}

/// событие обработки для частичной инкассации из АТМ
function OnPartialCashin() {
    if ($('#cashin-btn').hasClass(colorGray))
        return;
    $('#encashment-window').css('z-index', zElementIndex.down);
    $('#currency-dropdown').prop('disabled', 'disabled');
    showHide.showPreloaderItems();
    var data = GetPartialEncashinObj();
    var currency = $('#currency-dropdown').val();
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/api/teller/teller/CollectPartial',
        data: JSON.stringify({ List: data, Currency: currency }),
        success: function (result) {
            if (result.Result === OK) {
                showNotification(result.P_errtxt);
                $('#t-conversion').val('1');
                UpdateCashCount();
                $('#in-cashin-started').val('1');
            }
            else if (result.Result === ERROR)
                showNotification(result.P_errtxt, 'error');
            $('#encash-info').html(result.P_errtxt);
            $('#encashment-window').css('z-index', zElementIndex.up);
            showHide.hidePreloaderItems();
        },
        error: DefaultError
    });
}

/// обработка события при изменении  валюты при инкассировании
function OnDropDownChange() {
    $('#t-conversion').val('0');
    UpdateCashCount();
}

/// Пересчет денег после смены валюты или частичной инкассации из АТМ
function UpdateCashCount() {
    var data = $('#currency-dropdown').val();
    $('#encashment-window').css('z-index', zElementIndex.down);
    showHide.showPreloaderItems();
    var isConversion = +$('#t-conversion').val();
    var permission = $('#t-permission').val();
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/teller/teller/ATMCurrency?permission=' + permission + '&code=' + data,
        //data: JSON.stringify({ code: data, premission: permission }),
        success: function (result) {
            showHide.hidePreloaderItems();
            $('#nominals-container').html(result);
            showHide.showHideElements(['#nominals-container'], 'block');
            $('#encashment-window').css('z-index', zElementIndex.up);
            $('#nonAmount_tempo').val($("#nonAtm").val());
            if (isConversion === 0) {
                var nonAtm = parseFloat($("#nonAtm").val()).toFixed(2);
                $("#tempo-input").val(nonAtm);
            }
            CalculateSum();
        },
        error: DefaultError
    });
}

/// Операция инкассации
function OnCashin() {
    $('#encashment-window').css('z-index', zElementIndex.down);
    showHide.showPreloaderItems();
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/api/teller/teller/Encashment',
        data: JSON.stringify({ method: 'collectatm' }),
        success: function (result) {
            showNotification(result.P_errtxt);
            showHide.hidePreloaderItems();
            showHide.showHideElements(['#nominals-container'], 'block');
            $('#encashment-window').css('z-index', zElementIndex.up);
        },
        error: DefaultError
    });
}

/// Обработка события пересчета суммы в окне инкассации
function CalculateSum() {
    countTempo('PARTIAL');
    if ($('#end-cashin-btn').hasClass('atm-color-gray'))
        return;
    var list = $('.available-sum');
    var sum = 0;
    for (var i = 0; i < list.length; ++i) {
        var str = $(list[i]).val();
        if (str === '' || str === undefined) {
            str = '0';
            $(list[i]).val(str);
        }
        var tmp = parseInt(str);
        if (tmp < 0) {
            $(list[i]).val('0');
            tmp = 0;
        }
        var nominal = 0;
        var item = $('.available-nom')[i];
        if (isNaN(tmp)) {
            nominal = $(item).text();
            blockEndCashin(true, 'Кількість номіналу "' + nominal + '" не відповідає числовому');
            return;
        }
        else {
            var countItem = $('.available-count')[i];
            var count = +$(countItem).text();
            nominal = +$(item).text();
            if (count < tmp) {
                tmp = count;
                var avSumItem = $('.available-sum')[i];
                $(avSumItem).val(tmp);
            }
            sum += (nominal * tmp);
        }
    }
    blockEndCashin(false);
    
    //var role = $('#t-role').val();
    //if (role === "Tempockassa") {
    //    sum = $('#tempo-input').val();
    //    $('#encash-info').html('Загальна сума з Темпокаси: ' + sum);
    //}
    //else if(role === "Teller")
    //    $('#encash-info').html('Загальна сума з АТМ: ' + sum);
}

// отображение кнопок для проведения операций через ТОХ
function displayTOXButtons(data) {
    if (data && data.Oper_status === '-') {
        var link = "\/barsroot\/docinput\/docinput.aspx?tt=TOX&SumC=" + data.Amount + "&Kv_A=" + data.Cur_code + "&IsTEnc=1&TOperRef=" + data.Id + "&TPurpose=" + data.Cash_direction;
        return "<a class='atm-button atm-color-blue' style='width:80px; padding: 4px; margin-left: 13px;' onclick='go(\"" + link + "\",this); CloseCarryingOut(); return false;'>Провести</a>";
    }
    return data.Doc_ref;
}


