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


//делаем доступными/недоступными все элементы
function MyChengeEnable(Flag) {
    var blFlag = new Boolean();
    blFlag = true;
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
    getEl('ed_TELD').disabled = !blFlag;
    getEl('ed_TELW').disabled = !blFlag;

    getEl('bt_help').disabled = !blFlag;
}
//первичное заполнение объектов
function InitObjects() {
    if (parent.obj_Parameters['EditType'] == "ReReg") {
        getEl('ckb_main').checked = true;
        MyChengeEnable(true);
    }
    else if (parent.obj_Parameters['EditType'] == "Reg") {
        getEl('ckb_main').checked = false;
        MyChengeEnable(false);
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
        getEl('ed_TELD').value = parent.obj_Parameters['TELD'];
        getEl('ed_TELW').value = parent.obj_Parameters['TELW'];
    }
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

    for (i = 0; i < docs.length; i++)
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
    if (ddlPassp.selectedIndex == 0 ||
        isEmpty(edSer) ||
        isEmpty(edNumDoc)) {
        return;
    }

    var Type = ddlPassp.item(ddlPassp.selectedIndex).value;
    var Series = edSer.value;
    var Number = edNumDoc.value;

    var ValidationResult = ExecSync('ValidateDocument', { Type: Type, Series: Series, Number: Number }).d;

    if (ValidationResult.Code != 'OK') {
        var msg = escape(ValidationResult.Text);
        var ask = window.showModalDialog('dialog.aspx?type=confirm&message=' + msg, 'dialogHeight:300px; dialogWidth:400px');
        if (ask == '1') {
            var rnk = ValidationResult.Param;
            parent.window.location.replace('/barsroot/clientregister/registration.aspx?rnk=' + rnk);
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
