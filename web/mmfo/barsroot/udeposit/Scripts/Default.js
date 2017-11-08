var mode = null;
var our_mfo;
var our_nb;
var user_id;
var bankdate, last_bankdate;
var segment = 0;
var tobo;
var toboName, depositLine;
var forceExecute = false;

window.onload = InitDefault;
//**********************************************************************//
function InitDefault() {
    webService.useService("udptService.asmx?wsdl", "DPU");
    mode = getParamFromUrl("mode", location.href);
    LoadXslt('Xslt/Dpu_deal_' + getCurrentPageLanguage() + '.xsl');
    v_data[2] = "and nvl(d.closed,0) = 0 ";
    v_data[3] = "nvl(DPU_GEN,DPU_ID) DESC, DPU_ADD ASC";
    v_data[9] = getParamFromUrl("flt", location.href);
    segment = v_data[9];
    var obj = new Object();
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = 'udptService.asmx';
    obj.v_serviceMethod = 'GetDepositUDeals';
    obj.v_serviceFuncAfter = "LoadBaseData";
    obj.v_showFilterOnStart = true;
    obj.v_filterTable = "dpt_u";
    obj.v_filterInMenu = false;
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

    // лише перегляд
    if (mode == 3) {
        HideImg(gE("btIns"));
        HideImg(gE("btClose"));
        HideImg(gE("btPrint"));
        HideImg(gE("btState"));
    }

}
function printTable() {
    window.print();
}

function exportToExcel() {
    webService.DPU.callService(onExportExcel, "ExportToExcel", v_data, forceExecute);
}

//the same method as in CustAcc.js
function onExportExcel(result) {
    if (!getError(result)) return;
    debugger;
    if (-1 === result.value.indexOf(".xls")) {
        var warningMsg = "<div>Кількість запиcів на вивантаження: <strong>" + result.value + "</strong></div><br/><div>Завантаження може тривати кілька хвилин.</div><br/><div>Ви можете зберегти час, встановивши більше фільтрів пошуку.\nБажаєте встановити додаткові фільтри?</div>";

        alertify.set({
            labels: {
                ok: "Так",
                cancel: "&nbspНі&nbsp"
            },
            modal: true
        });

        alertify.confirm(warningMsg, function (e) {
            if (e) {
                return;
            } else {
                forceExecute = true;
                exportToExcel();
            }
        });
    } else {
        forceExecute = false;
        location.href = "/barsroot/cim/handler.ashx?action=download&fname=deposits&file=" + result.value + "&fext=xls";
    }
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
    window.showModalDialog("dptdealparamS.aspx?mode=" + mode + "&dpu_id=0&vidd=0&vidname=0&type=1&dpu_gen=&rnd=" + Math.random(), window, "dialogWidth:1000px;dialogHeight:700px;center:yes;edge:sunken;help:no;status:no;");
    //window.open("dptdealparams.aspx?mode=" + mode + "&dpu_id=0&vidd=0&vidname=0&type=1&dpu_gen=", "", "width=916,height=600");
}
//**********************************************************************//
function fnClose() {
    HidePopupMenu();
    if (selectedRow == null) return;
    if (selectedRow.dpuclosed == 1) {
        Dialog("Договір № " + selectedRowId + " вже закритий.", "alert");
        return;
    }
    if (Dialog("Ви дійсно хочете закрити договір № " + selectedRowId + "?", "confirm") == 1)
        webService.DPU.callService(onCloseDeal, "CloseDeal", selectedRowId);
}

function onCloseDeal(result) {
    if (!getError(result)) {
        return;
    }
    var errMsg = result.value;
    if (errMsg == "" || errMsg == null || errMsg == "null") {
        Dialog("Договір № " + selectedRowId + " закрито.", "alert")
        ReInitGrid();
    }
    else {
        Dialog(errMsg, "alert");
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
    window.showModalDialog("dptdealparamS.aspx?mode=" + (selectedRow.dpuclosed == 1 ? 2 : mode ) +
        "&dpu_id=" + selectedRowId + "&type=0&dpu_gen=" + selectedRow.dpugen + "&dpu_ad=" + selectedRow.dpuadd + "&dpu_expired=" + selectedRow.dpuexpired +
        "&rnd=" + Math.random(), window, "dialogWidth:1000px;dialogHeight:750px;center:yes;edge:sunken;help:no;status:no;");
}
//**********************************************************************//
function fnShowState() {
    HidePopupMenu();
    if (selectedRow == null) return;
    if (selectedRow.dpuadd != "0")
        window.showModalDialog("DptdealstatE.aspx?mode=" + mode + "&dpu_id=" + selectedRowId + "&type=0&dpu_gen=" + selectedRow.dpugen + "&rnd="+Math.random(), window, "dialogWidth:900px;dialogHeight:800px;center:yes;edge:sunken;help:no;status:no;");
}
//**********************************************************************//
function fnCalcInt() {
    HidePopupMenu();
    if (Dialog("Нарахувати %% по ВСЬОМУ портфелю депозитів ?", "confirm") == 1) {
        webService.DPU.callService(onCalcInt, "CalcInt");
    }
}

function onCalcInt(result) {
    if (!getError(result)) {
        return;
    }
    var errMsg = result.value;
    if (errMsg == "" || errMsg == null || errMsg == "null") {
        Dialog("Нарахування відсотків по депозитному портфелю завершено !", "alert");
        ReInitGrid();
    }
    else {
        Dialog(errMsg, "alert");
    }
}
//**********************************************************************//
function fnPayOutInt() {
    HidePopupMenu();
    if (Dialog("Виплатити %% по ВСЬОМУ портфелю депозитів ?", "confirm") == 1) {
        webService.DPU.callService(onPayOutInt, "PayOutInt");
    }
}

function onPayOutInt(result) {
    if (!getError(result)) {
        return;
    }

    var errMsg = result.value;
    if (errMsg == "" || errMsg == null || errMsg == "null") {
        Dialog("Виплата відсотків по депозитному портфелю завершена !", "alert");
        ReInitGrid();
    }
    else {
        Dialog(errMsg, "alert");
    }
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
//**********************************************************************//
function fnChkDiscrepancyBalances() {
    webService.DPU.callService(onDiscrepancyBalances, "DiscrepancyBalances");
}

function onDiscrepancyBalances(result) {
    if (!getError(result)) {
        return;
    }
    var msg = result.value;
    if (msg == "" || msg == null || msg == "null") {
        Dialog("РОЗБІЖНОСТЕЙ В ЗАЛИШКАХ НЕ ВИЯВЛЕНО !", "alert");
    }
    else {
        Dialog(msg, "alert");
    }
}