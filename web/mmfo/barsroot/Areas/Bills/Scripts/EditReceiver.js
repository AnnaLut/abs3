var buildObj = {}; // вспомогательного объект с шаблонными методами
var requestValues = { 'printBill': 'print', 'updateBill': 'update', 'getResolution': 'get', 'setRecRecReq': 'req' }; // список ид кнопок для блокировки/разблокировки
var keyCodes = { '48': 0, '49': 1, '50': 2, '51': 3, '52': 4, '53': 5, '54': 6, '55': 7, '56': 8, '57': 9 }; // кода клавишь цыфр клавиатуры
var signId = 0;
var signType = '';
var signBaseUrl = '/barsroot/api/bills/bills/';
var receiverObj = {};
var editableObjts = {};
var fieldsTitle = {};

(function () {
    buildObj = new RecObject(); // инициализация вспомогательного объекта
    $('#update_form').submit(function (e) { //отмена отправки данных формы при нажатии на кнопку!
        e.preventDefault();
    });
    buildObj.receiverItems(); // обновление/инициализация объекта с данными о клиенте
    buildObj.initButtons();  // блокировка/разблокировка кнопок в соответствии со статусами о клиенте

    // осистка элементов для коминтариев в случае если клиент не зарезервирован банком в ДКСУ
    var req_id = $('#REQ_ID').val();
    if (req_id === '')
        $("#comments").empty();

    // инициализация элемента для работі с датой 
    $("#DOC_DATE").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: date,
        dateInput: true
    });

    // отслеживание события нажатия на клавишу клавиатуры
    $(document).keyup(function (e) {
        // если была нажата кнопка ESC и нажата не на всплывающем окне - закрыть данное всплывающее окно
        if (e.keyCode === 27 && e.target.id !== 'createWindow' && e.target.id !== 'barsUiConfirmDialog' && e.target.id !== 'barsUiErrorDialog' && e.target.id !== 'barsUiAlertDialog') {
            window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
        }
    });

    // получение списка редактируемых полей
    getEditableObjects();

    // отслеживание события на изменение поля
    $('.editable').on('change', function (e) {
        OnEditField(e);
    });

    // событие нажатия на клавишу в поле для ввода даты
    $('#DOC_DATE').bind('keypress', function (e) {
        onKeyPressEvent(e);
    });

    // обработка нажатий клавиш 'Backspace' и 'Delete'
    $('#DOC_DATE').bind('keydown', function (e) {
        var keyCode = (e.keyCode ? e.keyCode : e.which);
        var itemObj = e.currentTarget; // полусение объекта для поля даты
        var objText = $('#DOC_DATE').val(); // текст ранее введенной даты
        // если нажата кнопка 'Delete' или 'Backspace'
        if (keyCode === 46 || keyCode === 8) {
            e.stopPropagation();
            e.preventDefault();
            // если поля объекта существуют (chrome)
            if (itemObj.selectionStart && itemObj.selectionStart >= 0) {
                // начальное и конечное значение каретки
                var start = +itemObj.selectionStart;
                var end = +itemObj.selectionEnd;
                var str = '';
                if (start <= objText.length) {
                    for (var i = 0; i < objText.length; ++i) {
                        if (keyCode === 46 && start !== i && objText[i] !== '.')
                            str += objText[i];
                        else if (keyCode === 8 && start - 1 !== i && objText[i] !== '.')
                            str += objText[i];
                        if (str.length === 2 || str.length === 5)
                            str += '.';
                    }
                    $('#DOC_DATE').val(str);
                    var itemObj = e.currentTarget;
                    if (keyCode === 8 && start > 0)
                        start--;
                    itemObj.selectionStart = start;
                    itemObj.selectionEnd = start;
                }
            }
            else if (document.selection) {
                itemObj.focus();
                var range = document.selection.createRange(); // получение объекта выделенной строки
                var objRange = itemObj.createTextRange(); // получение объекта не выделенной строки (весь текст)
                // если объект выделенной строки пустой
                if (range === null || range === 'undefined')
                    return;
                var strt = -range.moveStart("character", -objText.length); // позиция каретки
                var str = '';
                if (strt <= objText.length) {
                    for (var i = 0; i < objText.length; ++i) {
                        if (keyCode === 46 && strt !== i && objText[i] !== '.')
                            str += objText[i];
                        else if (keyCode === 8 && strt - 1 !== i && objText[i] !== '.')
                            str += objText[i];
                        if (str.length === 2 || str.length === 5)
                            str += '.';
                    }
                    $('#DOC_DATE').val(str);
                    objRange.collapse(true);
                    if (keyCode === 8 && strt > 0)
                        strt--;
                    objRange.moveStart('character', strt);
                    objRange.select();
                }
            }
        }
        else if (keyCode >= 65 && keyCode <= 90) {
            e.stopPropagation();
            e.preventDefault();
        }
        else {
            onKeyPressEvent(e);
        }
        if ($('#DOC_DATE').val() !== editableObjts['DOC_DATE'].value)
            editableObjts['DOC_DATE'].edited = 1;
        else
            editableObjts['DOC_DATE'].edited = 0;
        enableOrDisableSaveButton();
        checkRequiderFields('DOC_DATE', true);
    });

    // заполнение данных информации о полях для редактирования
    fieldsTitle = {
        'NAME': { text: 'ПІБ/Найменування', req: true },
        'INN': { text: 'ІПН/ЄДРПОУ', req: true },
        'DOC_DATE': { text: 'Дата видачі документа', req: false },
        'DOC_NO': { text: 'Номер документу', req: false },
        'DOC_WHO': { text: 'Ким виданий', req: false },
        'PHONE': { text: 'Контактний телефон', req: false },
        'ADDRESS': { text: 'Адреса', req: false },
        'ACCOUNT': { text: 'Рахунок для перерахування', req: true }
    };

    IfCustomerTypeChanged();
})();

// Обработка события нажатия клавиши в поле с датой
function onKeyPressEvent(e) {
    var keyCode = (e.keyCode ? e.keyCode : e.which); // код нажатой кнопки
    var item = keyCodes[keyCode]; // значение нажатой кнопки
    // если значение числовое (получение из масива хранимого только часла)
    if (item !== undefined && item !== null) {
        // остановка всех действий (изменение данных)
        e.stopPropagation();
        e.preventDefault();

        var itemObj = e.currentTarget; // полусение объекта для поля даты
        var value = $('#DOC_DATE').val(); // текст поля
        if ((itemObj.selectionStart || itemObj.selectionStart === 0) && itemObj.selectionStart >= 0 && itemObj.selectionStart < value.length && value.length < 10) {
            // начальное и конечное значение каретки
            var start = +itemObj.selectionStart;
            var end = +itemObj.selectionEnd;
            var str = '';
            for (var i = 0; i < value.length; ++i) {
                if (start === i)
                    str += item;
                if (str.length === 2 || str.length === 5)
                    str += '.';
                if (value[i] !== '.')
                    str += value[i];
                if (str.length === 2 || str.length === 5)
                    str += '.';
            }
            $('#DOC_DATE').val(str);
            ++start;
            itemObj.selectionStart = start;
            itemObj.selectionEnd = start;
            return;
        }
        else if (document.selection) {
            itemObj.focus();
            var range = document.selection.createRange(); // получение объекта выделенной строки
            var objRange = itemObj.createTextRange(); // получение объекта не выделенной строки (весь текст)
            // если объект выделенной строки пустой
            if (range === null || range === 'undefined')
                return;
            var objText = $('#DOC_DATE').val(); // текст ранее введенной даты
            var strt = -range.moveStart("character", -objText.length); // позиция каретки
            if (strt >= 0 && strt < value.length && value.length < 10) {
                var str = '';
                for (var i = 0; i < value.length; ++i) {
                    if (strt === i)
                        str += item;
                    if (str.length === 2 || str.length === 5)
                        str += '.';
                    if (value[i] !== '.')
                        str += value[i];
                    if (str.length === 2 || str.length === 5)
                        str += '.';
                }
                $('#DOC_DATE').val(str);
                objRange.collapse(true);
                ++strt;
                objRange.moveStart('character', strt);
                objRange.select();
                return;
            }
        }
        if (value.length === 2 || value.length === 5) // если необходимо поставить точку после ввода числа или месяца
            $('#DOC_DATE').val(value + '.' + item);
        else if (value.length < 10) // если длинна меньше длинны заполненной даты
            $('#DOC_DATE').val(value + item);
        // если поля объекта существуют (chrome)
        if (itemObj.selectionStart || itemObj.selectionStart >= 0) {
            // начальное и конечное значение каретки
            var start = +itemObj.selectionStart;
            var end = +itemObj.selectionEnd;
            // если начальное значение стоит в конце заполненной даты
            if (start === 10)
                return;
            // исли строка не была выделена, а просто стоит каретка
            if (start === end && start < value.length) {
                // если каретка стоит перед точкой
                if (start === 2 || start === 5)
                    start++;
                // если каретка стоит вначале
                if (start === 0)
                    value = item + value.substr(1);
                else // если каретка стоит не в начале
                    value = value.substr(0, start) + item + value.substr(start + 1);
                $('#DOC_DATE').val(value);
                // перемещаем каретку на одну позицию вперед
                start++;
                itemObj.selectionStart = start;
                itemObj.selectionEnd = start;
                return;
            }
            // если строка была выделена
            if (itemObj.selectionStart < 10 && itemObj.selectionStart !== itemObj.selectionEnd) {
                // если начальная позиция каретки находится перед точкой
                if (start === 2 || start === 5) {
                    itemObj.selectionStart = start + 1;
                    start++;
                }
                // если начальная позиция каретки не находится перед точкой
                if (start !== 2 || start !== 5) {
                    value = value.substr(0, start) + item + value.substr(start + 1);
                    $('#DOC_DATE').val(value);
                    itemObj.selectionStart = start + 1;
                    itemObj.selectionEnd = end;
                }
            }
        }
        // если IE
        else if (document.selection) {
            itemObj.focus();
            var range = document.selection.createRange(); // получение объекта выделенной строки
            var objRange = itemObj.createTextRange(); // получение объекта не выделенной строки (весь текст)
            // если объект выделенной строки пустой
            if (range === null || range === 'undefined')
                return;
            var objText = $('#DOC_DATE').val(); // текст ранее введенной даты
            if (objText.length < 10)
                objText = objText.substr(0, objText.length - 1);
            var text = range.text; // выделенный текст
            // если текст не был выделен (поставленна позиция каретки)
            if (text === '') {
                var strt = -range.moveStart("character", -objText.length); // позиция каретки
                // если позиция не в конце полной даты
                if (strt < 10) {
                    // если каретка не стоит перед точкой
                    if (strt === 2 || strt === 5)
                        strt++;
                    objText = objText.substr(0, strt) + item + objText.substr(strt + 1); // измененный текст
                    $('#DOC_DATE').val(objText);
                    // изменение позиции каретки на одну позицию в перед
                    objRange.collapse(true);
                    ++strt;
                    objRange.moveStart('character', strt);
                    objRange.select();
                }
                return;
            }
            var start = objText.indexOf(text); // начальная позиция выделенной строки
            var end = start + text.length; // конечна позиция выделенной строки
            // если выделение начинается с точки
            if (text.substr(0, 1) === '.')
                range.text = range.text.substr(0, 1) + item + range.text.substr(2);
            else // если выделение не начинается с точки
                range.text = item + text.substr(1);
            // если первый символ выделенной строки начинается на точку
            if (start === 2 || start === 5)
                start++;
            // изменений начальной позиции выделенной строки
            objRange.collapse(true);
            objRange.moveStart('character', start + 1);
            objRange.moveEnd('character', 10);
            objRange.select();
        }
    }
    else if (keyCode >= 65 && keyCode <= 90) {
        e.stopPropagation();
        e.preventDefault();
    }
}

// обработка события редактирования поля
function OnEditField(e) {
    var item = $(e.currentTarget)[0];
    var name = $(item).attr('name');
    var value = $(item).val();
    if (name !== null && name !== 'undefined' && name !== undefined) {
        if (editableObjts[name].value !== value && editableObjts[name].edited === 0)
            editableObjts[name].edited = 1;
        else if (editableObjts[name].value === value && editableObjts[name].edited === 1)
            editableObjts[name].edited = 0;
        if (!checkRequiderFields(name, true))
            editableObjts[name].edited = 0;
        if(name === 'CL_TYPE')
            IfCustomerTypeChanged();
        enableOrDisableSaveButton();
    }
}

// При изменении типа клиента
function IfCustomerTypeChanged() {
    var value = $('#CL_TYPE').val();
    var key = false;
    if (value === '1') // если тип клиента - физическое лицо
        key = true;
    fieldsTitle['DOC_DATE'].req = key;
    fieldsTitle['DOC_NO'].req = key;
    fieldsTitle['DOC_WHO'].req = key;
    checkRequiderFields('DOC_DATE', false);
    checkRequiderFields('DOC_NO', false);
    checkRequiderFields('DOC_WHO', false);
}

// Проверка на обязательные поля для заполнения
function checkRequiderFields(name, inform) {
    var value = $('#' + name).val();
    if (fieldsTitle[name] && fieldsTitle[name].req) {
        if (value.length === 0) {
            $('#' + name).css('border-color', 'red');
            if (name === 'DOC_DATE')
                $('.k-picker-wrap').css('border-color', 'red');
            return false;
        }
        else if ($('#' + name).css('border-color') === 'red' || $('#' + name).css('border-color') === 'rgb(255, 0, 0)') {
            $('#' + name).css('border-color', '#ccc');
            if (name === 'DOC_DATE')
                $('.k-picker-wrap').css('border-color', '#ccc');
        }
    }
    else if ($('#' + name).css('border-color') === 'red' || $('#' + name).css('border-color') === 'rgb(255, 0, 0)') {
        $('#' + name).css('border-color', '#ccc');
        if (name === 'DOC_DATE')
            $('.k-picker-wrap').css('border-color', '#ccc');
    }
    return true;
}

// если поле было изменено - разблокировать кнопку для сохранения данных
function enableOrDisableSaveButton() {
    var editableFieldsList = $('.editable');
    for (index in editableFieldsList) {
        var item = $(editableFieldsList[index]);
        if (item.attr('name')) {
            var name = item.attr("name");
            if (editableObjts[name].edited === 1) {
                editableObjts['save-button'].disabled = false;
                $('#update-btn').prop('disabled', false);
                $('#update-btn').css('background-color', '#3276b1');
                return false;
            }
        }
    }
    editableObjts['save-button'].disabled = true;
    buildObj.showHideButtons(false, ['update-btn']);
}

// проверка на наявность измененных полей
function ChechFieldsOnEdited() {
    var editableFieldsList = $('.editable');
    for (index in editableFieldsList) {
        var item = $(editableFieldsList[index]);
        if (item.attr('name')) {
            var name = item.attr("name");
            if (editableObjts[name].value !== item.val())
                editableObjts[name].edited = 1;
            else
                editableObjts[name].edited = 0;
        }
    }
    enableOrDisableSaveButton();
}

// функция получения списка и данных редактируемых полей
function getEditableObjects() {
    var editableFieldsList = $('.editable');
    for (index in editableFieldsList) {
        var item = $(editableFieldsList[index]);
        // получаем только те объекты в которых есть и заполнены аттрибуты name
        if (item.attr("name")) {
            var name = item.attr("name");
            editableObjts[name] = { "value": item.val(), "edited": 0 };
        }
    }
    editableObjts['save-button'] = { "disabled": true };
}

// сохранение измененных данных о пользователе (в регионе)
function EditReceiver() {
    // сериализация данных формы и переписывание значения даты для коректной привязки в c#
    var list = $('#update_form').serializeArray();
    var obj = {};
    var reqFields = true;
    for (var i = 0; i < list.length; ++i) {
        var name = list[i].name;
        if (!checkRequiderFields(name, false)) {
            if (reqFields)
                reqFields = false;
        }
        if ('DOC_DATE' === name && list[i].value.length > 0) {
            var arr = list[i].value.split('.');
            list[i].value = arr[2] + '-' + arr[1] + '-' + arr[0];
        }
        obj[name] = list[i].value;
    }
    obj["ACCOUNT"] = $('#ACCOUNT').val();
    if (!checkRequiderFields('ACCOUNT')) {
        if (reqFields)
            reqFields = false;
    }
    if (!reqFields) {
        bars.ui.error({
            text: 'Не всі поля бузи заповнені',
            close: function (e) {
                $(".k-overlay").remove();
            }
        });
        return false;
    }
    signId = buildObj.receiverItems().EXP_ID;

    receiverObj = obj;
    signType = 'updateReceiver';
    if (needSign === '1') // накладывать ЕЦП
        buildObj.popUp('/bills/bills/cryptor', 'Підписання!', '300px', '550px');
    else if (needSign === '0') // не накладывать ЕЦП
        buildObj.SendPostRequest('/barsroot/api/bills/bills/updatereceiver', obj, function(result) {
            if (result.status === 1) {
                bars.ui.alert({
                    text: 'Виконано успішно!',
                    close: function (e) {
                        getEditableObjects();
                        buildObj.showHideButtons(false, ['update-btn']);
                    }
                });
            }
            else {
                bars.ui.error({
                    text: result.err,
                    close: function (e) {
                        $(".k-overlay").remove();
                    }
                });
            }
        });
}

// отправка запроса в ДКСУ для регистрации текущего взыскателя за банком
function createRequest() {
    buildObj.onButtonClickEvent(hideCreateRequestButton, function (obj) {        
        var EXP_ID = buildObj.receiverItems().EXP_ID;
        var status = buildObj.receiverItems().STATUS;
        var statusRes = status === 'IN'; // статус полученных данных с ДКСУ но еще не зарезервированном банком
        hideCreateRequestButton(statusRes);
        if (!statusRes)
            buildObj.showHideButtons(true, ['scan-doc']);
        if (statusRes) {
            checkRequiredFields(EXP_ID);            
        }
    });
}

// Проверка обязательных полей
function checkRequiredFields(EXP_ID) {
    // Проверка на не пустое поле
    if ($('#INN').val().length === 0) {
        bars.ui.error({
            text: 'Поле "ІПН/ЄДРПОУ" є обов\'язковим для заповнення'
        });
        return;
    }
    else if ($('#ACCOUNT').val().length === 0) {
        bars.ui.error({
            text: 'Поле "Рахунок для перерахування" є обов\'язковим для заповнення'
        });
        return;
    }
    // проверка на несохраненные данные
    else if (!$('#update-btn').prop("disabled")) {
        bars.ui.error({
            text: 'Данні не збережено'
        });
        return;
    }
    // отправка запроса для регистрации взыскателя за банком
    SndCreateRequest(EXP_ID, 'CreateRq');
}

// обработка результата педписи
function onSign() {
    $('.k-overlay').css('z-index', '10005');

    //var url = signBaseUrl + signType === 'createRec' ? 'SaveCreateRequestSign' : 'SaveReceiver';
    var saveReceiverUrl = signBaseUrl + 'SaveReceiver';
    var getBufferUrl = '/barsroot/api/bills/bills/getbuffer/' + signId;
    var saveSignUrl = signBaseUrl + 'SaveCreateRequestSign';
    var iframe = $('#createWindow iframe')[0];
    var tokenIndex = $(iframe).contents().find('#ddSecDeviceType')[0].options.selectedIndex;
    var keyIndex = $(iframe).contents().find('#ddSecFiles')[0].options.selectedIndex;

    buildObj.SendPostRequest(saveReceiverUrl, receiverObj, function (result) {
        if (result.status === 1) {
            buildObj.SendPostRequest(getBufferUrl, null, function (result) {
                if (result.buffer !== null && result.buffer !== undefined && result.buffer.length > 0) {
                    var data = window.$sign.getSignData(tokenIndex, keyIndex, result.buffer, result.buffer);
                    window.$sign.signer.Sign(data, function (item) {
                        if (item.State === 'OK') {
                            var oper = JSON.parse(data).IdOper;
                            var signObj = { EXP_ID: signId, SIGNATURE: item.Sign, SIGNER: oper };
                            buildObj.SendPostRequest(saveSignUrl, signObj, function (result) {
                                $($('.k-window')[0]).fadeOut();
                                $($('.k-window')[0]).empty();
                                window.parent.$('.k-overlay').css('z-index', '10001');
                                buildObj.HideOverlay();
                                if (result.status === 1) {
                                    bars.ui.alert({
                                        text: 'Виконано успішно!',
                                        close: function (e) {
                                            var titleArr = $('.k-window > .k-header > .k-window-title');
                                            for (var i = 0; i < titleArr.length; ++i) {
                                                var title = $(titleArr[i]);
                                                if (title.length > 0 && $(title[0]).html() === 'Підписання!') {
                                                    $(title).parent().parent().fadeOut();
                                                    $(title).parent().parent().empty;
                                                }
                                            }
                                            getEditableObjects();
                                            buildObj.showHideButtons(false, ['update-btn']);
                                            if (setTimeout) {
                                                setTimeout(function () {
                                                    $('.k-overlay').remove();
                                                }, 500);
                                            }
                                        }
                                    });
                                }
                                else {
                                    bars.ui.error({
                                        text: result.err
                                    });
                                }
                            });
                        }
                        else if (item.State === 'Error') {
                            bars.ui.error({
                                text: item.Error
                            });
                        }
                        //buildObj.HideOverlay();
                    });
                }
            });
        }
        else {
            bars.ui.error({
                text: result.err
            });
            buildObj.HideOverlay();
        }
    });
}

// отправка данных в ДКСУ
function SendRequest(action) {
    buildObj.onButtonClickEvent(hideShowButtons, function (obj) { // стандартная обработка события при нажатии кнопки
        var EXP_ID = buildObj.receiverItems().EXP_ID;
        var status = buildObj.receiverItems().STATUS === "RQ" || buildObj.receiverItems().STATUS === 'RJ'; // статус зарезервированного получателя за банком (Запит відправлений в ДКСУ)
        if (status)
            SndCreateRequest(EXP_ID, action);
    });
}

// отправка запроса по нажатию на кнопку резервирования получателя за банком либо остаточное завершение редактирования
function SndCreateRequest(id, action) {
    $("<div class='k-overlay'></div>").appendTo($(document.body));
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/api/bills/bills/BillsRequest?method=CreateRequest&str=' + action + '&id=' + id,
        success: function (result) {
            $('.k-overlay').css('z-index', '10002');
            if (result.status === 1) {
                bars.ui.alert({
                    text: 'Виконано успішно!',
                    close: function (e) {
                        if (action === 'setRecRecReq' || action === 'CreateRq')
                            buildObj.updateData();                        
                    }
                });
            }
            else {
                bars.ui.error({
                    text: result.err
                });
            }
        },
        error: function (result) {
            $(".k-overlay").remove();
        }
    });
}

// заблокировать/разблокировать кнопку резервирования получателя за банком
function hideCreateRequestButton(show) {
    buildObj.showHideButtons(show, ['create-request-button']);
}

// заблокировать/разблокировать кнопки для получения заявления, отправки измененных данных на ДКСУ, завершение редактирования
function hideShowButtons(show) {
    var Ids = ['print-bill', 'update-bill', 'set-req-rec'];
    if (show) Ids.push('update-comments'); // если "show" имеет значение - true, тогда разблокировать кнопку обновления комментариев
    buildObj.showHideButtons(show, Ids);
}

// обработка запросов в зависимости от значения переменной value
// если = printBill - загрузка заявления на выплату из ДКСУ
// если = (другое)  - отправка текущего взыскателя в ЦА для добавления в ежемесячную выдержку
function billRequest(value) {
    buildObj.onButtonClickEvent(hideShowButtons, function (rows) {
        var ID = $('#EXP_ID').val();

        $("<div class='k-overlay'></div>").appendTo($(document.body));

        // получение заявления на оплату
        if (value === 'printBill') {
            buildObj.downloadPdf('/barsroot/bills/bills/printbillrequest/' + ID, function () {
                setTimeout(function () {
                    buildObj.HideOverlay();
                    buildObj.updateData();
                }, 500);
                buildObj.showHideButtons(true, ['print-bill', 'update-bill', 'set-req-rec', 'download-application', 'scan-doc', 'upload-scan-doc', 'update-comments', 'attach-application']);
            });
            return false;
        }

        var url = '/barsroot/api/bills/bills/BillsRequest?method=' + value + '&str=&id=' + ID;
        //
        bars.ui.confirm({
            title: 'У В А Г А!',
            text: 'Ви впевнені що бажаете змінити статус? Після підтвердження будь які зміни будуть неможливі!!'
        }, function () {
            if (setTimeout) {
                setTimeout(function () {
                    buildObj.HideOverlay(); // 
                    buildObj.updateData(); // 
                    $("<div class='k-overlay'></div>").appendTo($(document.body));
                }, 1000);
            }
            buildObj.SendPostRequest(url, null, onSuccessDefault); // 
        });
    });
}

// Объект для с часто используемыми методами
function RecObject() {
    var obj = {};
    // обновление данных
    this.reloadObj = function () {
        obj.ID = $('#ID').val();
        obj.EXP_ID = $('#EXP_ID').val();
        obj.REQ_ID = $('#REQ_ID').val();
        obj.APPLREADY = $('#APPLREADY').val();
        obj.RNK = $('#RNK').val();
        obj.STATUS = $('#STATUS').val();
        obj.SNDDOC = $('#SNDDOC').val();
        obj.STATUS_NAME = $('#STATUS_NAME');
    };

    // открытие popup
    this.popUp = function (url, title, height, width) {
        $("#windowContainer").append("<div id='createWindow'></div>");
        if (width === undefined)
            width = "800px";
        if (height === undefined)
            height = '450px';
        var createWindow = $("#createWindow").kendoWindow({
            width: width,
            height: height,
            title: title,
            visible: false,
            actions: ["Close"],
            iframe: true,
            modal: true,
            resizable: false,
            deactivate: function () {
                this.destroy();
            },
            content: bars.config.urlContent(url)
        }).data("kendoWindow");

        createWindow.center().open();
    };

    // получение объекта с данными
    this.receiverItems = function () {
        if ($.isEmptyObject(obj))
            this.reloadObj();
        return obj;
    };

    // событие нажатия на кнопку
    this.onButtonClickEvent = function (hideButtonsFunc, successFunc) {
        successFunc(obj);
    };

    // показ или скрытие кнопок
    this.showHideButtons = function (show, arr) {
        for (var i = 0; i < arr.length; ++i) {
            if (show) {
                $('#' + arr[i]).prop('disabled', false);
                $('#' + arr[i]).css('background-color', 'transparent');
            }
            else {
                $('#' + arr[i]).prop('disabled', true);
                $('#' + arr[i]).css('background-color', 'lightgray');
            }
        }
    };

    // отправка POST запроса
    this.SendPostRequest = function (url, data, successFunc) {
        $("<div class='k-overlay'></div>").appendTo($(document.body));
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8;",
            url: url,
            data: data,
            success: successFunc,
            error: function (result) {
                var errText = '';
                if (result.responseJSON && result.responseJSON.ExceptionMessage)
                    errText = result.responseJSON.ExceptionMessage;
                else if (result.responseText)
                    errText = result.responseText;
                else
                    errText = 'Виникла помилка при виконанні оперіції';
                bars.ui.error({
                    text: errText,
                    title: 'П О М И Л К А'
                });
                $(".k-overlay").remove();
            }
        });
    };

    // показ заднего фона
    this.ShowOverlay = function () {
        $("<div class='k-overlay'></div>").appendTo($(document.body));
    };

    // скрытие заднего фона
    this.HideOverlay = function () {
        $(".k-overlay").remove();
    };

    // обновление данных на view
    this.updateData = function () {
        this.SendPostRequest('/barsroot/api/bills/bills/GetReceiver/' + obj.EXP_ID, null, function (result) {
            $('#ID').val(result.ID);
            $('#EXP_ID').val(result.EXP_ID);
            $('#REQ_ID').val(result.REQ_ID);
            $('#APPLREADY').val(result.APPLREADY);
            $('#RNK').val(result.RNK);
            $('#STATUS').val(result.STATUS);
            $('#SNDDOC').val(result.SNDDOC);
            buildObj.reloadObj(); //
            buildObj.initButtons(); // 
            $(".k-overlay").remove();
            updateComments(); // 
        });
    };

    // скрытие или показ кнопок в зависимости от статуса
    this.initButtons = function () {
        hideCreateRequestButton(obj.STATUS === 'IN'); // 
        hideShowButtons(obj.STATUS === 'RQ' || obj.STATUS === 'RJ'); // 
        buildObj.showHideButtons(obj.APPLREADY === '1' && obj.STATUS === 'RQ' || obj.APPLREADY === '1' && obj.STATUS === 'RJ', ['download-application']); // 
        buildObj.showHideButtons(obj.STATUS !== 'IN', ["upload-scan-doc", 'attach-application', 'scan-doc']); // 
        if (obj.STATUS === 'XX') // 
            buildObj.showHideButtons(false, ['update-btn']);
    };

    // загрузка файла pdf
    this.downloadPdf = function (url, func) {
        var win = window.open(url, '_blank');
        win.focus();
        func();
    };
}

// Открытие окна для работы со сканером
function showDialogScanPhoto() {
    var url = '/barsroot/api/bills/bills/UploadScannedDocument?id=' + buildObj.receiverItems().EXP_ID + '&docType=AppScan';
    showScannDialog(url, function (result) {
        if (result.status === 1) {
            bars.ui.alert({
                text: 'Виконано успішно!',
                close: function (e) {
                    buildObj.updateData();
                    buildObj.HideOverlay();
                }
            });
        }
        else {
            bars.ui.error({
                text: result.err
            });
        }
        buildObj.HideOverlay();
    },
      buildObj);
  }

// Загрузка заявления на погашение задолжности
function downloadApplication() {
    buildObj.ShowOverlay();
    buildObj.downloadPdf('/barsroot/bills/bills/DownloadApplication/' + buildObj.receiverItems().EXP_ID, function (e) {
        setTimeout(function () {
            buildObj.HideOverlay();
            buildObj.updateData();
        }, 500);
        //this.removeEventListener('load');
    });
}

// Открытие всплывающего окна с прикрепленными документами
function uploadScanDocs() {
    var ID = buildObj.receiverItems().EXP_ID;
    var status = $('#STATUS').val();
    buildObj.popUp('/bills/bills/ScannedDocuments/' + ID + '?status=' + status, 'Відправка сканкопій документів', '85%', '90%');
}

// Стандартный метод обработки запросов
function onSuccessDefault(result) {
    if (result.status === 1) {
        bars.ui.alert({
            text: 'Виконано успішно!',
            close: function (e) {
            }
        });
    }
    else {
        bars.ui.error({
            text: result.err,
            close: function (e) {
                $(".k-overlay").remove();
            }
        });
    }
}

// Добавление комментария
function addComment() {
    var req_id = $('#REQ_ID').val();
    var id = $('#EXP_ID').val();
    var comment = $('#txt').val();
    buildObj.SendPostRequest('/barsroot/bills/bills/AddComment/' + id + "?req_id=" + req_id + "&comment=" + encodeURIComponent(comment), null, function (result) {
        $('#comments').html(result);
        buildObj.HideOverlay();
    });
}

// Обновление комментариев
function updateComments() {
    var req_id = $('#REQ_ID').val();
    var id = $('#EXP_ID').val();
    if (req_id !== '' && id !== '') {
        buildObj.SendPostRequest('/barsroot/bills/bills/UpdateComments/' + id + "?req_id=" + req_id, null, function (result) {
            $('#comments').html(result);
            buildObj.HideOverlay();
        });
    }
}

// Поиск клиента по РНК или по имени
function search() {
    var searchstr = $("#Search").val();
    window.parent.$('.k-overlay').css('z-index', '15002');
    var isNum = Math.floor(searchstr) === +searchstr && $.isNumeric(searchstr);
    var sqlType = isNum ? 'inn' : 'nmk';
    $.ajax({
        contentType: 'text/html; charset=UTF-8',
        url: "/barsroot/api/bills/bills/GetCustomersByParameter?param=" + encodeURIComponent(searchstr) + '&sqlType=' + sqlType,
        type: 'GET',
        success: function (e) {
            if (parseInt(e) === 0) {
                window.parent.$('.k-overlay').css('z-index', '10002');
                bars.ui.alert({
                    text: 'По даному значенню клієнтів не знайдено'
                });
            }
            else {
                window.parent.createResultWindow(e, searchstr, sqlType);
            }
        },
        error: function (err) {
            window.parent.$('.k-overlay').css('z-index', '10002');
            bars.ui.error({
                text: 'Виникла помилка',
                close: function (err) {

                }
            });
        }
    });
}

// Изменение значения в выпадающем списке (тип клиента: физ, юр.)
function setClientType(type) {
    var dropdownlist = $("#CL_TYPE").data("kendoDropDownList").value(type);
    IfCustomerTypeChanged();
}

//Всплывающее окно для охранения документа
function attachDocument() {
    var exp_id = $('#EXP_ID').val();
    buildObj.popUp('/bills/bills/attachPdf/' + exp_id, 'Збереження документів', '300px', '600px');
}

// Инициализация списка со счетами
function changeAccounts(data) {
    var dataSource = [];
    if (data !== null) {
        for (var i = 0; i < data.length; ++i)
            dataSource.push({ Text: data[i].NLS, Value: data[i].NLS });
    }
    $("#ACCOUNTS").data("kendoDropDownList").setDataSource(dataSource);
    if (data !== null)
        $("#ACCOUNT").val(data[0].NLS);
    else
        $("#ACCOUNT").val('');
    ChechFieldsOnEdited();
    checkRequiderFields('ACCOUNT', false);
}

// обработка события инициализации или выбора значения выпадающего списка со счетами
function accountChange(e) {
    var acc = $('#ACCOUNT').val();
    var accs = $('#ACCOUNTS').val();
    if (acc !== accs) {
        $('#ACCOUNT').val(accs);
        if ($('#ACCOUNT').css('border-color') === 'red' || $('#ACCOUNT').css('border-color') === 'rgb(255, 0, 0)')
            $('#ACCOUNT').css('border-color', '#ccc');        
    }
    ChechFieldsOnEdited();
    checkRequiderFields('ACCOUNT', false);
}

// Загрузка файла на погашение
function DownloadAcceptance(type) {
    var id = +$('#EXP_ID').val();
    if (id !== 0) {
        var url = '/barsroot/bills/bills/DownloadReport/' + id + '?reportType=';
        url += type === 'acc' ? 'acceptancereceiverfrombank' : 'act';
        buildObj.downloadPdf(url);
    }
    else
        bars.ui.alert({
            text: 'Неможливо виконати: стягувача не зарезервовано!'            
        });
}
