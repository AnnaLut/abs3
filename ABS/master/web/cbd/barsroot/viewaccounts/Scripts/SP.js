// Инициализация доп. реквизитов
var prevButton;

var code = null;
function InitSP() {
    var data = parent.acc_obj.value;
    acc = getParamFromUrl("acc", location.href);
    nbs = data[2].text;
    if (acc == 0 && !nbs)
        return;
    accessmode = getParamFromUrl("accessmode", location.href);
    if (accessmode != 1 || parent.flagEnhCheck || parent.flagCheckSpecParams) cbSPOpt.disabled = true;
    webService.useService("AccService.asmx?wsdl", "SP");
    webService.SP.callService(onGetSPCodes, "GetSPCodes", nbs, acc);
}
function onGetSPCodes(result) {
    if (!getError(result)) return;
    var codes = eval(result.value[0]);
    parent.spRequiredParams = eval(result.value[1]);
    var tabButtons = document.getElementById("tabButtons");
    var oRow = tabButtons.insertRow(-1);
    for (i = 0; i < codes.length; i++) {
        oCell = oRow.insertCell();
        oCell.innerText = " " + codes[i].Name + "   ";
        oCell.id = "btn" + codes[i].Code;
        oCell.onclick = LoadSPTable;
        oCell.className = "tabDeactive";
        if (i == 0)
            LoadSPTable(oCell);
    }
}

function LoadSPTable(cell) {
    if (cell) elem = cell;
    else elem = event.srcElement;
    if (prevButton) prevButton.className = "tabDeactive";
    elem.className = "tabActive";
    code = elem.id.substr(3);
    LoadXslt("Xslt/SPData_" + getCurrentPageLanguage() + ".xsl");
    v_data[3] = 'opt, semantic';
    v_data[9] = nbs;
    v_data[10] = acc;
    v_data[11] = (parent.isNewAcc) ? (1) : (0);
    v_data[12] = code;
    var obj = new Object();
    obj.v_showPager = false;
    obj.v_EnablePageSize = false;
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = 'AccService.asmx';
    obj.v_serviceMethod = 'GetSParams';
    obj.v_serviceFuncAfter = 'AfterGetSParams';
    obj.v_funcCheckValue = 'fnCheckSP';
    fn_InitVariables(obj);
    InitGrid();
    prevButton = elem;
}

function AfterGetSParams() {
    for (key in parent.localSP) {
        var obj = parent.localSP[key];
        if (code == obj.code)
            document.getElementById("VALUE_" + obj.rid).innerText = obj.v;
    }
}

//Проверка введеного значения 
function fnCheckSP() {
    var data = parent.acc_obj.value;
    if (document.getElementById("HREF_" + row_id).innerHTML != "") {
        if (selectedRow.opt == 1 && !document.getElementById("VALUE").value)
            Dialog("Обов'язковий реквізит не може бути пустим!", 1);
        else
            webService.SP.callService(onCheckSPDic, "CheckSPDic", document.getElementById("VALUE").value, selectedRowId, data[2].text);
    }
    else {
        SaveSP(selectedRowId, document.getElementById("VALUE").value, row_id, code);
        AfterGetSParams();
    }
}
function onCheckSPDic(result) {
    if (!getError(result)) return;
    if (result.value == "0") {
        Dialog(LocalizedString('Message34'), 1);
        document.getElementById("VALUE_" + row_id).innerHTML = "";
        return;
    }
    else {
        SaveSP(selectedRowId, document.getElementById("VALUE").value, row_id, code);
        AfterGetSParams();
    }
}
//Справочник
function fnShowDic(tabname, pk, sql) {
    var data = parent.acc_obj.value;
    if (sql != "") sql = sql.replace(/:NBS/g, data[2].text).replace(/:NLS/g, "'" + data[0].text + "'").replace(/:ACC/g, "'" + acc + "'").replace(/:RNK/g, "'" + data[27].text + "'");
    var result = window.showModalDialog("dialog.aspx?type=metatab&role=wr_viewacc&tail=\"" + sql + "\"&tabname=" + tabname + "&pk=" + pk, "", "dialogWidth:650px;center:yes;edge:sunken;help:no;status:no;");
    if (accessmode != 1) return;
    if (result != null) {
        document.getElementById("VALUE_" + row_id).innerHTML = result[0];
        SaveSP(selectedRowId, result[0], row_id, code);
    }
}
function fnCloseDic(val) {
    document.close();
    window.close();
    window.returnValue = val;
}