//вызоав справочника
function ShowHelp(btObj, tblName) {
    var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=' + tblName + '&tail=\'\'&role=WR_CUSTREG', '', 'dialogHeight:560px; dialogWidth:550px');

    if (result != null) {
        var objId = btObj.id.replace('imgEdHelp', 'edEdVal');
        document.getElementById(objId).value = result[0];
        addToSaveTags(document.getElementById(objId));
    }

    return false;
}
function InitObjects()
{
    if (parent.flagEnhCheck) {
        document.getElementById('chCheckReq').checked = true;
        document.getElementById('chCheckReq').disabled = true;
    }

    $(function() {
        var gridInputs = $('#gvMain tbody input');//.numberMask({ pattern: /^[0-9]*$/ });;
        gridInputs.filter('[tagtype="N"]').numberMask({ pattern: /^[0-9]*$/ });
        gridInputs.filter('[tagtype="D"]').mask("99/99/9999");
    });
}

function addToSaveTags(elem) {
    var tabname = elem.getAttribute("TABNAME");
    var colname = elem.getAttribute("COLNAME");
    // проверка типа
    var type = elem.getAttribute("TAGTYPE");
    if (type == "N") {
        if (isNaN(elem.value)) {
            elem.value = "";
            alert("Значення реквізиту має бути числовим.");
            return;
        }
    }
    else if (type == "D") {
        if (elem.value && !elem.value.match(/^(0?[1-9]|[12][0-9]|3[01])[\/](0?[1-9]|1[012])[\/]\d{4}$/)) {
            elem.value = "";
            alert("Значення реквізиту має бути у форматі дати(DD/MM/YYYY).");
        }
    }

    // проверка значения по справочнику
    if (tabname && colname) {
        var check = parent.Check_DopReqvValue(colname, tabname, elem.value);
        if (!check) {
            elem.value = "";
            alert("Невірне значення реквізиту. Виберіть значення з довідника.");
            return;
        }
    }
    var tag = elem.getAttribute("TAG");
    var val = elem.value;
    if (type == "D") val = val.replace(".", "/").replace(".", "/");
    parent.custAttrList[tag] = { Tag: tag, Value: val, Isp: elem.getAttribute("ISP") };
    ToDoOnChange(true);
}

function addToSaveRisk(elem) {
    var riskId = elem.getAttribute("RiskId");
    var riskVal = (elem.checked) ? (1) : (0);
    parent.custRiskList[riskId] = { Id: riskId, Value: riskVal };
    ToDoOnChange(true);
}

function addToSaveRept(elem) {
    var reptId = elem.getAttribute("ReptId");
    var reptVal = (elem.checked) ? (1) : (0);
    parent.custReptList[reptId] = { Id: reptId, Value: reptVal };
    ToDoOnChange(true);
}
