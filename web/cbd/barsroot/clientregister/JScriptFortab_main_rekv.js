$(document).ready(function () {
    $('#ed_NMK').change(function () { $(this).removeClass('err').attr('title',''); });
    $('#ed_NMKK').change(function () { $(this).removeClass('err').attr('title',''); });
    $('#ed_NMKV').change(function () { $(this).removeClass('err').attr('title',''); });
    $('#ed_OKPO').change(function () { $(this).removeClass('err').attr('title',''); });
    $('#ed_ADR').change(function () { $(this).removeClass('err').attr('title','');; });
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

    $('#ed_FIO_LN').numberMask({ pattern: fioMask});
    $('#ed_FIO_FN').numberMask({ pattern: fioMask });
    $('#ed_FIO_MN').numberMask({ pattern: fioMask });

    $('#ed_FIO_LN_NR').numberMask({ pattern: fioMask});
    $('#ed_FIO_FN_NR').numberMask({ pattern: fioMask });
    $('#ed_FIO_MN_NR').numberMask({ pattern: fioMask });
    $('#ed_FIO_4N_NR').numberMask({ pattern: fioMask });
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
    var items = ExecSync('GetCodecagentList', { CType: parent.obj_Parameters['CUSTTYPE'],rezId:getParamFromUrl('rezid', document.location.href) }).d;
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
    var items = ExecSync('GetTgrList', { CType: parent.obj_Parameters['CUSTTYPE'] }).d;
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
function checkOKPO(edit,validFromBase) {
    var status = true;
    var lenghtOKPO=10;
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
    if (strOKPO=='') {
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
            alert('Ідентифікаційний код повинен складатися з '+lenghtOKPO+' цифр. Введіть ІПН повторно.');
            $(edit).addClass('err');
            return false;
        }

        //перевірка на відповідність даті народження
        var bDay = parent.document.frames['Tab3'].document.getElementById('ed_BDAY').value;
        if (bDay != undefined && bDay != '') {
            var bDayFromOkpo = date_add_days('31.12.1899', strOKPO.substr(0, 5));
            if (bDay != bDayFromOkpo) {
                alert('Ідентифікаційний код не співпадає з датою народження. Введіть ІПН повторно.');
                $(edit).addClass('err');
                return false;
            }
        } 
        //перевірка на відповідність статі
        var ddlSex = parent.document.frames['Tab3'].document.getElementById('ddl_SEX');
        var sex = ddlSex.options[ddlSex.selectedIndex].value;
        var res = '';
        if (strOKPO.substr(strOKPO.length - 2, 1) != '0' && parent.document.frames['Tab3'].document.getElementById('ckb_main').checked) {
            res=parseInt(strOKPO.substr(strOKPO.length - 2, 1)) % 2;
            if ( sex != 0 && ((res == 0 && sex != 2) || (res == 1 && sex != 1)) ) {
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
        } else if (parent.document.frames['Tab3'].document.getElementById('ckb_main').checked) {
            //заповнюємо стать і дату народження
            parent.document.frames['Tab3'].document.getElementById('ed_BDAY').value =
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
        if (validFromBase==true)
            validOkpoFromBase(strOKPO);
    }
    //для Фізичних осіб нерезидентів
    if (custType == 'person' && rezId == 2) {
        lenghtOKPO = 9;
        if (strOKPO == '000000000') {//девять нулів
            return true;
        }
        if (strOKPO.length != lenghtOKPO) {
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
          $.post('/barsroot/customerlist/CustService.asmx/ResurectCustomer', { rnk: param.rnk }, function(data) {
            if (data.text == '') {
              parent.window.location.href = '/barsroot/clientregister/registration.aspx?readonly=' + rO1 + '&rnk=' + param.rnk;
            } else {
              parent.barsUiError({ text: data.text });
            }
          });
        } else {
          $.post('/barsroot/customerlist/CustService.asmx/ResurectCustomer', { rnk: param.rnk }, function(data) {
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
function date_add_days(date, days){ // date в формате дд.мм.гггг
    var d = new Date((new Date(date.replace(/(\d+).(\d+).(\d+)/, '$3/$2/$1 13:00:00'))).getTime() + (days * 24 * 60 * 60 * 1000));
	var day = d.getDate();
    var month = d.getMonth() + 1;
    var year = d.getFullYear();
    if (day < 10) day = '0' + day;
    if (month < 10) month = '0' + month;
    return [day,month,year].join('.');
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
                if (parent.location.href.indexOf("readonly=2") > 0)
                {
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
    if (parent.obj_Parameters['EditType'] != "Reg") {
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
    }

    HideProgress();
    parent.document.frames['Tab1'].location = "tab_rekv_nalogoplat.aspX";
    parent.document.frames['Tab2'].location = "tab_ek_norm.asPX?spd=" + getParamFromUrl('spd', document.location.href);
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
}
function getParamFromUrl(param, url) {
    url = url.substring(url.indexOf('?') + 1);
    for (var i = 0; i < url.split("&").length; i++)
        if (url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1];
    return "";
}