var mode = null;
var our_mfo;
var our_nb;
var user_id;
var bankdate, last_bankdate;
var segment = 0;
var tobo;
var toboName, depositLine;

window.onload = InitDefault;
//**********************************************************************//
function InitDefault() {
    webService.useService("udptService.asmx?wsdl", "DPU");
    mode = getParamFromUrl("mode", location.href);
    LoadXslt('Xslt/Dpu_deal_' + getCurrentPageLanguage() + '.xsl');
    v_data[2] = "";
    v_data[3] = "nvl(d.dpu_gen,d.dpu_id), d.dpu_add";
    v_data[9] = getParamFromUrl("flt", location.href);
    segment = v_data[9];
    var obj = new Object();
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = 'udptService.asmx';
    obj.v_serviceMethod = 'GetDepositUDeals';
    obj.v_serviceFuncAfter = "LoadBaseData";
    obj.v_showFilterOnStart = false;
    obj.v_filterTable = "dpt_u";
    var menu = new Array();
    var full = (mode == 2) ? (false) : (true);
    if (full) menu[gE("btIns").title] = "fnIns()";
    if (full) menu[gE("btClose").title] = "fnClose()";
    menu[gE("btParam").title] = "fnShowParam()";
    menu[gE("btState").title] = "fnShowState()";

    obj.v_menuItems = menu;

    fn_InitVariables(obj);
    InitGrid();

    if (mode == 2) {
        HideImg(gE("btIns"));
        HideImg(gE("btClose"));
    }
}
function printTable() {
    window.print();
}

//**********************************************************************// 
function LoadBaseData() {
    our_mfo = returnServiceValue[2].text;
    our_nb = returnServiceValue[3].text;
    user_id = returnServiceValue[4].text;
    bankdate = returnServiceValue[5].text;
    tobo = returnServiceValue[6].text;
    toboName = returnServiceValue[7].text;
    depositLine = returnServiceValue[8].text;
    last_bankdate = returnServiceValue[9].text;
}
//**********************************************************************//
function fnIns() {
    HidePopupMenu();
    window.showModalDialog("dptdealparamS.aspx?mode=" + mode + "&dpu_id=0&vidd=0&vidname=0&type=1&dpu_gen=&rnd=" + Math.random(), window, "dialogWidth:1000px;dialogHeight:800px;center:yes;edge:sunken;help:no;status:no;");
    //window.open("dptdealparams.aspx?mode=" + mode + "&dpu_id=0&vidd=0&vidname=0&type=1&dpu_gen=", "", "width=916,height=600");
}
//**********************************************************************//
var try_close = 0;
function fnClose() {
    HidePopupMenu();
    if (selectedRow == null) return;
    if (selectedRow.dpuclosed == 1) {
        Dialog("Договір № " + selectedRowId + " вже закритий.", "alert");
        return;
    }
    if (Dialog("Ви дійсно хочете закрити договір № " + selectedRowId + "?", "confirm") == 1)
        webService.DPU.callService(onCloseDeal, "CloseDeal", selectedRowId, try_close);
}
function onCloseDeal(result) {
    if (!getError(result)) return;
    if (result.value == "1") {
        if (Dialog("По даному договору недоначислені проценти! Продовжити?", "confirm") == 1) {
            try_close = 1;
            fnClose();
        }
    }
    else if (result.value != "") {
        Dialog(result.value, "alert");
        try_close = 0;
    }
    else {
        Dialog("Договір № " + selectedRowId + " закрито.", "alert")
        ReInitGrid();
        try_close = 0;
    }
}
//**********************************************************************//
function fnRefresh() {
    ReInitGrid();
    HidePopupMenu();
}
//**********************************************************************//
function fnSave() {
    HidePopupMenu();
}
//**********************************************************************//
function fnShowParam() {
    HidePopupMenu();
    if (selectedRow == null) return;
    window.showModalDialog("dptdealparamS.aspx?mode=" + mode + "&dpu_id=" + selectedRowId + "&type=0&dpu_gen=" + selectedRow.dpugen + "&dpu_ad=" + selectedRow.dpuadd + "&dpu_expired=" + selectedRow.dpuexpired +
        "&rnd=" + Math.random(), window, "dialogWidth:1000px;dialogHeight:800px;center:yes;edge:sunken;help:no;status:no;");
}
//**********************************************************************//
function fnShowState() {
    HidePopupMenu();
    if (selectedRow == null) return;
    if (selectedRow.dpuadd != "0")
        window.showModalDialog("DptdealstatE.aspx?mode=" + mode + "&dpu_id=" + selectedRowId + "&type=0&dpu_gen=" + selectedRow.dpugen + "&rnd="+Math.random(), window, "dialogWidth:900px;dialogHeight:800px;center:yes;edge:sunken;help:no;status:no;");
}
//**********************************************************************//
function fnNachProc() {
    HidePopupMenu();
    alert("Функція недоступна");
}
//**********************************************************************//
function fnViplProc() {
    HidePopupMenu();
}
//**********************************************************************//
//Показать\спрятать закрытые договора
function fnShow() {
    if (document.all.btShow.className == "inset") {
        gE("btShow").className = "outset";
        v_data[2] = "and nvl(d.closed,0) = 0 ";
    }
    else {
        gE("btShow").className = "inset";
        v_data[2] = "";
    }
    ReInitGrid();
}

