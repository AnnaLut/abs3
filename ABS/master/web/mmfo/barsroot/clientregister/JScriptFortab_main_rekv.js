var FREE_ECONOMIC_ZONE_KRYM_CODE = "900";

function openWindowAddress() {

    var win;

    if (window.parent && window.parent.parent) {
        win = window.parent.parent;
    } else {
        win = window.parent;
    }

    if (!win.bars.ui) {
        win = window;
    }

    win.customerAddress = parent.obj_Parameters['fullADR'];

    win.bars.ui.dialog({
        //bars.ui.dialog({
        iframe: true,
        actions: ["Close"],
        width: '850px',
        height: '590px',
        id: 'winClientAddress',
        title: 'Повна адреса клієнта',
        content: {
            url: bars.config.urlContent('/clients/ClientAddress/ClientAddress'),
            modal: true
        },
        close: function () {
            if (win.customerAddress.type1.filled == true) {
                window.parent.$('#bt_reg').prop("disabled", false);
                $('#ed_ADR')
                    .val(parent.obj_Parameters['fullADR'].type1.locality +
                    ', ' +
                    parent.obj_Parameters['fullADR'].type1.address);
            }
        }
    });
}

$(document).ready(function () {
    $('#ed_NMK').change(function () { $(this).removeClass('err').attr('title', ''); });
    $('#ed_NMKK').change(function () { $(this).removeClass('err').attr('title', ''); });
    $('#ed_NMKV').change(function () { $(this).removeClass('err').attr('title', ''); });
    $('#ed_OKPO').change(function () { $(this).removeClass('err').attr('title', ''); });
    $('#ed_ADR').change(function () { $(this).removeClass('err').attr('title', '');; });
    //якщор клієнт не фізична особа резидент то зменшуємо довжину поля до 9
    /*if ((parent.obj_Parameters['CUSTTYPE'] == 'person' && rezId == 2) || (parent.obj_Parameters['CUSTTYPE']!='person') )
        $('#ed_OKPO').attr('maxlength','9');*/

    //$('#ed_OKPO').keyup(function () { return maskInt(this); });
    //$('#ed_OKPO').keydown(function () { return maskInt(this); });
    /*$('#ed_OKPO').keypress(function (event) {
        if (event.keyCode < 48 || event.keyCode > 57)
            return false;
    });*/
    $('#ed_OKPO').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    var fioMask = /^[a-zA-Zа-яА-Яа-яА-ЯіІїЇєЄ]{0,1}[a-zA-Zа-яА-Яа-яА-ЯіІїЇєЄ\-\`\']{1,69}$/;

    $('#ed_FIO_LN').numberMask({ pattern: fioMask });
    $('#ed_FIO_FN').numberMask({ pattern: fioMask });
    $('#ed_FIO_MN').numberMask({ pattern: fioMask });

    $('#ed_FIO_LN_NR').numberMask({ pattern: fioMask });
    $('#ed_FIO_FN_NR').numberMask({ pattern: fioMask });
    $('#ed_FIO_MN_NR').numberMask({ pattern: fioMask });
    $('#ed_FIO_4N_NR').numberMask({ pattern: fioMask });

    if (parent.obj_Parameters['EditType'] === 'Reg') {
        $('#ddl_PRINSIDER').removeAttr('disabled');
        $('#btRegisterDbo').hide();
        $('#btSignDbo').hide();
        $('#lSign').hide();
    }

    if (parent.obj_Parameters['CUSTTYPE'] === 'person' && getParamFromUrl('spd', document.location.href) == 0) {
        $('#btRegisterDbo').hide();
        $('#btSignDbo').hide();
        $('#lSign').hide();
    }
});
//заборона вводу нічого крім цифр 
//назначається на подію onkeyup (onkeyup="return maskInt(this);")
function maskInt(input) {
    var value = input.value;
    var rep = /[-\+\.;":'\/\*\!\@\#\$\%\^\&\_\~\№\=\|\(\)a-zA-Zа-яА-Я]/;
    if (rep.test(value)) {
        value = value.replace(rep, '');
        input.value = value;
    }
}
// служебные функция JavaScript
var ServiceUrl = '/barsroot/clientregister/defaultWebService.asmx';
function ExecSync(method, args) {
    var executor = new Sys.Net.XMLHttpSyncExecutor();
    var request = new Sys.Net.WebRequest();

    request.set_url(ServiceUrl + '/' + method);
    request.set_httpVerb('POST');
    request.get_headers()['Content-Type'] = 'application/json; charset=utf-8';
    request.set_executor(executor);
    request.set_body(Sys.Serialization.JavaScriptSerializer.serialize(args));
    request.invoke();

    if (executor.get_responseAvailable()) {
        return (executor.get_object());
    }

    return (false);
}

// транслитерация
function TranslateKMU(txt) {
    return ExecSync('TranslateKMU', { txt: txt }).d;
}

// при заполнении названия клиента национального автоматически подтягивать его в остальные два названия
function CopyNMK() {
    if (trim(getEl('ed_NMKK').value).length == 0) {
        $get('ed_NMKK').value = $get('ed_NMK').value.substr(0, 38);
    }
    if (trim(getEl('ed_NMKV').value).length == 0) {
        $get('ed_NMKV').value = TranslateKMU($get('ed_NMK').value).substr(0, 70);
    }
}
// Характеристика клиента (К010)
function GetCodecagentList() {
    var items = ExecSync('GetCodecagentList', { CType: parent.obj_Parameters['CUSTTYPE'], rezId: getParamFromUrl('rezid', document.location.href) }).d;
    $get('ddl_CODCAGENT').options.length = 0;
    for (var i in items) {
        var item = document.createElement("OPTION");
        $get('ddl_CODCAGENT').options.add(item);

        item.value = items[i].REZID + '-' + items[i].CODCAGENT;
        item.innerText = items[i].NAME;
    }
}
// Тип гос реестра
function GetTGRList() {
    var items = ExecSync('GetTgrList', { CType: parent.obj_Parameters['CUSTTYPE'], rezid: $get('ddl_CODCAGENT').item($get('ddl_CODCAGENT').selectedIndex).value.substr(0, 1) }).d;
    $get('ddl_TGR').options.length = 0;
    for (var i in items) {
        var item = document.createElement("OPTION");
        $get('ddl_TGR').options.add(item);

        item.value = items[i].TGR;
        item.innerText = items[i].NAME;
    }
}
//Страны
function GetCOUNTRYList(rezid) {
    var items = ExecSync('GetCountryList', { Rezid: rezid }).d;
    $get('ddl_COUNTRY').options.length = 0;
    for (var i in items) {
        var item = document.createElement("OPTION");
        $get('ddl_COUNTRY').options.add(item);

        item.value = items[i].COUNTRY;
        item.innerText = items[i].NAME;
    }

    $get('ed_COUNTRYCd').value = $get('ddl_COUNTRY').item($get('ddl_COUNTRY').selectedIndex).value;
}
//при изменении codecagent перечитываем страны
function OnCOUNTRYCdChange() {
    var tmp = $get('ddl_COUNTRY').selectedIndex;
    for (var i = 0; i < getEl('ddl_COUNTRY').options.length; i++) {
        if ($get('ed_COUNTRYCd').value == $get('ddl_COUNTRY').options.item(i).value)
            $get('ddl_COUNTRY').selectedIndex = i;
    }

    if ($get('ddl_COUNTRY').selectedIndex == tmp) alert(LocalizedString('Mes10')/*"Страна не найдена"*/);
}
function PutCOUNTRYCd() {
    $get('ed_COUNTRYCd').value = $get('ddl_COUNTRY').item($get('ddl_COUNTRY').selectedIndex).value;
}
//при изменении codecagent перечитываем страны
function OnCodecagentChange() {
    var tmp = $get('ddl_CODCAGENT').item($get('ddl_CODCAGENT').selectedIndex).value.substr(0, 1);
    GetCOUNTRYList(tmp);

    if ($get('ddl_CODCAGENT').selectedIndex == 1)
        $get('ed_OKPO').value = "000000000";
    else
        $get('ed_OKPO').disabled = false;

    //нерезиденты банки не заполняют следущие поля
    var ClientRekvTab = parent.document.getElementById('Tab3');
    if (tmp == '1') {
        if (parent.obj_Parameters['EditType'] != 'true') {
            if (gE(ClientRekvTab, 'ed_MFO') != null) gE(ClientRekvTab, 'ed_MFO').disabled = false;
            if (gE(ClientRekvTab, 'lb_1') != null) gE(ClientRekvTab, 'lb_1').disabled = false;
            if (gE(ClientRekvTab, 'ed_KOD_B') != null) gE(ClientRekvTab, 'ed_KOD_B').disabled = false;
        }
    }
    else {
        if (gE(ClientRekvTab, 'ed_MFO') != null) gE(ClientRekvTab, 'ed_MFO').disabled = true;
        if (gE(ClientRekvTab, 'lb_1') != null) gE(ClientRekvTab, 'lb_1').disabled = true;
        if (gE(ClientRekvTab, 'ed_KOD_B') != null) gE(ClientRekvTab, 'ed_KOD_B').disabled = true;
    }
}
// Функция проверки валидности ОКПО
function checkOKPO(edit, validFromBase) {
    var status = true;
    var lenghtOKPO = 10;
    var strOKPO = trim(edit.value);
    var rezId = $get('ddl_CODCAGENT').item($get('ddl_CODCAGENT').selectedIndex).value.substr(0, 1); //1-резидент; 2-нерезидент
    var custType = parent.obj_Parameters['CUSTTYPE'];//   person/corp
    var reg = /^[0-9]*$/;//маска для вылідації цифр

    var strOKPONew = '';
    var m7_ = '';
    var c1_ = '';
    var c2_ = '';
    var kc_ = 0;
    var sum_ = 0;

    //загальна перевірка
    //перевірка чи поле заповнене
    if (strOKPO == '') {
        alert('Поле Ідентифікаційний код не може бути пустим. Введіть ІПН повторно.');
        $(edit).addClass('err');
        return false;
    }
    //перевірка на допустимі символи
    if (!reg.test(strOKPO)) {
        alert('Ідентифікаційний код містить недопустимі символи. Введіть ІПН повторно.');
        $(edit).addClass('err');
        return false;
    }
    //перевірка на повторення цифр
    if (strOKPO.substr(0, 1) != '0') {
        if (!validOkpoRepeatNumber(strOKPO)) {
            $(edit).addClass('err');
            return false;
        }
    }
    //для Фізичниних резидентів
    if (custType == 'person' && rezId == 1) {
        //перевірка на релігійну віру
        if (strOKPO == '0000000000') {//десять нулів
            return true;
        }
        //перевірка довжини
        if (strOKPO.length != lenghtOKPO) {
            alert('Ідентифікаційний код повинен складатися з ' + lenghtOKPO + ' цифр. Введіть ІПН повторно.');
            $(edit).addClass('err');
            return false;
        }

        var frame3 = getParantFrame('Tab3');
        //перевірка на відповідність даті народження
        var bDay = gE(frame3, 'ed_BDAY').value;
        if (bDay != undefined && bDay != '') {
            var bDayFromOkpo = date_add_days('31.12.1899', strOKPO.substr(0, 5));
            if (bDay != bDayFromOkpo) {
                alert('Ідентифікаційний код не співпадає з датою народження. Введіть ІПН повторно.');
                $(edit).addClass('err');
                return false;
            }
        }
        //перевірка на відповідність статі
        var ddlSex = gE(frame3, 'ddl_SEX');
        var sex = ddlSex.options[ddlSex.selectedIndex].value;
        var res = '';
        if (strOKPO.substr(strOKPO.length - 2, 1) != '0' && gE(frame3, 'ckb_main').checked) {
            res = parseInt(strOKPO.substr(strOKPO.length - 2, 1)) % 2;
            if (sex != 0 && ((res == 0 && sex != 2) || (res == 1 && sex != 1))) {
                alert('Ідентифікаційний код не співпадає з статтю клієнта. Введіть ІПН повторно.');
                $(edit).addClass('err');
                return false;
            }
        }
        //перевірка на контрольний розряд
        if (!validateOkpoDigitFO(strOKPO)) {
            alert('Не співпадає контрольний розряд ідентифікаційного коду. Введіть ІПН повторно.');
            $(edit).addClass('err');
            return false;
        } else if (gE(frame3, 'ckb_main').checked) {
            //заповнюємо стать і дату народження
            gE(frame3, 'ed_BDAY').value =
                date_add_days('31.12.1899', strOKPO.substr(0, 5));
            if (strOKPO.substr(strOKPO.length - 2, 1) != '0') {
                var selectSex;
                if (res == 0) {
                    selectSex = 2;
                } else {
                    selectSex = 1;
                }
                for (var m = 0; m < ddlSex.options.length; m++) {
                    if (ddlSex.options[m].value == selectSex) {
                        ddlSex.selectedIndex = m;
                    }
                }
            }
        }
        //перевірка на наявність в базі
        if (validFromBase == true)
            validOkpoFromBase(strOKPO);
    }
    //для Фізичних осіб нерезидентів
    if (custType == 'person' && rezId == 2) {
        var countryCode = getCountryCode();
        lenghtOKPO = 10;
        if (strOKPO == '0000000000') {//девять нулів
            return true;
        }
        if (strOKPO.length != lenghtOKPO && countryCode !== FREE_ECONOMIC_ZONE_KRYM_CODE) {
            alert('Ідентифікаційний код повинен складатися з ' + lenghtOKPO + ' цифр. Введіть ІПН повторно.');
            $(edit).addClass('err');
            return false;
        }

        //перевірка на наявність в базі
        if (validFromBase == true)
            validOkpoFromBase(strOKPO);
    }

    //для Юридичних осіб резидентів
    if (custType == 'corp' && rezId == 1) {
        if (strOKPO == '000000000') {//девять нулів
            return true;
        }
        //перевіка ключового розряду
        if (!validOkpoDigitUO(strOKPO)) {
            $(edit).addClass('err');
            return false;
        }

        //перевірка на наявність в базі
        if (validFromBase == true)
            validOkpoFromBase(strOKPO);
    }
    //для Юридичних осіб нерезидентів
    if (custType == 'corp' && rezId == 2) {
        if (strOKPO == '000000000') {//девять нулів
            return true;
        }

        //перевірка на наявність в базі
        if (validFromBase == true)
            validOkpoFromBase(strOKPO);
    }

    //для банків
    if (custType == 'bank') {
        if (strOKPO == '000000000') {//девять нулів
            return true;
        }
        //перевіка ключового розряду
        if (!validOkpoDigitUO(strOKPO)) {
            $(edit).addClass('err');
            return false;
        }

        //перевірка на наявність в базі
        if (validFromBase == true)
            validOkpoFromBase(strOKPO);
    }
    return true;
    //alert(custType);
}
//перевірка на повторення цифр
function validOkpoRepeatNumber(strOKPO) {
    var stat = false;
    for (var i = 0; i < strOKPO.length; i++) {
        if (strOKPO.substr(0, 1) != strOKPO.substr(i, 1)) {
            stat = true;
            //return;
        }
    }
    if (!stat) {
        alert('Ідентифікаційний код не повинен складатися з однакових цифр крім нулів. Введіть ІПН повторно.');
        return false;
    }
    else
        return true;
}

//перевірка контрольного розряду для ФО
function validateOkpoDigitFO(strOkpo) {
    if (strOkpo.length < 10) {
        return false;
    }
    var array = strOkpo.split('');
    var temp = (
        array[0] * (-1) +
        array[1] * 5 +
        array[2] * 7 +
        array[3] * 9 +
        array[4] * 4 +
        array[5] * 6 +
        array[6] * 10 +
        array[7] * 5 +
        array[8] * 7);
    var s = temp - (11 * (~~(temp / 11)));
    if (s == 10) {
        return array[9] == s % 10;
    } else {
        return array[9] == s;
    }
}

//перевірка ОКПО Юридичних осіб на ключовий розряд
function validOkpoDigitUO(strOKPO) {
    var strOKPONew = '';
    var m7_ = '';
    var c1_ = '';
    var c2_ = '';
    var kc_ = 0;
    var sum_ = 0;
    if (strOKPO.length == 8) {
        // ЄДРПОУ проверяется

        if (strOKPO < '30000000' || strOKPO > '60000000') m7_ = '1234567';
        else m7_ = '7123456';

        for (var i = 0; i < 7; i++) {
            c1_ = strOKPO.substr(i, 1);
            c2_ = m7_.substr(i, 1);
            sum_ += parseInt(c1_) * parseInt(c2_);
        }

        kc_ = sum_ % 11;
        if (kc_ == 10) {
            if (strOKPO < '30000000' || strOKPO > '60000000') m7_ = '3456789';
            else m7_ = '9345678';
            sum_ = 0;
            for (var i = 0; i < 7; i++) {
                c1_ = strOKPO.substr(i, 1);
                c2_ = m7_.substr(i, 1);
                sum_ += parseInt(c1_) * parseInt(c2_);
            }
            kc_ = sum_ % 11;
            if (kc_ == 10) kc_ = 0;
        }
        strOKPONew = strOKPO.substr(0, 7) + kc_;

        if (strOKPONew == strOKPO)
            return true;
        else {
            alert('Ідентифікаційний код не пройшов перевірку контрольного розряду. Введіть ІПН повторно.');
            return false;
        }
    }
    else {
        alert('Ідентифікаційний код повинен складатися з 8 цифр або з дев`яти нулів. Введіть ІПН повторно.');
        return false;
    }
}

// проверяем ОКПО на наличие в базе

function validOkpoFromBase(strOkpo) {
    var validationResult = ExecSync('ValidateOkpo', { OKPO: strOkpo }).d;

    if (validationResult.Code != 'OK') {
        var msg = escape(validationResult.Text);
        var ask = window.showModalDialog('dialog.aspx?type=confirm&message=' + msg, 'dialogHeight:300px; dialogWidth:400px');
        if (ask == '1') {
            var param = eval('(' + validationResult.Param + ')');
            if (param.DateCloseS == '') {
                // фича для ФМ - если пришли с readonly - проверяем доступ к редактированию даной карточки
                if (parent.location.href.indexOf("readonly=2") > 0) {
                    var rO = ExecSync('CheckAccess', { RNK: param.rnk }).d;
                    parent.window.location.href = '/barsroot/clientregister/registration.aspx?readonly=' + rO + '&rnk=' + param.rnk;
                } else {
                    parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                }
            } else {
                if (parent.location.href.indexOf("readonly=2") > 0) {
                    var rO1 = ExecSync('CheckAccess', { RNK: param.rnk }).d;
                    $.post('/barsroot/customerlist/CustService.asmx/ResurectCustomer', { rnk: param.rnk }, function (data) {
                        if (data.text == '') {
                            parent.window.location.href = '/barsroot/clientregister/registration.aspx?readonly=' + rO1 + '&rnk=' + param.rnk;
                        } else {
                            parent.barsUiError({ text: data.text });
                        }
                    });
                } else {
                    $.post('/barsroot/customerlist/CustService.asmx/ResurectCustomer', { rnk: param.rnk }, function (data) {
                        if (data.text == '') {
                            parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                        } else {
                            parent.barsUiError({ text: data.text });
                        }
                    });
                }
            }
        }
    }
}

//функція додає дні до певної дати
function date_add_days(date, days) { // date в формате дд.мм.гггг
    var d = new Date((new Date(date.replace(/(\d+).(\d+).(\d+)/, '$3/$2/$1 13:00:00'))).getTime() + (days * 24 * 60 * 60 * 1000));
    var day = d.getDate();
    var month = d.getMonth() + 1;
    var year = d.getFullYear();
    if (day < 10) day = '0' + day;
    if (month < 10) month = '0' + month;
    return [day, month, year].join('.');
}

function checkOKPO1(edit) {
    var strOKPO = trim(edit.value);
    var strOKPONew = '';
    var m7_ = '';
    var c1_ = '';
    var c2_ = '';
    var kc_ = 0;
    var sum_ = 0;

    if (strOKPO == '') {
        // пустое поле пропускаем 

        return true;
    }
    else if (strOKPO == '99999' || strOKPO == '000000000' || strOKPO == '0000000000') {
        // ОКПО 99999 и 000000000 пропускаем как валидные

        return true;
    }
    else if (strOKPO.length < 8) {
        // дополняем нулями слева до восьми символов
        var cnt = 8 - strOKPO.length;
        for (var j = 0; j < cnt; j++) strOKPO = '0' + strOKPO;
        edit.value = strOKPO;

        return checkOKPO(edit);
    }
    else {
        // проверяем ОКПО на наличие в базе
        var ValidationResult = ExecSync('ValidateOkpo', { OKPO: strOKPO }).d;

        if (ValidationResult.Code != 'OK') {
            var msg = escape(ValidationResult.Text);
            var ask = window.showModalDialog('dialog.aspx?type=confirm&message=' + msg, 'dialogHeight:300px; dialogWidth:400px');
            if (ask == '1') {
                var rnk = ValidationResult.Param;
                // фича для ФМ - если пришли с readonly - проверяем доступ к редактированию даной карточки
                if (parent.location.href.indexOf("readonly=2") > 0) {
                    var rO = ExecSync('CheckAccess', { RNK: rnk }).d;
                    parent.window.location.replace('/barsroot/clientregister/registration.aspx?readonly=' + rO + '&rnk=' + rnk);
                }
                else
                    parent.window.location.replace('/barsroot/clientregister/registration.aspx?rnk=' + rnk);
            }
        }

        if (strOKPO.length == 10) {
            // ДРФО не проверяется

            return true;
        }
        else if (strOKPO.length == 9) {
            // ДПА не проверяется
            return true;
        }
        else if (strOKPO.length == 8) {
            // ЄДРПОУ проверяется

            if (strOKPO < '30000000' || strOKPO > '60000000') m7_ = '1234567';
            else m7_ = '7123456';
            for (var i = 0; i < 7; i++) {
                c1_ = strOKPO.substr(i, 1);
                c2_ = m7_.substr(i, 1);

                sum_ += parseInt(c1_) * parseInt(c2_);
            }

            kc_ = sum_ % 11;

            if (kc_ == 10) {
                if (strOKPO < '30000000' || strOKPO > '60000000') m7_ = '3456789';
                else m7_ = '9345678';

                sum_ = 0;

                for (var c = 0; i < 7; i++) {
                    c1_ = strOKPO.substr(c, 1);
                    c2_ = m7_.substr(c, 1);

                    sum_ += parseInt(c1_) * parseInt(c2_);
                }

                kc_ = sum_ % 11;

                if (kc_ == 10) kc_ = 0;
            }

            strOKPONew = strOKPO.substr(0, 7) + kc_;

            if (strOKPONew == strOKPO) return true;
            else {
                alert(LocalizedString('Mes11')/*'Неверный Идентификационный Код!'*/);
                edit.focus();
                edit.select();

                return false;
            }
        }
        else {
            alert(LocalizedString('Mes11')/*'Неверный Идентификационный Код!'*/);
            edit.focus();
            edit.select();

            return false;
        }
    }
}
//TOBO
function PutTOBOCd() {
    $get('ed_TOBOCd').value = $get('ddl_TOBO').item($get('ddl_TOBO').selectedIndex).value;
}
//при изменении codecagent перечитываем страны
function OnTOBOCdChange() {
    $get('ddl_TOBO').selectedIndex = -1;

    for (var i = 0; i < $get('ddl_TOBO').options.length; i++) {
        if (trim($get('ed_TOBOCd').value) == trim($get('ddl_TOBO').options.item(i).value))
            $get('ddl_TOBO').selectedIndex = i;
    }
}
//первичное заполнение объектов
function InitObjects() {
    locked = false;
    //заполняем дату заведения договора
    $get('ed_DATE_ON').value = parent.obj_Parameters['DATE_ON'];
    //блокируем елементы при просмотре
    DisableAll(document, parent.obj_Parameters['ReadOnly']);
    $get('ed_DATE_ON').disabled = true;
    $get('ed_DATE_OFF').disabled = true;
    $get('ed_ID').disabled = true;
    //вставляем значения в ДЛЛ
    GetCodecagentList();
    $get('ddl_CODCAGENT').selectedIndex = FindByValCodecagent($get('ddl_CODCAGENT'), parent.obj_Parameters['CODCAGENT']);
    //наполняем страны
    OnCodecagentChange();
    $get('ddl_COUNTRY').selectedIndex = FindByVal($get('ddl_COUNTRY'), parent.obj_Parameters['COUNTRY']);
    PutCOUNTRYCd();
    //значення по замовчуванню для ознаки інсайдера
    if (parent.obj_Parameters['EditType'] == "Reg") {
        $get('ddl_PRINSIDER').selectedIndex = FindByVal($get('ddl_PRINSIDER'), '99');
    } else {
        $get('ddl_PRINSIDER').selectedIndex = FindByVal($get('ddl_PRINSIDER'), parent.obj_Parameters['PRINSIDER']);
    }
    //----если это физ.лицо то предустановленый будет реестр физ.лиц
    GetTGRList();
    $get('ddl_TGR').selectedIndex = FindByVal($get('ddl_TGR'), parent.obj_Parameters['TGR']);
    if (parent.obj_Parameters['CUSTTYPE'] == 'person' && parent.obj_Parameters['EditType'] == 'Reg') $get('ddl_TGR').selectedIndex = 1;

    $get('ddl_STMT').selectedIndex = FindByVal($get('ddl_STMT'), parent.obj_Parameters['STMT']);

    $get('ed_ADR').disabled = true;
    $get('ed_ADR').value = 'Введіть повну адресу';
    if (parent.obj_Parameters['fullADR'].type1.filled)
        $get('ed_ADR').value = parent.obj_Parameters['fullADR'].type1.locality + ', ' + parent.obj_Parameters['fullADR'].type1.address;
    else
        $get('ed_ADR').value = parent.obj_Parameters['ADR'];
    //значения едитов
    if (parent.obj_Parameters['EditType'] != "Reg" || parent.isRegisterByScb()) {
        $get('ed_DATE_OFF').value = parent.obj_Parameters['DATE_OFF'];
        $get('ed_ID').value = parent.obj_Parameters['ID'];
        $get('ed_ND').value = parent.obj_Parameters['ND'];
        $get('ed_NMK').value = parent.obj_Parameters['NMK'];
        $get('ed_NMKV').value = parent.obj_Parameters['NMKV'];
        $get('ed_NMKK').value = parent.obj_Parameters['NMKK'];

        $get('ed_OKPO').value = parent.obj_Parameters['OKPO'];
        $get('ed_SAB').value = parent.obj_Parameters['SAB'];
        $get('ed_TOBOCd').value = parent.obj_Parameters['TOBO'];
        OnTOBOCdChange();
        $get('ckb_BC').checked = ((parent.obj_Parameters['BC'] == '1') ? (true) : (false));
        $get('btSignDbo').checked = ((parent.obj_Parameters['DopRekv_SDBO'] == '1') ? (true) : (false));
        $get('btSignDbo').disabled = ((parent.obj_Parameters['DopRekv_SDBO'] == '1') ? (true) : (false));
    }

    HideProgress();
    var frames = parent.document.frames || parent.window.frames;
    var frame1 = getParantFrame('Tab1');
    var frame2 = getParantFrame('Tab2')

    if (frame1.location) {
        frame1.location = "tab_rekv_nalogoplat.aspX";
    } else {
        frame1.src = "tab_rekv_nalogoplat.aspX";
    }

    if (frame2.location) {
        frame2.location = "tab_ek_norm.asPX?spd=" + getParamFromUrl('spd', document.location.href);
    } else {
        frame2.src = "tab_ek_norm.asPX?spd=" + getParamFromUrl('spd', document.location.href);
    }
    //(frames['Tab1'].location || frames['Tab1'].document.location) = "tab_rekv_nalogoplat.aspX";
    //(frames['Tab2'].location || frames['Tab2'].document.location) = "tab_ek_norm.asPX?spd=" + getParamFromUrl('spd', document.location.href);
}
//поиск индекса в ДДЛ(Codecagent) по заданому значению
function FindByValCodecagent(ddl, val) {
    for (var i = 0; i < ddl.options.length; i++) {
        if (ddl.item(i).value.slice(2) == val) {
            return i;
        }
    }
    return 0;
}
//поиск индекса в ДДЛ по заданому значению
function FindByVal(ddl, val) {
    for (var i = 0; i < ddl.options.length; i++) {
        if (ddl.item(i).value == val) {
            return i;
        }
    }
    return 0;
}
function ShowfullADR() {
    $('#ed_ADR').removeClass('err');
    if (window.showModalDialog) {
        var result = window.showModalDialog('/barsroot/clientregister/Dialogs/dialogfulladr.aspx?pars=' + Math.random(), parent.obj_Parameters['fullADR'], 'dialogHeight:600px; dialogWidth:600px; scroll: no');
        if (result != null) {
            if (result.type1) {
                parent.obj_Parameters['fullADR'] = result;
                $('#ed_ADR').val(result.type1.locality + ', ' + result.type1.address);
            } else {
                parent.obj_Parameters['fullADR'] = result[0];
                $('#ed_ADR').val(result[1]);
            }
        }
    } else {
        if (window.winFullAdr) {
            window.winFullAdr.close();
            window.winFullAdr = null;
        }
        var url = '/barsroot/clientregister/Dialogs/dialogfulladr.aspx?pars=' + Math.random();
        var left = (screen.width / 2) - (620 / 2);
        var top = (screen.height / 2) - (600 / 2);
        window.winFullAdr = window.open(url, 'addrWindow', 'width=620,height=600, top=' + top + ', left=' + left);
        window.winFullAdr.dialogArguments = parent.obj_Parameters['fullADR'];
        window.winFullAdr.closedFunction = function (result) {
            if (result != null) {
                if (result.type1) {
                    parent.obj_Parameters['fullADR'] = result;
                    $('#ed_ADR').val(result.type1.locality + ', ' + result.type1.address);
                } else {
                    parent.obj_Parameters['fullADR'] = result[0];
                    $('#ed_ADR').val(result[1]);
                }
            }
        }
    }
    /*var result = window.showModalDialog('/barsroot/clientregister/Dialogs/dialogfulladr.aspx?pars=' + Math.random(), parent.obj_Parameters['fullADR'], 'dialogHeight:600px; dialogWidth:600px; scroll: no');
  if (result != null) {
    if (result.type1) {
      parent.obj_Parameters['fullADR'] = result;
      $('#ed_ADR').val(result.type1.locality + ', ' + result.type1.address);
    } else {
      parent.obj_Parameters['fullADR'] = result[0];
      $('#ed_ADR').val(result[1]);
    }
  }*/
}
function getParamFromUrl(param, url) {
    url = url.substring(url.indexOf('?') + 1);
    for (var i = 0; i < url.split("&").length; i++)
        if (url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1];
    return "";
}

// cформувати ДБО
function registerDbo() {
    var result = ExecSync('RegisterDbo', { rnk: parent.obj_Parameters['ID'] }).d;
    if (result.Code == "0") {
        parent.bars.ui.success({ text: result.Message, width: 400, height: 100 });
    } else {
        parent.bars.ui.error({ text: result.Message, width: 400, height: 100 });
    }
}

// підписати ДБО для відправки до ЕА
function signDbo() {
    if ($('#btSignDbo').is(':checked')) {
        if (confirm('Доправити ДБО в чергу на відправку до ЕА?')) {
            var result = ExecSync('SignEADbo', { rnk: parent.obj_Parameters['ID'] }).d;
            if (result.Code == "0") {
                $('#btSignDbo').prop('checked', true);
                $('#btSignDbo').attr('disabled', true);
                parent.bars.ui.success({ text: result.Message, width: 400, height: 100 });
                return true;
            } else {
                parent.bars.ui.error({ text: result.Message, width: 400, height: 100 });
                $('#btSignDbo').removeAttr('disabled'); $('#btSignDbo').removeAttr('checked');
                return false;
            }
        }
        else { $('#btSignDbo').removeAttr('disabled'); $('#btSignDbo').removeAttr('checked'); return false; }
    } else { $('#btSignDbo').removeAttr('disabled'); $('#btSignDbo').removeAttr('checked'); return false; }
}

var getCountryCode = function () {
    return $get('ed_COUNTRYCd').value;
}

//Fix Json problem
var JSON = JSON || {};
// implement JSON.stringify serialization
JSON.stringify = JSON.stringify || function (obj) {
    var t = typeof (obj);
    if (t != "object" || obj === null) {
        // simple data type
        if (t == "string") obj = '"' + obj + '"';
        return String(obj);
    }
    else {
        // recurse array or object
        var n, v, json = [], arr = (obj && obj.constructor == Array);
        for (n in obj) {
            v = obj[n]; t = typeof (v);

            if (t == "string") v = '"' + v + '"';
            else if (t == "object" && v !== null) v = JSON.stringify(v);

            json.push((arr ? "" : '"' + n + '":') + String(v));
        }
        return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
    }
};

//COBUSUPABS-6570
function setTgrList() {
    var rezid = getParamFromUrl('rezid', document.location.href);
    if (parent.obj_Parameters['CUSTTYPE'] === 'person' && rezid === "1") {
        var okpo = $get('ed_OKPO').value;
        if (okpo == '0000000000') {
            $('.ddlTGRClass option[value="5"]').attr("selected", "selected");
        } else {
            $('.ddlTGRClass option[value="2"]').attr("selected", "selected");
        }
    }
}

function ToUpperCase(fieldName) {
    getEl(fieldName).value = getEl(fieldName).value.toUpperCase();
}
// implement JSON.parse de-serialization
JSON.parse = JSON.parse || function (str) {
    if (str === "") str = '""';
    eval("var p=" + str + ";");
    return p;
};

$(document).ready(function () {
    var isOper2ndNameEmpty = false;

    function callConfWindow() {
        var msgString = "<b>Підтвердіть, що у клієнта відсутні дані По-батькові</b><br>" +
            "- натиснувши <b>\"ТАК\"</b> картка клієнта <b>зберігається без заповнення даних;</b><br>" +
            "- натиснувши <b>\"НІ\" поверніться</b> для <b>заповнення поля По-Батькові клієнта</b><br>";
        parent.bars.ui.approve({
            text: msgString,
            func: function () { isOper2ndNameEmpty = true; },
            nfunc: function () { $("#ed_FIO_MN").focus(); }
        });
    }
    function focuscheck() {
        semafor = 1;
        if (!isOper2ndNameEmpty) {
            if (parent.gE(parent.getFrame('Tab0'), 'ed_FIO_MN').value == "") {
                callConfWindow();
            }
        }
        if ($("#ed_FIO_MN").val().length > 0) {
            var n_info = getMidNameInfo();
            checkCompleteName_Midname(2, n_info);
        }
    }
    // перевірка заповненості По-Батькові користувача фо резидента
    if (parent.obj_Parameters['CUSTTYPE'] === 'person' && getParamFromUrl('rezid', document.location.href) === "1") {
        //якщо переглядаємо\редагуємо
        if (parent.obj_Parameters['EditType'] !== "Reg") {
            if (parent.obj_Parameters['DopRekv_SN_MN'] != "") { //Якщо до цього було пусто то не викликаэмо перевірку
                $("#ed_FIO_MN").on("focusout", focuscheck);
            }
        } else { //якщо створюємо
            $("#ed_FIO_MN").on("focusout", focuscheck);
        }
    }
    var semafor = 0;
    function periodCheckSndName() {
        if ($("#ed_FIO_LN").val() != "" && $("#ed_FIO_FN").val() != "" && semafor == 0 && $("#ed_FIO_MN").is(':focus') == false) {
            focuscheck();
        }
    }
    $("#ed_FIO_LN").on("focusout", periodCheckSndName);
    $("#ed_FIO_FN").on("focusout", periodCheckSndName);


    ///
    ///Autocomplete Features
    ///

    function callConfWinNameMname(option, item, value) {
        var msgString = "Ви намагаєтесь ввести <b>російське</b> " + option + ", пропонуємо<br>" +
            "замінити його на <b>український</b> аналог (з довідника)";
        parent.bars.ui.approve({
            text: msgString,
            func: function () { item.val(value.toUpperCase()); },
            nfunc: function () { }
        });
    }
    //Formatting for base productivity
    String.prototype.capitalize = function () {
        return this.charAt(0).toUpperCase() + this.slice(1).toLocaleLowerCase();
    };

    //Db get only 1 or 2, else its need to be null
    function getSexOfPerson() {
        var ddlSex = parent.getFrame('Tab3').document.getElementById('ddl_SEX');
        var sex = ddlSex.options[ddlSex.selectedIndex].value;

        if (sex != 1 && sex != 2)
            sex = "";
        return sex;
    };

    //basic info for autocomplete name
    function getNameInfo() {
        return {
            Sex: getSexOfPerson(),
            Name: $('#ed_FIO_FN').val().capitalize()
        };
    };
    function getMidNameInfo() {
        var m_name = getNameInfo();
        m_name.MName = $('#ed_FIO_MN').val().capitalize();
        return m_name;
    }
    function getFioInfo() {
        var fio = getMidNameInfo();
        fio.SName = $('#ed_FIO_LN').val().capitalize();
        return fio;
    }
    //name autocomplete
    $("#ed_FIO_FN").autocomplete({
        source: function (request, response) {

            var n_info = getNameInfo();
            $.ajax({
                url: '/barsroot/clientregister/defaultWebService.asmx/GetListNames',
                data: JSON.stringify({ 'info': n_info }),
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //collect data from server responce
                    var codes_nls = [];
                    for (var i = 0; i < data.d.length; i++) {
                        codes_nls.push(data.d[i]);
                    }
                    data.d = [];
                    response(codes_nls);
                }
            });
        },
        minLength: 2,
        select: function (event, ui) {
            //evetn if variant was swelected
        },
        focus: function (event, ui) {
            event.preventDefault();
        }
    });

    //mode 1 name
    //mode 2 midname
    function checkCompleteName_Midname(mode, data) {
        if (mode == 1) {
            data.MName = null;
        } else if (mode == 2) {
            data.Name = null;
        }
        $.ajax({
            url: '/barsroot/clientregister/defaultWebService.asmx/KlNameUlt',
            data: JSON.stringify({ 'info': data }),
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                if (data.d !== null && data.d !== "") {
                    if (mode == 1) {
                        callConfWinNameMname("ім'я", $("#ed_FIO_FN"), data.d);
                    } else if (mode == 2) {
                        callConfWinNameMname("по-батькові", $("#ed_FIO_MN"), data.d);
                    }
                }
            }
        });

    }

    $("#ed_FIO_FN").focusout(function () {
        if ($("#ed_FIO_FN").val().length > 0) {
            var n_info = getMidNameInfo();
            checkCompleteName_Midname(1, n_info);
        }
    });
    $("#ed_FIO_MN").autocomplete({
        source: function (request, response) {

            var n_info = getMidNameInfo();
            $.ajax({
                url: '/barsroot/clientregister/defaultWebService.asmx/GetListMidNames',
                data: JSON.stringify({ 'info': n_info }),
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    //collect data from server responce
                    var codes_nls = [];
                    for (var i = 0; i < data.d.length; i++) {
                        codes_nls.push(data.d[i]);
                    }
                    data.d = [];
                    response(codes_nls);
                }
            });
        },
        minLength: 2,
        select: function (event, ui) {
            //evetn if variant was swelected
        },
        focus: function (event, ui) {
            event.preventDefault();
        }
    });

    //check if user start typing ua or en language
    (function initTypingCheker() {
        var identifiers = NMKCodes.codes.data();
        for (var i in identifiers) {
            $("#" + identifiers[i]).keydown(function (e) { initTranslate(e); return true; });
        }
    })();
});