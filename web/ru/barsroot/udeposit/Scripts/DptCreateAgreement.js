// ---------- //
// 19.04.2016 //
// ---------- //

var isInit = false;
var mode = null;
var dpu_id = null;

window.onload = InitDptAgreement;

// ************************************************** //
// Initialize
function InitDptAgreement() {
    webService.useService("udptService.asmx?wsdl", "DPU");
    mode = getParamFromUrl("mode", location.href);
    dpu_id = getParamFromUrl("dpu_id", location.href);

    alert(opener.document.all.tbFreqV.value);

    if (dpu_id > 0) {

        populateForm();

        document.getElementById('btCreate').disabled = true;
        document.getElementById('btPrint').disabled = true;

        if (mode == 2) {
            // read Only mode
            // document.getElementById('btShowReceiverAccounts').disabled = disable;
            // document.getElementById('tbBeneficiaryAccount').disabled = disable;
            document.getElementById('btCreate').disabled = true;
        }
    }
    else {
        window.close();
        return;
    }

    if (!isInit) {
        AddListeners("tbAgreementNumber,tbAgreementDate,tbNewAmount,tbNewDateEnd,tbRate,tbReceiverBankCode", 'onkeydown', TreatEnterAsTab);
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
    var selectedIndex = typeList.selectedIndex;
    if (selectedIndex > 0) {
        document.getElementById('btCreate').disabled = false;
        if (typeList.value != document.all.tbAgreementTypeId.value) {
            document.all.tbAgreementTypeId.value = typeList.value;
            hideRows();
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
        document.getElementById('btCreate').disabled = true;
    }
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
// 
function fnCheckBankCode(bankCode) {
    alert("В розробці!!!");
}

//
function fnCheckAccount(account) {
    alert("В розробці!!!");
}

// ************************************************** //
// CREATE
function fnCreate() {
    alert("В розробці!!!");
}

// ************************************************** //
// PRINT
function fnPrint() {
    alert("В розробці!!!");
    __doPostBack('btPrint', '');

}

// ************************************************** //
// EXIT
function fnExit() {
    window.close();
}