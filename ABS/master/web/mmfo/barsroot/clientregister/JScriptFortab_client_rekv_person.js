// служебные функция JavaScript
var ServiceUrl = '/barsroot/clientregister/defaultWebService.asmx';

var fullMobPhone = true;
var fullDomPhone = true;
var phoneInfo = [];

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

    //перевіримо чи підтверджено телефон 
    ValidatePhone.Initialize();
    
    if (parent.obj_Parameters['EditType'] == "Reg" || parent.isRegisterByScb()) {
    } else {
    }
    $('#ed_PDATE,#ed_BDAY,#ed_DATE_PHOTO,#ed_ID_ReceiveDate,#ed_ID_ExpireDate').mask("99.99.9999");
    $('#ed_ID_Number').mask("999999999");
    $('#ed_ID_RecordNum').mask("99999999-99999");
    $('#phoneConfirmSms').numberMask({ beforePoint: 6, pattern: /^[0-9]*$/ });

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
        //перевіримо чи підтверджено телефон 
        if (parent.CacParams.CellPhoneConfirmation) {
            $('#imgPhoneConfirmed, #imgPhoneNotConfirmed').hide();
            if (parent.obj_Parameters['CellPhoneConfirmed']) {
                $('#imgPhoneConfirmed').show();
            } else {
                $('#imgPhoneNotConfirmed').show();
            }
            $('#btnConfirmPhone').show();
        }
    },
    SendValidationSms: function () {
        if (!parent.Check_ClientRekvPhone(true))
            return false;
        var phone = gPhone;

        if (!phone)
			phone = $('#ed_TELM').val();

        var confirmationPhoneText = $('#ed_TELM').val();

        if (phone.indexOf("*****") !== -1) {
            phone = parent.obj_Parameters['DopRekv_MPNO'];
        }

        barsUiConfirm({
            text: 'Відправити код підтвердження на номер <b>' + confirmationPhoneText + '</b> ?',
			//text: 'Відправити код підтвердження на номер <b>' + phone + '</b> ?',
			func: function () {
                $('body').loader();

                var validationResult = ExecSync('ConfirmCellPhoneSendSms', { rnk: parent.obj_Parameters['ID'], phone: gPhone }).d;

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
        return false;
    },
    ValidateSms: function () {
        $('body').loader();

        var validationResult = ExecSync('ConfirmCellPhone', {
            rnk: parent.obj_Parameters['ID'],
            phone: gPhone,//$('#ed_TELM').val(),
            code: $('#phoneConfirmSms').val()
        }).d;

        if (validationResult.Status == 'OK') {
            $('body').loader('remove');
            $('#phoneConfirmedSmsBlock').hide();
            $('#btnConfirmPhone').show();
            $('#imgPhoneNotConfirmed').hide();
            $('#imgPhoneConfirmed').show();
            $('#phoneConfirmSms').val("");
            parent.obj_Parameters['CellPhoneConfirmed'] = true;
            parent.custAttrList['MPNO'] = { Tag: 'MPNO', Value: gPhone, Isp: '0' };
            parent.obj_Parameters['DopRekv_MPNO'].value = gPhone;
            barsUiAlert({ text: 'Телефон успішно підтверджено' });
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
    var telmCode = $('#ed_TELM_CODE');
    if (status) {
		telmCode.val('');
		telm.val('');
		//ChangeMobilePhone(telm.get(0));
		//спрятать кнопку "Просмотреть телефон", если она была показана
		$('#btnShowHidePhone').hide();
		telm.attr('disabled', 'disable');
		telm.removeClass('error');
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
    getEl('ed_DATE_PHOTO').disabled = !blFlag;
    getEl('ed_BPLACE').disabled = !blFlag;
    getEl('ddl_SEX').disabled = !blFlag;
    getEl('ed_TELM').disabled = !blFlag;
    getEl('ed_TELD').disabled = !blFlag;
	getEl('ed_TELW').disabled = !blFlag;

    getEl('btnShowHidePhone').disabled = !blFlag;
    getEl('notUseTelm').disabled = !blFlag;

    getEl('ed_TELM_CODE').disabled = !blFlag;
    getEl('ed_TELD_CODE').disabled = !blFlag;

    getEl('ed_ID_Number').disabled = !blFlag;
    getEl('ed_ID_RecordNum').disabled = !blFlag;
    getEl('ed_ID_ORGAN').disabled = !blFlag;
    getEl('ed_ID_ReceiveDate').disabled = !blFlag;
    getEl('ed_ID_ExpireDate').disabled = !blFlag;
    getEl('bt_help').disabled = !blFlag;
}
//первичное заполнение объектов
function InitObjects() {
    if (parent.obj_Parameters['EditType'] == "ReReg" || parent.isRegisterByScb()) {
        getEl('ckb_main').checked = true;
        MyChengeEnable(true);
    }
    else if (parent.obj_Parameters['EditType'] == "Reg") {
        getEl('ckb_main').checked = true;
        MyChengeEnable(true);
    }
    if (parent.obj_Parameters['EditType'] !== "ReReg") {
        //$('#datePfotoRow').hide();
    }
    if (parent.flagEnhCheck) {
        document.getElementById('ckb_main').checked = true;
        document.getElementById('ckb_main').disabled = true;
        MyChengeEnable(true);
    }
    //вставляем значения
    if (parent.obj_Parameters['EditType'] != "Reg" || parent.isRegisterByScb()) {
        if (trim(parent.obj_Parameters['PASSP']).length != 0) getEl('ddl_PASSP').selectedIndex = FindByVal(getEl('ddl_PASSP'), trim(parent.obj_Parameters['PASSP']));
        var type = getEl('ddl_PASSP').item(getEl('ddl_PASSP').selectedIndex).value;
        checkDocType(type);
        if (type == "7") { // ID картка 
            getEl('ed_ID_Number').value = parent.obj_Parameters['NUMDOC'];
            getEl('ed_ID_RecordNum').value = parent.obj_Parameters['EDDR_ID'];
            getEl('ed_ID_ORGAN').value = parent.obj_Parameters['ORGAN'];
            getEl('ed_ID_ReceiveDate').value = parent.obj_Parameters['PDATE'];
            getEl('ed_ID_ExpireDate').value = parent.obj_Parameters['ACTUAL_DATE'];
        } else {
            getEl('ed_SER').value = parent.obj_Parameters['SER'];
            getEl('ed_NUMDOC').value = parent.obj_Parameters['NUMDOC'];
            getEl('ed_ORGAN').value = parent.obj_Parameters['ORGAN'];
            getEl('ed_PDATE').value = parent.obj_Parameters['PDATE'];
        }
        getEl('ed_BDAY').value = parent.obj_Parameters['BDAY'];
        getEl('ed_DATE_PHOTO').value = parent.obj_Parameters['DATE_PHOTO'];
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
    window.parent.bars.ui.handBook('ORGANDOK', function (data) {
        if (data && data.length > 0) {
            getEl('ed_ORGAN').value = data[0].NAME;
        }
    });
    /*var result = window.showModalDialog('organdoclist.aspx', '', 'dialogHeight:200px; dialogWidth:300px');
    if (result != "undifined" && result != "") {
        getEl('ed_ORGAN').value = result;
    }*/
}
function GetIDOrganHelp() {
    window.parent.bars.ui.handBook('KOATUU_REGION_CODE', function (data) {
        if (data && data.length > 0) {
            getEl('ed_ID_ORGAN').value = data[0].CODE;
        }
    });
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
function checkDocType(type) {
    if (type == "7") {
        $('#trDocSerial,#trDocNumber,#trDocOrgan,#trDocDate').hide();
        $('#trIDNumber,#trIDRecordNum,#trIDOrgan,#trIDDate').show();
    } else {
        $('#trDocSerial,#trDocNumber,#trDocOrgan,#trDocDate').show();
        $('#trIDNumber,#trIDRecordNum,#trIDOrgan,#trIDDate').hide();
    }
}
/// Перевірка Номера запису в ЄДДР для Паспорта ID-картки
/// Аналогічна перевірка продубльована в JScriptForregistration.js -> Check_ClientRekvPerson()
function ValidateIDRecordNum() {
    var strAlert = '';
    var ed_ID_RecordNumElem = getEl('ed_ID_RecordNum');
    var strRecNum = ed_ID_RecordNumElem.value;
    var strBDate = getEl('ed_BDAY').value;
    var strSEX = getEl('ddl_SEX').selectedIndex;

    if (!strRecNum)
        strAlert += '«Унік.номер запису в ЄДДР» необхідно заповнити\n';
    else if (strRecNum.length != 14)
        strAlert += '«Унік. номер запису в ЄДДР» має бути довжиною в 14 символів\n';
    else if (!strBDate)
        strAlert += 'Заповніть спочатку дату народження\n';
    else if (!strSEX)
        strAlert += 'Необхідно вказати стать клієнта\n';
    else if (strRecNum.substr(0, 4) != strBDate.substr(6, 4) ||
             strRecNum.substr(4, 2) != strBDate.substr(3, 2) ||
             strRecNum.substr(6, 2) != strBDate.substr(0, 2))
        strAlert += 'Помилка. Перевірте значення у полях «Унік. номер запису в ЄДДР» та «Дата народження»\n';
    else {
        var iSerNum = parseInt(strRecNum.substr(9, 4),10);
        if ((strSEX == '2' && iSerNum % 2 != 0) ||
            (strSEX == '1' && iSerNum % 2 == 0) ||
            (                 iSerNum     == 0))
            strAlert += 'Помилка. Перевірте значення у полях «Унік. номер запису в ЄДДР» та «Стать»\n';
    }
    var oID_RecordNum =  $('#ed_ID_RecordNum')
    if (strAlert.length > 0) {
        barsUiError({ text: strAlert });
        oID_RecordNum.addClass('error');
        oID_RecordNum.eq(0).focus();
        oID_RecordNum.eq(0).select();
        return false;
    }
    else
        $('#ed_ID_RecordNum').removeClass('error');
    return true;
}


// Функция проверки наличия документа в БД
function ValidateDocument(ddlPassp, edSer, edNumDoc) {
    var type = ddlPassp.item(ddlPassp.selectedIndex).value;
    checkDocType(type);
    // проверяем что параметры указаны
    if (ddlPassp.selectedIndex == 0 || isEmpty(edSer) || isEmpty(edNumDoc)) {
        $('#ed_NUMDOC').removeClass('error');
        return;
    }
    var series = edSer.value;
    var number = edNumDoc.value;

    var validator = GetNumDocValidator(type);
    if (!validator.regExp.test(number) || number.length > validator.length) {
        barsUiError({ text: 'Невірно заповнено номер документа' });
        var numDocElem = $('#ed_NUMDOC');
        numDocElem.addClass('error');
        numDocElem.eq(0).focus();
        numDocElem.eq(0).select();
        //alert('Невірно заповнено номер документа');
        //document.getElementById("ed_NUMDOC").focus();
        //document.getElementById("ed_NUMDOC").select();
    } else {
        $('#ed_NUMDOC').removeClass('error');
    }

    var validationResult = ExecSync('ValidateDocument', { Type: type, Series: series, Number: number }).d;
    if (validationResult.Code != 'OK') {
        parent.bars.ui.confirm({
            text: validationResult.Text, func: function () {
                var param = eval('(' + validationResult.Param + ')');
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
                        $.post('/barsroot/customerlist/CustService.asmx/ResurectCustomer', { rnk: param.rnk }, 'xml')
                            .complete(function (data) {
                                parent.window.location.href = '/barsroot/clientregister/registration.aspx?readonly=' + rO1 + '&rnk=' + param.rnk;
                                /*if (data.text == '') {
                                parent.window.location.href = '/barsroot/clientregister/registration.aspx?readonly=' + rO1 + '&rnk=' + param.rnk;
                            } else {
                                parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                                //parent.barsUiError({ text: data.text });
                            }*/
                            })
                            .error(function () {
                                parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                            }
                            );
                        /*, function (data) {
    
                            if (data.text == '') {
                                parent.window.location.href = '/barsroot/clientregister/registration.aspx?readonly=' + rO1 + '&rnk=' + param.rnk;
                            } else {
                                parent.barsUiError({ text: data.text });
                            }
                        },'xml');*/
                    } else {
                        $.post('/barsroot/customerlist/CustService.asmx/ResurectCustomer', { rnk: param.rnk }, 'xml')
                            .complete(function (data) {
                                parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                                /*if (data.text == '') {
                                    parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                                } else {
                                    parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                                    //parent.barsUiError({ text: data.text });
                                }*/
                            })
                            .error(function () {
                                parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                            }
                        );
                        /*function (data) {
                            if (data.text == '') {
                                parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                            } else {
                                parent.barsUiError({ text: data.text });
                            }
                        }, function() {
                            parent.window.location.href = '/barsroot/clientregister/registration.aspx?rnk=' + param.rnk;
                        });*/
                    }
                }

            }
        });

        /*var ask = window.showModalDialog('dialog.aspx?type=confirm&message=' + escape(validationResult.Text), 'dialogHeight:300px; dialogWidth:400px');
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
        }*/
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
    var selection = document.selection || window.getSelection();
    if (selection.type === "Text" || selection.type === "Range") val_full = val;

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
function GetNumDocValidator(type) {
    var rexp = new RegExp(/[0-9]/);
    var length = 6;
    switch (type) {
        case "1": { // Паспорт
            rexp = new RegExp(/[0-9]/);
            length = 6;
            break;
        }
        case "3":// Свідоцтво про народження
        case "11": {// Закордонний паспорт гр.України
            rexp = new RegExp(/[0-9]/);
            length = 8;
            break;
        }
        case "5": // тимчасове посвідчення
        case "15": {// тимчасове посвідчення
            rexp = new RegExp(/[0-9]|[/]|[\\]/);
            length = 12;
            break;
        }
        case "-1":
        case "99": {// інший документ 
            rexp = new RegExp(/[\S*]/);
            length = 20;
            break;
        }
        default: { // інше
            rexp = new RegExp(/[0-9]/);
            length = 10;
            break;
        }

    }
    return { regExp: rexp, length: length };
}
function CheckDocNumber(edNumberId, ddlTypeId) {
    // ENTER пускаємо далі
    if (event.keyCode === 13) {
        return true;
    }

    var val = String.fromCharCode(event.keyCode);
    var valFull = $('#' + edNumberId).val() + val;

    // Ми щось виділили в TextBox - прибираємо перевірку на довжину
    var selectEl = document.selection || getSelection();
    if (selectEl.type == "Text") valFull = val;
    if (0 === val.length) return true;
    var validator = GetNumDocValidator($('#' + ddlTypeId).val());

    if (!validator.regExp.test(val) || valFull.length > validator.length) {
        return false;
    }

    return true;
}

function initPhone() {
    var telMobNumber = parent.obj_Parameters['DopRekv_MPNO'];
    var $edTelMobNumber = $('#ed_TELM');
    if ((parent.obj_Parameters['EditType'] !== "Reg" || parent.isRegisterByScb()) && telMobNumber !== '') {
        document.getElementById('codeMobPhone').style.display = 'none';
		fullMobPhone = false;
		HideMobilePhoneNumber();

		//$edTelMobNumber.attr('maxlength', 13).mask('+999999999999').val(telMobNumber);

        if (telMobNumber.length !== 13) {
            $edTelMobNumber.addClass('error');
        }
    } else {
        $edTelMobNumber.numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    }
    var telDomNumber = parent.obj_Parameters['TELD'];
    var $edTelDomNumber = $('#ed_TELD');
    if ((parent.obj_Parameters['EditType'] !== "Reg" || parent.isRegisterByScb()) && telDomNumber !== '') {
        document.getElementById('codeCityPhone').style.display = 'none';
        fullDomPhone = false;
        $edTelDomNumber.attr('maxlength', 13).mask('+999999999999').val(telDomNumber);
        if (telDomNumber.length !== 13) {
            $edTelDomNumber.addClass('error');
        }
    } else {
        $edTelDomNumber.numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
    }
    //запамятовуємо початковий номер + флаг підтвердження
    phoneInfo[parent.obj_Parameters['DopRekv_MPNO']] = parent.obj_Parameters['CellPhoneConfirmed'];
}

function initShowHidePhoneButton() {
	var accesIsAllowed = ExecSync('CheckUserAcessMode', {}).d;
    var telMobNumber = parent.obj_Parameters['DopRekv_MPNO'];
    if (accesIsAllowed && telMobNumber != '000-00-00' && telMobNumber != '')
        $('#btnShowHidePhone').show();
}

var gPhone = null;
function ChangeMobilePhone(elem) {
    var mobNum = '';
    var oldPhone = parent.obj_Parameters['DopRekv_MPNO'];
    var oldConfirm = parent.obj_Parameters['CellPhoneConfirmed'];
    var changeParent = true;

	//прячем кнопку, если она была показана
	$('#btnShowHidePhone').hide();

    if (elem) {
        if (fullMobPhone /*parent.obj_Parameters['EditType'] == "Reg"*/) {
            mobNum = '+380' + document.getElementById('ed_TELM_CODE').value;
        }
        mobNum += elem.value.replace('-', '').replace('(', '').replace(')', '');

        if (mobNum === '+380') {
            mobNum = '';
        }
        gPhone = mobNum;
        //якщо поміняли на непідтвердженний телефон - скидуємо флаг
        if (oldConfirm && oldPhone !== mobNum) {
            parent.obj_Parameters['CellPhoneConfirmed'] = false;
            ValidatePhone.Initialize();
            changeParent = false;
        } else if (phoneInfo[oldPhone] && oldPhone === mobNum) {
            parent.obj_Parameters['CellPhoneConfirmed'] = true;
            ValidatePhone.Initialize();
            changeParent = true;    
        }

        //для фіз осіб не спд виконуємо валідацію мобільного телефону
        if (parent.obj_Parameters['CUSTTYPE'] === 'person' && !parent.isCustomerSpd()) {
            //var validationResult = ExecSync('ValidateMobilePhone', { rnk: (parent.obj_Parameters['ID'] === '' ? 0 : parent.obj_Parameters['ID']), phone: mobNum }).d;

            //if (validationResult.Code !== 'OK') {
            //    alert(validationResult.Text);
            //    if (parent.custAttrList['MPNO']) {
            //        if (fullMobPhone) {
            //            elem.value = parent.custAttrList['MPNO'].Value
            //                .replace('+380', '')
            //                .replace(document.getElementById('ed_TELM_CODE').value, '');
            //        } else {
            //            elem.value = parent.custAttrList['MPNO'].Value;
            //        }
            //    } else {
            //        elem.value = '';
            //    }
            //    return false;
            //}

            $('#loading').css('display', 'block');

            setTimeout(
                function () {
					var validationResult = ExecSync('ValidateMobilePhone', { rnk: (parent.obj_Parameters['ID'] === '' ? 0 : parent.obj_Parameters['ID']), phoneOkpo: mobNum + "&" + parent.obj_Parameters["OKPO"] }).d; //окпо потрібне бля уточнення різниці між фо та спд
					$('#loading').css('display', 'none');																																							//фо та спд може дути одна і таж особа
																																																					//Імпорт з РУ
                    if (validationResult.Code !== 'OK') {
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
                }, 0
            );

        }
    }
    if (changeParent) {
        parent.custAttrList['MPNO'] = { Tag: 'MPNO', Value: mobNum, Isp: '0' };
        parent.obj_Parameters['DopRekv_MPNO'].value = mobNum;
    }
    return false;   
}

function ShowHideMobilePhoneNumber(elem) {
    var mobPhone = document.getElementById('ed_TELM');
    var hideMobPhoneButton = document.getElementById('btnShowHidePhone');
    if (hideMobPhoneButton.className.indexOf("masked") > -1) {
        hideMobPhoneButton.className = "";
        mobPhone.value = parent.obj_Parameters['DopRekv_MPNO'];
        hideMobPhoneButton.value = "Замаскувати номер";
        //log the event of pressing the button
        ExecSync('LogShowMPhone', { rnk: (parent.obj_Parameters['ID'] === '' ? 0 : parent.obj_Parameters['ID']), phone: mobPhone.value });
    }
    else {
        hideMobPhoneButton.className = "masked";
        hideMobPhoneButton.value = "Переглянути номер";

        //mask mobile phone number:
        HideMobilePhoneNumber();
    }
}

function HideMobilePhoneNumber() {
    var telMobNumber = parent.obj_Parameters['DopRekv_MPNO'];
    var $edTelMobNumber = $('#ed_TELM');

    if (telMobNumber != '000-00-00' && telMobNumber != '') {
        var tempTelMobNumber = telMobNumber.slice(0, 6) + '*****' + telMobNumber.slice(11, 13);
        $edTelMobNumber.attr('maxlength', 13).mask('+999999999999').val(tempTelMobNumber);
    }
    else {
        $edTelMobNumber.attr('maxlength', 13).mask('+999999999999').val(telMobNumber);
    }
}


//Коди моб. тел.
function GetCODEtelList(elem, table) {

    window.parent.bars.ui.handBook(table, function (data) {
        if (data && data.length > 0) {
            PutIntoEdit(elem, data[0].PrimaryKeyColumn);

            ToDoOnChange();
            if (table == 'phone_mob_code') {
                $('#ed_TELM').attr('maxlength', 9 - data[0].PrimaryKeyColumn.length);
            } else {
                $('#ed_TELD').attr('maxlength', 9 - data[0].PrimaryKeyColumn.length);
            }
        }
    });

    /*var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=' + table + '&tail=\'\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px');
    if (result != null) {
        PutIntoEdit(elem, result[0]);
        ToDoOnChange();
        if (table == 'phone_mob_code') {
            $('#ed_TELM').attr('maxlength', 9 - result[0].length);
        } else {
            $('#ed_TELD').attr('maxlength', 9 - result[0].length);
        }
    }*/
    // $get('ed_COUNTRYCd').value = $get('ddl_COUNTRY').item($get('ddl_COUNTRY').selectedIndex).value;
}

$(document).ready(function () {
    var arrDocTypesUA = ['1']; // типи документів по яким потрібне перекодування в кирилицю
    //Візуально приховуємо ознаку обов'язковості дом телефону для фоп спд
    if (parent.obj_Parameters['CUSTTYPE'] === 'person' && parent.isCustomerSpd()) {   
        $("#ed_TELD_star").hide();
    }
	//Користувачі рівня 3 не можуть редагувати телефон
    if ($("#b_depth").val() == 3) {
        if ((parent.obj_Parameters['EditType'] !== "Reg" || parent.isRegisterByScb()) && $("#ed_TELM").val() !== '') {
            $("#ed_TELM").attr('disabled', true);
        }
    }
    // для перекодування на кирилицю 
    $("#ed_SER").keydown(function (e) {
        // 
        var docType = $('#ddl_PASSP');
        if (docType && jQuery.inArray(docType.val(), arrDocTypesUA) >= 0 && $("#ed_SER").val().length < 2) {
            initTranslate(e);
        }
        return true;
    });
    $("#ed_ORGAN").keydown(function (e) {
        var docType = $('#ddl_PASSP');
        if (docType && jQuery.inArray(docType.val(), arrDocTypesUA) >= 0 ) { initTranslate(e); }
        return true;
    });
    $("#ed_BPLACE").keydown(function (e) { initTranslate(e); return true; });

    initShowHidePhoneButton();
});