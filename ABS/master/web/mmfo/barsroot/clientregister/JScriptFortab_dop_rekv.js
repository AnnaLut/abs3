//вызоав справочника
function ShowHelp(btObj, tblName) {
    window.parent.bars.ui.handBook(tblName, function (data) {
        var objId = btObj.id.replace('imgEdHelp', 'edEdVal');
        var element = document.getElementById(objId);
        if (data.length > 0) {

            if (element.nottoedit != '1') {
                element.value = data[0].PrimaryKeyColumn;
                addToSaveTags(element);
            }
        } else {
            element.value = '';
            addToSaveTags(element);
        }
    });
    return false;
}
function InitObjects() {
    for (var elem in parent.custAttrList) {
        if (parent.custAttrList.hasOwnProperty(elem)) {
            var elemVal = parent.custAttrList[elem].Value;
            $("input[tag='" + elem + "']").val(elemVal);
        }
    }

    if (parent.flagEnhCheck) {
        document.getElementById('chCheckReq').checked = true;
        document.getElementById('chCheckReq').disabled = true;
    }

    $(function () {
        var gridInputs = $('#gvMain tbody input');
        gridInputs.filter('[tagtype="N"]').numberMask({ pattern: /^[0-9]*$/ });
        gridInputs.filter('[tagtype="D"]').mask("99/99/9999");
        // custom validation UUDV
        gridInputs.filter('[tag="UUDV "]').numberMask({ beforePoint: 10, pattern: /^([0-9])*(\.|\,)?([0-9])*$/ });
        gridInputs.attr('maxlength', '500');
    });
}

function addToSaveTags(elem) {
    var tag = elem.getAttribute("TAG");
    var tabname = elem.getAttribute("TABNAME");
    var colname = elem.getAttribute("COLNAME");
    if (tag === "UUDV ") {
        var x = parseFloat(elem.value);
        if (isNaN(x) || x < 0 || x > 100) {
            alert("Значення реквізиту має бути числовим в межах від 0 до 100.");
            elem.value = "";
        } else
            elem.value = +x.toFixed(4);
    }
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

function addToSaveCategory(elem) {
    var catId = elem.getAttribute("CatId");
    var catVal = (elem.checked) ? (1) : (0);
    parent.custCatsList[catId] = { Id: catId, Value: catVal };
    ToDoOnChange(true);
}
