// ---------- //
// 10.10.2016 //
// ---------- //

var isInit = false;
var mode = null;
var dpu_id = null;
var cust_id = null;
var confidant = null; // Id довіреної особи

window.onload = InitAdditionalOptions;

// ************************************************** //
// Initialize
function InitAdditionalOptions() {
    webService.useService("udptService.asmx?wsdl", "DPU");
    mode = getParamFromUrl("mode", location.href);
    dpu_id = getParamFromUrl("dpu_id", location.href);
    cust_id = getParamFromUrl("rnk", location.href);

    if (dpu_id > 0 && cust_id > 0) {
        populateForm();
        if (mode == 2) {
            document.getElementById('tbComments').disabled = true;
            document.getElementById('btConfidant').disabled = true;
            document.getElementById('btSave').disabled = true;
        }
    }
    else {
        window.close();
        return;
    }

    if (!isInit) {
        // AddListeners("tbComments", 'onkeydown', TreatEnterAsTab);
    }
    isInit = true;
}

// ************************************************** //
// GET Confidant properties
function fnConfidant() {
    var result = window.showModalDialog(url_dlg_mod + 'V_TRUSTEE_ALLOW2SIGN&tail="RNK=' + cust_id + '"&title=' + escape("Вибір довіреної особи"), window, "dialogHeight:700px;dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
    if (result) {
        confidant = result[0];
        document.all.tbConfidantName.value = result[1];
        document.all.tbConfidantPosition.value = result[2];
        document.all.tbConfidantDoc.value = result[3];
    }
}

function getConfidantInfo() {
    webService.DPU.callService(onGetConfidantInfo, "GetConfidantInfo", confidant);
}

function onGetConfidantInfo(result) {
    if (result.error) {
        alert('Не знайдено інформацію про довірену особу!');
        confidant = 0;
    }
    else {
        var data = result.value;
        if (data.length > 0) {
            document.all.tbConfidantName.value = data[0].text;
            document.all.tbConfidantPosition.value = data[1].text;
            document.all.tbConfidantDoc.value = data[2].text;
        }
    }
}

// ************************************************** //
// Set Value from directory
function fnSetValue(elmtId, directoryName, conditions, keyField) {
    //
    var result = window.showModalDialog(url_dlg_mod + directoryName + '&tail="' + conditions + '"&pk=' + keyField + '&title=' + escape("Вибір значення дод.параметру"), window, "dialogHeight:700px;dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
    if (result) {
        document.getElementById(elmtId).value = result[0];
    }
}

// ************************************************** //
// Fill Form
function populateForm() {
    webService.DPU.callService(onPopulateForm, "GetAdditionalOptions", dpu_id);
}

//
function onPopulateForm(result) {
    if (getError(result)) {
        
        var data = result.value;
        
        confidant = data[0].text;
        
        if (confidant > 0) {
            getConfidantInfo();
        }
        
        document.all.tbComments.value = data[1].text;
        
        var table = document.getElementById("tbAddOptions");
        
        for (r = 2; r < data.length; r++) {
            var row = table.insertRow();
            var val = data[r].text;
            fillRow(val.split(';'), row);
        }
    }
}

//
function fillRow(arr, row) {
    for (i = 0; i <= arr.length; i++) {
        var cell = row.insertCell(i);

        if (i == 0) {
            // Назва дод.параметру
            var spn = document.createElement("span");
            // spn.setAttribute("className", "BarsLabel");
            spn.innerHTML = arr[i];
            cell.appendChild(spn);
        }

        if (i == 1) {
            // Значення дод.параметру
            cell.align = "center";
            var tbx = document.createElement("input");
            tbx.type = "text";
            tbx.id = "tbValue" + arr[2];
            tbx.setAttribute("className", "BarsTextBox");
            tbx.width = "99%";
            tbx.style.backgroundColor = "LightYellow";
            tbx.title = "Значення додаткового параметру";
            tbx.value = arr[i];
            if (mode == 2) {
                tbx.disabled = true;
            }
            cell.appendChild(tbx);
        }

        if (i == 2) {
            // Код дод.параметру
            // cell.innerHTML = arr[i];
            cell.innerText = arr[i];
            cell.style.display = "none";
        }

        if (i == 3) {
            // Виклик довідника допустимих значень дод.параметру
            cell.align = "center";
            var btn = document.createElement("input");
            btn.type = "button";
            btn.value = "...";
            btn.title = "Вибір параметра з довідника";
            var tabName = arr[i];
            var colName = arr[i+1];
            if (mode == 2) {
                btn.disabled = true;
            }
            else {
                if (tabName.length > 0) {
                    // вставка значення тільки з довідника
                    row.children[1].firstChild.readOnly = true;
                    row.children[1].firstChild.style.backgroundColor = "Azure";
                    if (arr[2] == 'IS_PLEDGE') {
                        // 
                        btn.onclick = function () {
                            fnSetValue(tbx.id, tabName, 'CLIENT_ID = ' + cust_id + ' or CONTRACT_ID in (select ND from PLEDGED_DEPOSITS where RNK =' + cust_id + ')'
                            , colName);
                        }
                    }
                }
                else {
                    btn.onclick = function () {
                        alert('Для цього дод.параметру довідник не задано!');
                    }
                }
            }
            cell.appendChild(btn);
        }

        if (i == 4) {
            // Значення дод.параметру (копія для порівняння)
            cell.innerText = arr[1];
            cell.style.display = "none";
        }
    }
}

// ************************************************** //
// SAVE and EXIT
function fnSave() {
     if (Dialog("Зберегти зміни внесенні в параметри договору?", "confirm") == 1) {
         SetAdditionalOptions();
     }
     else {
         return;
    }
}

function SetAdditionalOptions() {

    var chgData = new Array();

    // ідентифікатор довіреної особи
    if (confidant > 0) {
        chgData[0] = confidant;
    }
    else {
        chgData[0] = null;
    }
        
    // коментар
    if (document.all.tbComments.value.length > 0) {
        chgData[1] = document.all.tbComments.value;
    }
    else {
        chgData[1] = null;
    }

    // цикл по полях таблиці
    var tab = document.getElementById('tbAddOptions');

    for (i = 1; i < tab.rows.length; i++) {
        // якщо щось змінилося
        if (tab.rows(i).cells(1).childNodes[0].value != tab.rows(i).cells(4).innerText) {
            // console.log("tab.rows(" + i + ").cells(2)=" + tab.rows(i).cells(2).innerText);
            // console.log("tab.rows(" + i + ").cells(1)=" + tab.rows(i).cells(1).childNodes[0].value);
            chgData[chgData.length] = (tab.rows(i).cells(2).innerText + "|" + tab.rows(i).cells(1).childNodes[0].value);
        }
    }

    webService.DPU.callService(onSetAdditionalOptions, "SetAdditionalOptions", dpu_id, chgData);
}

function onSetAdditionalOptions(result) {
    if (!getError(result)) {
        return;
    }
    var errMsg = result.value;
    if (errMsg == "" || errMsg == null || errMsg == "null") {
        Dialog("Зміни збережено", "alert");
        window.close();

    }
    else {
        Dialog(errMsg, "alert");
    }
}

// ************************************************** //
// EXIT
function fnCancel() {
    window.close();
}