var isInit = false;
var bankdate;
var mode = null;
var dpu_id = null;
var dpu_gen = null;
var type = null, acr_dat_term, needVisa;
var tt1;
var tt2;
var ttDep;
var ttInt;
var acc;
var kv, sum, mfo_d, nls_d, nam_d, nb_d, okpo, mfo_p, nls_p, nam_p, okpo_p, gen_nls_dep, gen_nls_int;
var swtDtlDep = "";
var swtDtlInt = "";

window.onload = InitDptDealState;

function InitDptDealState() {
    webService.useService("udptService.asmx?wsdl", "DPU");
    mode = getParamFromUrl("mode", location.href);
    dpu_id = getParamFromUrl("dpu_id", location.href);
    dpu_gen = getParamFromUrl("dpu_gen", location.href);
    type = getParamFromUrl("type", location.href);

    bankdate = window.dialogArguments.bankdate;

    if (!isInit) {
        IniDateTimeControl("tbDat");
        window["tbDat"].SetValue(window.dialogArguments.last_bankdate);
    }
    isInit = true;
    if (window.dialogArguments) {
        webService.DPU.callService(onGetDepositDealState, "GetDepositDealState", dpu_id, dpu_gen);
    }
    else {
        window.close();
        return;
    }
}
function onGetDepositDealState(result) {
    if (!getError(result)) return;

    var data = result.value;
    var d = document.all;

    if (dpu_id == dpu_gen) {
        d.lbTitleDeal.innerText = "Депозитний договір № " + data[0].text;
    }
    else {
        d.lbTitleDeal.innerText = "Дод. угода № " + data[0].text + " до договору " + data[36].text;
    }

    d.tbNmk.value = data[2].text;
    d.tbVidD.value = data[3].text;
    d.tbKv.value = data[4].text;
    d.tbFreq.value = data[5].text;
    acc = data[6].text;
    d.tbNls.value = data[7].text;
    init_numedit("tbOst_Pl", data[8].text, 2);
    var accN = data[9].text;
    d.tbNlsN.value = data[10].text;
    init_numedit("tbOstN_Pl", data[11].text, 2);
    okpo = data[12].text;
    acr_dat_term = data[19].text;

    kv = data[21].text;
    mfo_d = data[22].text;
    nls_d = data[23].text;
    nam_d = data[24].text;
    nb_d = data[25].text;
    sum = data[26].text;
    // isn't closed
    if (data[14].text != "1")
    {
        d.pb0.disabled = (data[27].text == "1" ? false : true); // Розміщення
        d.pb3.disabled = (data[27].text == "1" ? true : false); // Нарахування %% активне коли Розміщення не активне
        d.pb1.disabled = (data[28].text == "1" ? false : true); // Поповнення
        d.pb4.disabled = (data[29].text == "1" ? false : true); // Виплата. нарах. %%
        d.pb5.disabled = (data[30].text == "1" ? false : true); // Штрафування
        d.pb2.disabled = (data[31].text == "1" ? false : true); // Погашення
    }
    tt1 = data[32].text;
    tt2 = data[33].text;
    ttDep = data[34].text;
    ttInt = data[35].text;

    needVisa = data[37].text;
    mfo_p = data[38].text;
    nls_p = data[39].text;
    nam_p = data[40].text;
    okpo_p = data[41].text;

    gen_nls_dep = data[42].text;
    gen_nls_int = data[43].text;

    if ( kv != "980" )
    {
        swtDtlDep = data[44].text;
        swtDtlInt = data[45].text;
    }
    
    webService.DPU.callService(onfillTables, "fillTables", acc, accN);
}
function onfillTables(result) {
    if (!getError(result)) return;
    var data = result.value;
    var i = 0;
    while (document.all.tb1.rows.length > 1) document.all.tb1.deleteRow();
    while (document.all.tb2.rows.length > 1) document.all.tb2.deleteRow();
    for (i = 0; i < data.length; i++) {
        var val = data[i];
        if (val == "") break;
        if (val.substr(0, 1) == "1") AddRow(val.split(';'), document.all.tb1);
        if (val.substr(0, 1) == "2") AddRow(val.split(';'), document.all.tb2);
    }
}
function AddRow(arr, table) {
    var oCell;
    var oRow = table.insertRow();
    oRow.style.fontWeight = "bold";
    oRow.style.cursor = "hand";
    for (i = 1; i < arr.length; i++) {
        oCell = oRow.insertCell();
        oCell.innerHTML = arr[i];
        oCell.align = "right";
    }
}
function fnShowSal(acc, dat) {
    window.dialogArguments.open("/barsroot/customerlist/accextract.aspx?type=4&acc=" + acc + "&date=" + dat, "", "height=" + (window.screen.height - 200) + ",width=" + (window.screen.width - 10) + ",resizable=yes,status=no,toolbar=no,menubar=no,location=no,left=0,top=0");
}
//**********************************************************************//
function fnDetail() {
    window.close();
    window.dialogArguments.fnShowParam();
}
//**********************************************************************//
function fnRefresh() {
    InitDptDealState();
}
//**********************************************************************//
function fnClose() {
    window.close();
}
//**********************************************************************//
// *** Розміщення
function fnRazm() {
    var url = "/barsroot/docinput/docinput.aspx?tt=" + tt1 + "&Nls_B=" + gen_nls_dep + "&Kv_B=" + kv + "&nd=" + dpu_id + "&SumC=" + sum + "&reqv_ND=" + dpu_id;
    window.showModalDialog(encodeURI(url), null, "dialogWidth:680px; dialogHeight:600px; scroll:no; center:yes; status:no");
    fnRefresh();
}
//**********************************************************************//
// *** Поповнення
function fnPopol() {
    var url = "/barsroot/docinput/docinput.aspx?tt=" + tt2 + "&Nls_B=" + gen_nls_dep + "&Kv_B=" + kv + "&nd=" + dpu_id + "&reqv_ND=" + dpu_id;
    window.showModalDialog(encodeURI(url), null, "dialogWidth:680px; dialogHeight:600px; scroll:no; center:yes; status:no");
    fnRefresh();
}
//**********************************************************************//
function fnNachis() {
    var d = document.all;
    var date = d.tbDat_TextBox.value;
    if (Dialog("Нарахувати відсотки по " + date + "?", "confirm")) {
        d.pb3.disabled = true;
        webService.DPU.callService(onMakeInt, "MakeInt", acc, date);
    }
}
function onMakeInt(result) {
    document.all.pb3.disabled = false;
    if (!getError(result)) return;
    if (result.value == 1)
        Dialog("Виникла помилка при нарахуванні відсотків - [" + result.value + "]", "alert");
    else {
        Dialog("Нарахування успішно виконано", "alert");
        InitDptDealState();
    }
}
//**********************************************************************//
// *** Interest payout
function fnViplat() {
    var s = GetValue("tbOstN_Pl");
    var url = "/barsroot/docinput/docinput.aspx?tt=" + ttInt + "&nd=" + dpu_id + "&Nls_A=" + gen_nls_int + "&Kv_A=" + kv +
        "&SumC=" + s +
        "&Mfo_B=" + mfo_p + "&Nls_B=" + nls_p + "&Nam_B=" + nam_p + "&Id_B=" + okpo + "&reqv_ND=" + dpu_id + swtDtlInt;
    // prompt("msg", url);
    window.showModalDialog(encodeURI(url), null, "dialogWidth:680px; dialogHeight:600px;scroll:yes; center:yes; status:no");
    fnRefresh();
}
//**********************************************************************//
// *** Deposit payout
function fnPogash() {
    var s = GetValue("tbOst_Pl");
    var url = "/barsroot/docinput/docinput.aspx?tt=" + ttDep + "&nd=" + dpu_id + "&Nls_A=" + gen_nls_dep + "&Kv_A=" + kv +
        "&SumC=" + s + "&flag_se=1" +
        "&Mfo_B=" + mfo_d + "&Nls_B=" + nls_d + "&Nam_B=" + nam_d + "&Id_B=" + okpo + "&reqv_ND=" + dpu_id + swtDtlDep;
    window.showModalDialog(encodeURI(url), null, "dialogWidth:680px; dialogHeight:600px;scroll:yes; center:yes; status:no");
    fnRefresh();
}
//**********************************************************************//
function fnStop() {
    if (acr_dat_term < 0) {
        Dialog("Для розрахунку штрафу потрібно донарахувати відсотки.", "alert");
        return;
    }
    if (needVisa > 0) {
        Dialog("Є незавізовані документи по рахунках даного договору.", "alert");
        return;
    }
    webService.DPU.callService(onGetPenalty, "getPenaltyEx", dpu_id, bankdate);
}
function onGetPenalty(result) {
    if (!getError(result)) return;
    var data = result.value;
    if (confirm(data[0] + "\n\n Надрукувати?")) {
        barsie$print(data[1]);
    }

    var message = "Виконати проводку по стягненню штрафу на суму " + (parseInt(data[2],10)/100).toString() + " грн. ?";

    if (Dialog(message, "confirm") == 1) {
        webService.DPU.callService(onPayPenalty, "payPenaltyEx", dpu_id, data[2], "0", data[3], data[4]);
    }
}
function onPayPenalty(result) {
    if (!getError(result)) return;
    var data = result.value;
    if (!data) {
        Dialog("Штрафування успішно виконано", "alert");
        // refresh form
        fnRefresh();
        // payout deposit
        fnPogash();
        // payout inerest
        if ( GetValue("tbOstN_Pl") > 0 )
        {
            fnViplat();
        }
    }
    else
    {
        Dialog(data, "alert");
    }
}
//**********************************************************************//
function fnHotKey() {
    if (event.keyCode == 27) {
        window.close();
        window.returnValue = null;
    }
}
//**********************************************************************//