// аналог trim
function trim(a) {
    if (a == null) return null;
    return a.replace(/^\s*|\s*$/g, '');
}
// проверка правильности даты
function isDate(a) {
    var flag = false;
    var re = RegExp('\\d\\d.\\d\\d.\\d\\d\\d\\d');
    if (a.replace(re, '') == '') flag = true;

    return flag;
}
function isDateCheck(edit) {
    if (!isDate(edit.value)) {
        alert(LocalizedString('Message1'));
        edit.focus();
    }
}
// проверка правильности числа
function isNumber(a) {
    var flag = false;

    var re = RegExp('\\d*');
    a = a.replace(re, '');

    if (trim(a.replace('.', '').replace(',', '').replace('-', '')) == '') flag = true;

    if (a.charAt(a.length - 1) == '.' || a.charAt(a.length - 1) == ',') flag = false;
    if (a.charAt(0) == '.' || a.charAt(0) == ',') flag = false;
    if (a.replace('-', '') != a) {
        if (a.indexOf('-') != 0) flag = false;
    }

    return flag;
}
//реакция если введено не число в числовое поле
function isNumberCheck(edit) {
    if (!isNumber(edit.value)) {
        alert(LocalizedString('Message2'));
        edit.focus();
    }
}
//реакция если введено пустое значение в эдит
function isEmpty(edit) {
    return (edit == null || edit.value == null || trim(edit.value).length == 0)
}
function isEmptyCheck(edit) {
    if (isEmpty(edit)) {
        alert(LocalizedString('Message3'));
        edit.focus();
    }
}
//задизейблить все сразу
function DisableAll(elem, flag) {
    var boolFlag = ((flag == 'true') ? (true) : (false));
    var myTags = new Array('input', 'table', 'select');

    if (boolFlag) {
        for (i = 0; i < myTags.length; i++) {
            var tmp = document.getElementsByTagName(myTags[i]);
            for (j = 0; j < tmp.length; j++)
                if (tmp[j].disabled != null) tmp[j].disabled = boolFlag;
        }
    }
}
//поиск индекса в ДДЛ по заданому значению
function FindByVal(ddl, val) {
    for (i = 0; i < ddl.options.length; i++) {
        if (ddl.item(i).value == val) {
            return i;
        }
    }
    return 0;
}
// возвращает елемент
function getEl(elName) {
    return (document.getElementById(elName));
}
//достаем элемент из фрейма
function gE(curFrm, elName) {
    if (curFrm != null) return (curFrm.document.getElementById(elName));
    else return null;
}
//вставляет значение в эдит
function PutIntoEdit(edit, val) {
    var myVal = String();
    myVal = val;
    if (myVal != null && myVal != "undifined" && myVal != "") {
        edit.value = myVal;
    }
}
function test() {
    var xml_visaData = new ActiveXObject('MSXML2.DOMDocument');
    var a = 5;
}

// jquery alert
var _dialogID;
function InitAlert(dialogID) {
    _dialogID = '#' + dialogID;
    $(_dialogID).dialog({
        autoOpen: false,
        modal: true,
        height: 360,
        width: 470,
        buttons: {
            Ok: function () {
                $(this).dialog('close');
            }
        }


    });
}
function ShowAlert(textHtml, title) {
    // загловок
    if (title) $(_dialogID).dialog({ title: title });
    // внутр текст
    $(_dialogID).html(textHtml);
    // показываем
    $(_dialogID).dialog("open");
    $(_dialogID).dialog("option", {
        position: {
            my: "center",
            at: "center",
            of: window
        }
    });
}