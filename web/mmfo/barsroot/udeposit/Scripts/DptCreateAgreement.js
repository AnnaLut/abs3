// ---------- //
// 04.07.2017 //
// ---------- //

var isInit = false;
var mode = null;
var dpu_id = null;
var our_mfo = null;
var kv = "";
var rnk = null;

window.onload = InitDptAgreement;

// ************************************************** //
// Initialize
function InitDptAgreement() {
    webService.useService("udptService.asmx?wsdl", "DPU");
    mode = getParamFromUrl("mode", location.href);
    dpu_id = getParamFromUrl("dpu_id", location.href);
    rnk = getParamFromUrl("rnk", location.href);
    kv = getParamFromUrl("kv", location.href);

    our_mfo = window.dialogArguments.our_mfo;

    document.getElementById("tblMain").caption.innerHTML = "Заключення ДУ до депозитного договору №"
        + document.getElementById('tbND').value + " (#" + dpu_id + ")";
    document.getElementById('tbAgreementNumber').value = dpu_id + "/" + document.getElementById('tbAgreementNumber').value;
    document.getElementById('tbAgreementDate').value = window.dialogArguments.bankdate;

    if (dpu_id > 0) {

        populateForm();

        document.getElementById('btCreate').disabled = true;

        // read Only mode
        if (mode == 2) {
            document.getElementById('ddPenaltyTypes').disabled = true;
            document.getElementById('btCreate').disabled = true;
        }
    }
    else {
        window.close();
        return;
    }

    if (!isInit) {
        AddListeners("tbAgreementNumber,tbAgreementDate,tbAmount,tbNewDateEnd,tbRate,tbReceiverBankCode", 'onkeydown', TreatEnterAsTab);
    }
    isInit = true;
}

function hideRows() {
    document.all.rowAgreementDate.style.display = "none";
    document.all.rowAgreementAmount.style.display = "none";
    document.all.rowAgreementRate.style.display = "none";
    document.all.rowAgreementFreq.style.display = "none";
    document.all.rowAgreementPenalty.style.display = "none";
    document.all.rowReceiver.style.display = "none";
}

function populateForm() {
    hideRows();
};

// ************************************************** //
//
function getSelectedType(typeList) {
    hideRows();
    if (typeList.selectedIndex > 0) {
        document.all.btCreate.disabled = false;
        if (typeList.value != document.all.tbAgreementTypeId.value) {
            
            switch (true) {
                case (typeList.value == "1"): {
                    document.all.rowAgreementAmount.style.display = "inline";
                    break;
                }
                case (typeList.value == "2"): {
                    document.all.rowAgreementRate.style.display = "inline";
                    break;
                }
                case (typeList.value == "3"): {
                    document.all.rowAgreementFreq.style.display = "inline";
                    document.all.rowAgreementFreq.style.whiteSpace = "nowrap";
                    break;
                }
                case (typeList.value == "4"): {
                    document.all.rowReceiver.style.display = "inline";
                    break;
                }
                case (typeList.value == "5"): {
                    document.all.rowAgreementDate.style.display = "inline";
                    break;
                }
                case (typeList.value == "6"): {
                    document.all.rowAgreementPenalty.style.display = "inline";
                    break;
                }
                case (typeList.value == "7"): {
                    document.all.rowAgreementDate.style.display = "inline";
                    break;
                }
                default: {
                    break;
                }
            }
        }
    }
    else {
        document.all.btCreate.disabled = true;
    }
    document.all.tbAgreementTypeId.value = typeList.value;
}

//
function getSelectedFreq(freqList) {
    if (freqList.selectedIndex > 0) {
        if (freqList.value != document.all.tbFreqTypeID.value) {
            document.all.tbFreqTypeID.value = freqList.value;
        }
    }
}

function getSelectedPenalty(penaltyList) {
    if (penaltyList.selectedIndex > 0) {
        if (penaltyList.value != document.all.tbPenaltyId.value) {
            document.all.tbPenaltyId.value = penaltyList.value;
        }
    }
}

// ************************************************** //
function fnCheckBankCode(bankCode) {
    if (bankCode.value != "")
        webService.DPU.callService(onGetMfo, "getMfo", bankCode.value);
}

function onGetMfo(result) {
    if (!getError(result)) return;
    
    if (result.value == "") {
        document.getElementById("tbReceiverBankCode").value = "";
        document.getElementById("tbReceiverBankName").value = "";
        Dialog("Неіснуючий код банку (МФО)!", "alert");
        document.getElementById("tbReceiverBankCode").focus();
    }
    else {
        document.getElementById("tbReceiverBankName").value = result.value;
    }
    
    if (our_mfo == document.getElementById("tbReceiverBankCode").value) {
        document.getElementById('btShowReceiverAccounts').disabled = false;
    }
    else {
        document.getElementById('btShowReceiverAccounts').disabled = true;
    }
}

// ************************************************** //
function fnCheckAccount(account) {
    if (rnk == null || rnk == "") {
        Dialog("Не вибрано клієнта!", "alert");
        account.value = "";
        return;
    }
    if (account.value != "" && account.value != checkControlRank(document.getElementById("tbReceiverBankCode").value, account.value)) {
        Dialog("Невірний контрольний розряд!", "alert");
        account.focus();
        account.value = "";
    }
    else if (account.value != "" && our_mfo == document.getElementById("tbReceiverBankCode").value)
        webService.DPU.callService(onGetNls, "getNls", account.value, kv, rnk);
}

function onGetNls(result) {
    if (!getError(result)) return;
    if (result.value[0] != rnk) {
        if (result.value[0] == "") {
            Dialog("Рахунок " + document.getElementById("tbReceiverAccount").value + "(" + kv + ") не знайдено!", "alert");
            if (type == 2) {
                document.getElementById("tbReceiverAccount").value = "";
                document.getElementById("tbReceiverAccount").focus();
                document.getElementById("tbReceiverAccount").select();
            }
        }
        else if (Dialog("Рахунок відкрито на іншого клієнта! Продовжити?", "confirm") == 0) {
            document.getElementById("tbReceiverAccount").value = "";
            document.getElementById("tbReceiverName").value = "";
            document.getElementById("tbReceiverAccount").focus();
            document.getElementById("tbReceiverAccount").select();
        }
        else
            document.getElementById("tbReceiverName").value = result.value[1];
    }
    else
        document.getElementById("tbReceiverName").value = result.value[1];
}

function fnClientAccounst() {
    if (rnk && kv) {
        var result = window.showModalDialog(url_dlg_mod + 'ACCOUNTS&tail="RNK=' + rnk + ' and NBS in (2520,2523,2600,2650) and KV=' + kv + '"&pk=NLS&sk=NMS&title=' + escape("Вибір рахунку"), window, "dialogHeight:700px;dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        if (result) {
            document.all.tbReceiverBankCode.value = our_mfo;
            document.all.tbReceiverAccount.value = result[0];
            document.all.tbReceiverName.value = result[1];
        }
    }
}

// ************************************************** //
// VALIDATE
function fnValidate() {

    var d = document.all;
    var errMsg = "";

    switch (d.tbAgreementTypeId.value) {
        case '1': {
            if (d.tbAmount.value == "0") {
                errMsg += "Сума договору;" + "\r\n";
            }
            break;
        }
        case '2': {
            if (d.tbRate.value == "0") {
                errMsg += "Відсоткова ставка;" + "\r\n";
            }
            break;
        }
        case '3': {
            if (d.tbFreqTypeID.value == "") {
                errMsg += "Періодичність виплати відсотків;" + "\r\n";
            }
            break;
        }
        case '4': {
            if (d.tbReceiverBankCode.value == "") {
                errMsg += "Код банку отримувача;" + "\r\n";
            }
            if (d.tbReceiverAccount.value == "") {
                errMsg += "Номер рахунку отримувача;" + "\r\n";
            }
            if (d.tbReceiverName.value == "") {
                errMsg += "Назва отримувача;" + "\r\n";
            }
            break;
        }
        case '5': {
            if (d.tbNewDateEnd.value == "") {
                errMsg += "Дата завершення;" + "\r\n";
            }
            break;
        }
        case '6': {
            if (d.tbPenaltyId.value == "") {
                errMsg += "Код штрафу;" + "\r\n";
            }
            break;
        }
        case '7': {
            if (d.tbNewDateEnd.value == "") {
                errMsg += "Дата завершення;" + "\r\n";
            }
            break;
        }
        default: {
            break;
        }
    }

    if (errMsg == "") {
        return true;
    }
    else {
        errMsg = "<font color='red'>Не вказано значення для поля(ів):<br>" + errMsg + "</font>";
        Dialog(errMsg, "alert");
        ///alert(errMsg);
        return false;
    }
}

// ************************************************** //
// CREATE
function fnCreate() {
    if ( fnValidate() ) {
        if (Dialog("Створити додаткову угоду?", "confirm") == 1) {
            var d = document.all;
            var agrmData = new Array();
            
            agrmData[0] = d.tbAgreementTypeId.value;
            agrmData[1] = d.tbAgreementNumber.value;
            agrmData[2] = d.tbAgreementDate.value;
            
            // ДУ про зміну суми договору
            agrmData[3] = d.tbAmount.value;
            
            // ДУ про зміну відсоткової ставки по договору
            agrmData[4] = d.tbRate.value;
            
            // ДУ про зміну періодичності виплати відсотків
            agrmData[5] = d.tbFreqTypeID.value;
            
            // ДУ про зміну терміну договору / пролонгацію договору
            agrmData[6] = ""; // new begin date
            agrmData[7] = d.tbNewDateEnd.value;
            
            // ДУ про зміну умов дострокового повернення коштів
            agrmData[8] = d.tbPenaltyId.value;
            
            // ДУ про зміну рахунку повернення депозиту
            agrmData[9] = escape("<details><dep><mfo>" + d.tbReceiverBankCode.value + "</mfo><nls>" +
                d.tbReceiverAccount.value + "</nls><nmk>" +
                d.tbReceiverName.value + "</nmk><okpo></okpo></dep></details>");
                
                // if ( ( frm_Open.dfK013 != '1' ) OR ( NOT frm_Open.cbCOMPROC ) )
                // "<int><mfo>{0}</mfo><nls>{1}</nls><nmk>{2}</nmk><okpo></okpo>{3}</int>"

            webService.DPU.callService(onCreateAgreement, "CreateAgreement", dpu_id, agrmData);
        }
        else {
            return;
        }
    }
}

function onCreateAgreement(result) {
    if (!getError(result)) {
        return;
    }
    if (result.value == "") {
        Dialog("Створено додаткову угоду #!", "alert");
        fnExit();
    }
    else {
        Dialog(result.value, "alert");
    }
}

// ************************************************** //
// PRINT
function fnPrint() {
    if (Dialog("Надрукувати додаткову угоду?", "confirm") == 1) {
        alert("В розробці!!!");
        // __doPostBack('btPrint', 'OnClick');
        // document.all('btPrint').click();
    }
}

// ************************************************** //
// EXIT
function fnExit() {
    window.close();
    window.opener.location.reload();
}