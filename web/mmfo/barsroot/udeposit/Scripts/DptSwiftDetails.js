// ---------- //
// 21.04.2016 //
// ---------- //

var isInit = false;
var mode = null;
var dpu_id = null;

window.onload = InitSwiftDetails;

// ************************************************** //
// Initialize
function InitSwiftDetails() {
    webService.useService("udptService.asmx?wsdl", "DPU");
    mode = getParamFromUrl("mode", location.href);
    dpu_id = getParamFromUrl("dpu_id", location.href);

    if (dpu_id > 0) {
        populateForm();
        if (mode == 2) {
            // readOnly mode
            document.getElementById('tbBankBeneficiaryAccount').disabled = disable;
            document.getElementById('tbBeneficiaryAccount').disabled = disable;
            document.getElementById('btSave').disabled = disable;
        }
    }
    else {
        window.close();
        return;
    }

    if (!isInit) {
        // AddListeners("tbBankBeneficiaryAccount,", 'onkeydown', TreatEnterAsTab);
    }
    isInit = true;
}

function fnBankSWIFTCode(button){
    var title = escape("Вибір банку-" + (button.id == "btBankIntermediaryCode" ? "посередника" : "бенефіціара"));
    var tail = "BIC != '-1'";
    var result = window.showModalDialog(url_dlg_mod + 'SW_BANKS&tail="' + tail + '"&title=' + title, window, "dialogHeight:700px;dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
    var d = document.all;
    if (result) {
        if (button.id == "btBankIntermediaryCode") {
            d.tbBankIntermediaryName.value = result[1];
            d.tbBankIntermediaryAddress.value = result[2] + " " + result[3];
            d.tbBankIntermediaryCode.value = result[0];
            fnChangeButtonAction(button);
        }
        if (button.id == "btBankBeneficiaryCode") {
            d.tbBankBeneficiaryName.value = result[1];
            d.tbBankBeneficiaryAddress.value = result[2] + " " + result[3];
            d.tbBankBeneficiaryCode.value = result[0];
            fnChangeButtonAction(button);
        }
    }
}

//
function fnClearSWIFT(button) {
    var d = document.all;
    if (button.id == "btBankIntermediaryCode") {
        if (confirm("Видалити реквізити банку-посередника?")) {
            d.tbBankIntermediaryName.value = "";
            d.tbBankIntermediaryAddress.value = "";
            d.tbBankIntermediaryCode.value = "";
            fnChangeButtonAction(button);
        }
    }
    if (button.id == "btBankBeneficiaryCode") {
        if (confirm("Видалити реквізити банку-бенефіціара?")) {
            d.tbBankBeneficiaryName.value = "";
            d.tbBankBeneficiaryAddress.value = "";
            d.tbBankBeneficiaryCode.value = "";
            fnChangeButtonAction(button);
        }
    }
}

//
function fnChangeButtonAction(button) {
    var hasVal;
    if (button.id == "btBankIntermediaryCode") {
        hasVal = ((document.all.tbBankIntermediaryCode.value == "") ? false : true );
    }
    if (button.id == "btBankBeneficiaryCode") {
        hasVal = ((document.all.tbBankBeneficiaryCode.value == "") ? false : true);
    }

    if (hasVal) {
        button.src = "/Common/Images/delete.gif";
        button.onclick = function () { fnClearSWIFT(this); };
    }
    else {
        button.src = "/Common/Images/BOOK.gif";
        button.onclick = function () { fnBankSWIFTCode(this); };
    }
}

//
function populateForm() {
    webService.DPU.callService(onPopulateForm, "GetSwiftDetails", dpu_id);
}

function onPopulateForm(result) {
    if (!getError(result)) {
        return;
    }
    else {
        var data = result.value;

        document.all.tbBankIntermediaryName.value = data[0].text;
        document.all.tbBankIntermediaryAddress.value = data[1].text;
        document.all.tbBankIntermediaryCode.value = data[2].text;
        fnChangeButtonAction(document.all.btBankIntermediaryCode);

        document.all.tbBankBeneficiaryName.value = data[3].text;
        document.all.tbBankBeneficiaryAddress.value = data[4].text;
        document.all.tbBankBeneficiaryCode.value = data[5].text;
        document.all.tbBankBeneficiaryAccount.value = data[6].text;
        fnChangeButtonAction(document.all.btBankBeneficiaryCode);

        document.all.tbBeneficiaryName.value = data[7].text;
        document.all.tbBeneficiaryAddress.value = data[8].text;
        document.all.tbBeneficiaryAccount.value = data[9].text;
    }
}

function fnValidate(nameCheck) {

    var d = document.all;
    var errMsg = "";

    if (d.tbBankBeneficiaryAccount.value != "") {
        if (d.tbBankIntermediaryAddress.value == "") {
            errMsg += "Адреса Банка-Посередника;" + "\r\n";
        }
        if (d.tbBankIntermediaryName == "") {
            errMsg += "Назва Банка-Посередника;" + "\r\n";
        }
        if (d.tbBankIntermediaryCode == "") {
            errMsg += "SWIFT-код Банка-Посередника;" + "\r\n";
        }
    }

    if (d.tbBankBeneficiaryName.value == "") {
        errMsg += "Назва банку-бенефіціара;" + "\r\n";
    }

    if (d.tbBankBeneficiaryAddress.value == "") {
        errMsg += "Адреса банку-бенефіціара;" + "\r\n";
    }

    if (d.tbBankBeneficiaryCode.value == "") {
        errMsg += "Код банку-бенефіціара;" + "\r\n";
    }

    if (d.tbBankBeneficiaryAccount.value == "" && d.tbBankIntermediaryCode.value != "") {
        // якщо вказані реквізити Банка-Посередника але Не вказано Рахунок Банку-Бенефіціара в Банку-Посереднику
        errMsg += "Рахунок Банку-Бенефіціара в Банку-Посереднику!" + "\r\n";
    }

    if (d.tbBeneficiaryName.value == "") {
        errMsg += "Назва бенефіціара;" + "\r\n";
    }

    if (d.tbBeneficiaryAddress.value == "") {
        errMsg += "Адреса бенефіціара;" + "\r\n";
    }

    if (d.tbBeneficiaryAccount.value == "") {
        errMsg += "Рахунок бенефіціара;" + "\r\n";
    }

    if (errMsg == "") {
        return true;
    }
    else {
        errMsg = "Не вказано значення в поле(я):<br>" + errMsg;
        Dialog(errMsg, "alert");
        ///alert(errMsg);
        return false;
    }
}

// ************************************************** //
// SAVE and EXIT
function fnSave() {
    if ( fnValidate('ALL') ) {
        if (Dialog("Зберегти зміни внесенні в SWIFT реквізити?", "confirm") == 1) {
            var d = document.all;
            var swiftData = new Array();
            swiftData[0] = d.tbBankIntermediaryName.value;
            swiftData[1] = d.tbBankIntermediaryAddress.value;
            swiftData[2] = d.tbBankIntermediaryCode.value;

            swiftData[3] = d.tbBankBeneficiaryName.value;
            swiftData[4] = d.tbBankBeneficiaryAddress.value;
            swiftData[5] = d.tbBankBeneficiaryCode.value;
            swiftData[6] = d.tbBankBeneficiaryAccount.value;

            swiftData[7] = d.tbBeneficiaryName.value;
            swiftData[8] = d.tbBeneficiaryAddress.value;
            swiftData[9] = d.tbBeneficiaryAccount.value;
            webService.DPU.callService(onSave, "SetSwiftDetails", dpu_id, swiftData);
        }
        else {
            return;
        }
    }
}

function onSave(result) {
    if (!getError(result)) {
        return;
    }

    if (result.value == "") {
        Dialog("Зміни успішно збережені!", "alert");
        window.close();
    }
    else {
        Dialog(result.value, "alert");
    }
}

// ************************************************** //
// EXIT
function fnCancel() {
    window.close();
}