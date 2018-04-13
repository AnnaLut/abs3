// служебные функция JavaScript
var ServiceUrl = '/barsroot/clientregister/defaultWebService.asmx';

var fullMobPhone = true;
var fullDomPhone = true;

$(function () {
    $('.edit').change(function () {
        ToDoOnChange();
    });
    InitObjects();
    $('#ed_TELM_CODE').on('click', function () {
        GetCODEtelList(this, 'phone_mob_code');
    });
    $('#ed_TELD_CODE').on('click', function () {
        GetCODEtelList(this, 'phone_city_code');
    });

    if (parent.obj_Parameters['EditType'] == "Reg") {
        //$('#ed_TELM,#ed_TELD').attr('maxlength', '7');
        //$('#ed_TELM,#ed_TELD').numberMask({ beforePoint: 10, pattern: /^\+*[0-9]*$/ });  
    } else {
        //перевіримо чи підтверджено телефон 
        ValidatePhone.Initialize();

        //$('#ed_TELM,#ed_TELD').mask("+38(099)999-99-99");
    }
    $('#ed_PDATE,#ed_BDAY').mask("99.99.9999");

    $('#notUseTelm').on('change', function () {
        if ($(this).is(':checked')) {
            showNotMobilePhoneMessage();
        } else {
            $('#ed_TELM').removeAttr('disabled');
        }
    });
});

//валідація мобільного телефону
var ValidatePhone = {
    Initialize: function () {
        if (parent.obj_Parameters['EditType'] == "Reg") {

        } else {
            //перевіримо чи підтверджено телефон 
            if (parent.CacParams.CellPhoneConfirmation) {
                if (parent.obj_Parameters['CellPhoneConfirmed']) {
                    $('#imgPhoneConfirmed').show();
                } else {
                    $('#imgPhoneNotConfirmed').show();
                }
                $('#btnConfirmPhone').show();
            }

            //$('#ed_TELM,#ed_TELD').mask("+38(099)999-99-99");
        }
    },
    SendValidationSms: function () {
        barsUiConfirm({
            text: 'Відправити код підтвердження на номер <b>' + $('#ed_TELM').val() + '</b> ?',
            func: function () {
                $('body').loader();

                var validationResult = ExecSync('ConfirmCellPhoneSendSms', { rnk: parent.obj_Parameters['ID'], phone: $('#ed_TELM').val() }).d;

                if (validationResult.Status == 'OK') {
                    $('body').loader('remove');
                    $('#phoneConfirmedSmsBlock').show();
                    $('#btnConfirmPhone').hide();
                } else {
                    $('body').loader('remove');
                    barsUiError({ text: validationResult.Message });
                }
            }
        });

    },
    ValidateSms: function () {
        $('body').loader();

        var validationResult = ExecSync('ConfirmCellPhone', { 
            rnk: parent.obj_Parameters['ID'],
            phone: $('#ed_TELM').val(), 
            code: $('#phoneConfirmSms').val()
        }).d;

        if (validationResult.Status == 'OK') {
            $('body').loader('remove');
            $('#phoneConfirmedSmsBlock').hide();
            $('#btnConfirmPhone').show();
            $('#imgPhoneNotConfirmed').hide();
            $('#imgPhoneConfirmed').show();
            $('#phoneConfirmSms').val("");
            barsUiAlert({text:'Телефон успішно підтверджено'});
        } else {
            $('body').loader('remove');
            barsUiError({ text: validationResult.Message });
        }
    },
    CancelValidate: function () {
        $('#phoneConfirmSms').val("");
        $('#phoneConfirmedSmsBlock').hide();
        $('#btnConfirmPhone').show();
    }
}

function showNotMobilePhoneMessage() {
    var text = 'Я, ' + parent.userFio + ', ' +
                'підтверджую відсутність мобільного телефону у клієнта станом на ' + getDateString() + '. ' +
                'Не заперечую проти перевірки Банком достовірності наданої мною інформації. ' +
                'Мені відомо, що подання недостовірної інформації тягне за собою ' +
                'відповідальність (дисциплінарні стягнення та інше) ' +
                'згідно з чинним законодавством України';
    var status = confirm(text);
    var telm = $('#ed_TELM');
    if (status) {
        telm.val('');
        //ChangeMobilePhone(telm.get(0));
        telm.attr('disabled', 'disable');
    } else {
        telm.removeAttr('disabled');
        $('#notUseTelm').removeAttr('checked');
    }
    /*var confirmDialog = $('<div id="NotMobilePhoneDialog">'+text+'</div>');
    confirmDialog.dialog({
        bgiframe: true,
        dialogClass: '',
        buttons: [
            {
                text: 'Підтверджую',
                click: function () {
                    $('#ed_TELM').val('');
                    ChangeMobilePhone();
                    $('#ed_TELM').attr('disabled', 'disable');
                    confirmDialog.dialog('close');
                }
            },
            {
                text: 'Не підтверджую',
                'class': 'ui-button-link',
                click: function () {
                    $('#ed_TELM').removeAttr('disabled');
                    $('#notUseTelm').removeAttr('checked');
                    confirmDialog.dialog('close');
                }
            }],
        autoOpen: true,
        position: { at: 'center' },
        title: 'Підтвердження',
        modal: true,
        resizable: true,
        minWidth: '400',
        minHeight: '150',
        height: 250,
        close: function () {
            confirmDialog.remove();
        }
    });*/

}

function getDateString() {
    var date = new Date();
    var day = parseInt(date.getDate());
    if (day < 10) {
        day = '0' + day;
    }
    var month = parseInt(date.getMonth(), 10) + 1;
    if (month < 10) {
        month = '0' + month;
    }
    return day + '/' + month + '/' + date.getFullYear();
}

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


//делаем доступными/недоступными все элементы
function MyChengeEnable(Flag) {
    var blFlag = true;
    if (Flag == 'false' || Flag == false) blFlag = false;

    parent.obj_Parameters['RCFlPres'] = blFlag;
    getEl('ddl_PASSP').disabled = !blFlag;
    getEl('ed_SER').disabled = !blFlag;
    getEl('ed_NUMDOC').disabled = !blFlag;
    getEl('ed_ORGAN').disabled = !blFlag;
    getEl('ed_PDATE').disabled = !blFlag;
    getEl('ed_BDAY').disabled = !blFlag;
    getEl('ed_BPLACE').disabled = !blFlag;
    getEl('ddl_SEX').disabled = !blFlag;
    getEl('ed_TELM').disabled = !blFlag;
    getEl('ed_TELD').disabled = !blFlag;
    getEl('ed_TELW').disabled = !blFlag;
    getEl('ed_TELM_CODE').disabled = !blFlag;
    getEl('ed_TELD_CODE').disabled = !blFlag;

    getEl('bt_help').disabled = !blFlag;
}
//первичное заполнение объектов
function InitObjects() {
    if (parent.obj_Parameters['EditType'] == "ReReg") {
        getEl('ckb_main').checked = true;
        MyChengeEnable(true);
    }
    else if (parent.obj_Parameters['EditType'] == "Reg") {
        getEl('ckb_main').checked = true;
        MyChengeEnable(true);
    }
    if (parent.flagEnhCheck) {
        document.getElementById('ckb_main').checked = true;
        document.getElementById('ckb_main').disabled = true;
        MyChengeEnable(true);
    }
    //вставляем значения
    if (parent.obj_Parameters['EditType'] != "Reg") {
        if (trim(parent.obj_Parameters['PASSP']).length != 0) getEl('ddl_PASSP').selectedIndex = FindByVal(getEl('ddl_PASSP'), trim(parent.obj_Parameters['PASSP']));
        getEl('ed_SER').value = parent.obj_Parameters['SER'];
        getEl('ed_NUMDOC').value = parent.obj_Parameters['NUMDOC'];
        getEl('ed_ORGAN').value = parent.obj_Parameters['ORGAN'];
        getEl('ed_PDATE').value = parent.obj_Parameters['PDATE'];
        getEl('ed_BDAY').value = parent.obj_Parameters['BDAY'];
        getEl('ed_BPLACE').value = parent.obj_Parameters['BPLACE'];
        if (trim(parent.obj_Parameters['SEX']).length != 0) getEl('ddl_SEX').selectedIndex = FindByVal(getEl('ddl_SEX'), trim(parent.obj_Parameters['SEX']));
        getEl('ed_TELM').value = parent.obj_Parameters['DopRekv_MPNO'];
        getEl('ed_TELD').value = parent.obj_Parameters['TELD'];
        getEl('ed_TELW').value = parent.obj_Parameters['TELW'];
    }

    initPhone();

    DisableAll(document, parent.obj_Parameters['ReadOnly']);

    HideProgress();
}
function GetOrganHelp() {
    var result = window.showModalDialog('organdoclist.aspx', '', 'dialogHeight:200px; dialogWidth:300px');
    if (result != "undifined" && result != "") {
        getEl('ed_ORGAN').value = result;
    }
}

function MyAddRow(grdName) {
    igtbl_addNew(grdName, 0);
}
function MyDeleteRow(grdName) {
    igtbl_deleteSelRows(grdName);
}
function MyBeforeCellChange(gn, id) {
    ToDoOnChange();
}
function MyBeforeEnterEditMode(gn, id) {
    var row = igtbl_getRowById(id);
    var col = id.slice(id.lastIndexOf('_') + 1);
    var cell = row.getCell(col);
    var colKey = cell.Column.Key;
    var docs = Array('MFO', 'KV', 'NAME', 'COUNTRY');
    var docsTabs = Array('BANKS', 'TABVAL', 'CUSTOMER_ADDRESS_TYPE', 'COUNTRY');
    var docsTails = Array('', '', 'ID not in (1)', '');

    for (var i = 0; i < docs.length; i++)
        if (colKey == docs[i]) {
            var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=' + docsTabs[i] + '&tail=\'' + escape(docsTails[i]) + '\'&role=WR_CUSTREG', window, 'dialogHeight:600px; dialogWidth:600px');
            if (result != null) {
                // id типа адреса				
                if (colKey == 'NAME') {
                    row.getCell(col - 1).setValue(result[0]);
                    cell.setValue(result[1]);
                }
                else {
                    cell.setValue(result[0]);
                }
            }
        }
}

// Функция проверки наличия документа в БД

function ValidateDocument(ddlPassp, edSer, edNumDoc) {
    // проверяем что параметры указаны
    if (ddlPassp.selectedIndex == 0 || isEmpty(edSer) || isEmpty(edNumDoc)) {
        return;
    }

    var type = ddlPassp.item(ddlPassp.selectedIndex).value;
    var series = edSer.value;
    var number = edNumDoc.value;
    var validationResult = ExecSync('ValidateDocument', { Type: type, Series: series, Number: number }).d;
    if (validationResult.Code != 'OK') {
        var ask = window.showModalDialog('dialog.aspx?type=confirm&message=' + escape(validationResult.Text), 'dialogHeight:300px; dialogWidth:400px');
        var param = eval('(' + validationResult.Param + ')');

        if (ask == '1') {

            if (param.DateClose == '') {
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

function CheckDocSeries(edSeriesID, ddlTypeID) {
    // ENTER пускаємо далі
    if (event.keyCode == 13) {
        return true;
    }

    var val = String.fromCharCode(event.keyCode);
    var val_full = $('#' + edSeriesID).val() + val;

    // Ми щось виділили в TextBox - прибираємо перевірку на довжину
    if (document.selection.type == "Text") val_full = val;

    switch ($('#' + ddlTypeID).val()) {
        case "1":
            {
                // Паспорт
                var rexp = new RegExp(/[А-ЯІЄЇ]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 2)
                    return false;

                break;
            }
        case "11":
            {
                // Закордонний паспорт гр.України
                var rexp = new RegExp(/[A-Z]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 2)
                    return false;

                break;
            }
        case "3":
            {
                // Свідоцтво про народження
                var rexp = new RegExp(/[A-ZА-ЯІЄЇ0-9\-]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 7)
                    return false;

                break;
            }
        default:
            {
                // інше
                var rexp = new RegExp(/[A-ZА-ЯІЄЇ0-9\-]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 7)
                    return false;

                break;
            }
    }

    return true;
}
function CheckDocNumber(edNumberID, ddlTypeID) {
    // ENTER пускаємо далі
    if (event.keyCode == 13) {
        return true;
    }

    var val = String.fromCharCode(event.keyCode);
    var val_full = $('#' + edNumberID).val() + val;

    // Ми щось виділили в TextBox - прибираємо перевірку на довжину
    if (document.selection.type == "Text") val_full = val;

    switch ($('#' + ddlTypeID).val()) {
        case "1":
            {
                // Паспорт
                var rexp = new RegExp(/[0-9]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 6)
                    return false;

                break;
            }
        case "11":
            {
                // Закордонний паспорт гр.України
                var rexp = new RegExp(/[0-9]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 8)
                    return false;

                break;
            }
        case "3":
            {
                // Свідоцтво про народження
                var rexp = new RegExp(/[0-9]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 8)
                    return false;

                break;
            }
        case "5":
            {
                // тимчасове посвідчення
                var rexp = new RegExp(/[0-9]|[/]|[\\]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 12)
                    return false;
                break;
            }
        case "15":
            {
                // тимчасове посвідчення
                var rexp = new RegExp(/[0-9]|[/]|[\\]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 12)
                    return false;
                break;
            }
        default:
            {
                // інше
                var rexp = new RegExp(/[0-9]/);

                if (0 == val.length) return true;
                if (!rexp.test(val) || val_full.length > 10)
                    return false;

                break;
            }
    }

    return true;
}

function initPhone() {
    if (parent.obj_Parameters['EditType'] != "Reg" && parent.obj_Parameters['DopRekv_MPNO'] != '') {
        document.getElementById('codeMobPhone').style.display = 'none';
        fullMobPhone = false;
        $('#ed_TELM').attr('maxlength', 13).mask('+999999999999');
    } else {
        $('#ed_TELM').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    }
    if (parent.obj_Parameters['EditType'] != "Reg" && parent.obj_Parameters['TELD'] != '') {
        document.getElementById('codeCityPhone').style.display = 'none';
        fullDomPhone = false;
        $('#ed_TELD').attr('maxlength', 13).mask('+999999999999');
    } else {
        $('#ed_TELD').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    }
}

function ChangeMobilePhone(elem) {
    var mobNum = '';
    var oldResult = elem.value;
    if (elem) {
        if (fullMobPhone /*parent.obj_Parameters['EditType'] == "Reg"*/) {
            mobNum = '+380' + document.getElementById('ed_TELM_CODE').value;
        }
        mobNum += elem.value.replace('-', '').replace('(', '').replace(')', '');

        var validationResult = ExecSync('ValidateMobilePhone', { rnk: (parent.obj_Parameters['ID'] == '' ? 0 : parent.obj_Parameters['ID']), phone: mobNum }).d;

        if (validationResult.Code != 'OK') {
            alert(validationResult.Text);
            if (parent.custAttrList['MPNO']) {
                if (fullMobPhone) {
                    elem.value = parent.custAttrList['MPNO'].Value
                        .replace('+380', '')
                        .replace(document.getElementById('ed_TELM_CODE').value, '');
                } else {
                    elem.value = parent.custAttrList['MPNO'].Value;
                }
            } else {
                elem.value = '';
            }

            return false;
        }

    }


    parent.custAttrList['MPNO'] = { Tag: 'MPNO', Value: mobNum, Isp: '0' };
    parent.obj_Parameters['DopRekv_MPNO'].value = mobNum;
}

//Коди моб. тел.
function GetCODEtelList(elem, table) {
    var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=' + table + '&tail=\'\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px');
    if (result != null) {
        PutIntoEdit(elem, result[0]);
        ToDoOnChange();
        if (table == 'phone_mob_code') {
            $('#ed_TELM').attr('maxlength', 9 - result[0].length);
        } else {
            $('#ed_TELD').attr('maxlength', 9 - result[0].length);
        }
    }
    // $get('ed_COUNTRYCd').value = $get('ddl_COUNTRY').item($get('ddl_COUNTRY').selectedIndex).value;
}