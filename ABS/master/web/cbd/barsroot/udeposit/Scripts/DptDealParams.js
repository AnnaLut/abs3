//------------------------------
// 24.03.2014 
//------------------------------
window.onload = InitDptDealParams;

var isInit = false;
var mode = null;
var dpu_id = null;
var dpu_gen = null;
var dpu_ad = null;
var dpu_expired = null;
var dpu_type = null;
var vidd;
var vidname;
var type = null;
var our_mfo = null;
var kv = "";
var rnk = null;
var branch = null;
var branchName;
var acc = null;
var accN = "";
//old values
var datO_old = null;
var br_old = null;
var ir_old = null;
var op_old = null;
var bsd;
var bsn;
var srok = 10;
var fl_extend;
var switchMode = 0;
var trustId = null; // Id доверенного лица
var sTypeDeal = null; // символьный код вида договора // SHRT, LONG, DMNP, COMB
var nAcc2 = null; // код для нахождения новых счетов для комбинированных договоров
var tempalteID = null;
var cnt_dubl = 0;
var segment = 0;

//**********************************************************************//
function fnHotKey() {
    if (event.keyCode == 27) {
        window.close();
        window.returnValue = null;
    }
    if (event.altKey && event.keyCode == 13) {
        fnSave();
    }
}
function checkNumber(elem) {
    var val = elem.value.replace(comma, dot);
    if (isNaN(val)) {
        alert("Невірний формат числа");
        elem.focus();
        elem.select();
    }
    else
        elem.value = val;
}

//**********************************************************************//
function InitDptDealParams() {
    webService.useService("udptService.asmx?wsdl", "DPU");
    mode = getParamFromUrl("mode", location.href);
    dpu_id = getParamFromUrl("dpu_id", location.href);
    dpu_gen = getParamFromUrl("dpu_gen", location.href);
    dpu_ad = getParamFromUrl("dpu_ad", location.href);
    dpu_expired = getParamFromUrl("dpu_expired", location.href);
    type = getParamFromUrl("type", location.href);

    vidd = unescape(getParamFromUrl("vidd", location.href));
    vidname = unescape(getParamFromUrl("vidname", location.href));

    if (window.dialogArguments) {
        if (type == 0) 
        {
            // Перегляд картки договору
            PopulateDeal();
        }
        else
        {
            if (type == 1)
            {
                if (dpu_gen) 
                    OpenDealAdd();
                else 
                    OpenDeal();
            }
        }
    }
    else {
        window.close();
        return;
    }

    if (!isInit) {
        // Date
        gE("tbDatZ_TextBox").attachEvent("onblur", SetBrDate);
        gE("tbDatO_TextBox").attachEvent("onblur", fnCheckDataO);
        gE("tbDatV_TextBox").attachEvent("onblur", fnCheckDataV);
        IniDateTimeControl("tbDatZ");
        IniDateTimeControl("tbDatN");
        IniDateTimeControl("tbDatO");
        IniDateTimeControl("tbDatV");
        IniDateTimeControl("tbBrDat");

        AddListeners("tbND,tbSum,tbDatN_TextBox,tbBrDat_TextBox,tbMinSum,tbDatO_TextBox,tbDatZ_TextBox,tbDatV_TextBox,tbMfoD,tbNlsD,tbMfoP,tbNlsP,tbIr,tbComments", 'onkeydown', TreatEnterAsTab);

        init_numedit("tbSum", 0, 2);
        init_numedit("tbMinSum", 0, 2);
    }
    isInit = true;
    dd_data["ddVidD"] = url_dlg_mod + 'DPU_VIDD&tail="flag=1"&title=' + escape("Вибір виду договору");
    dd_data["ddFreqV"] = url_dlg_mod + 'FREQ&colnum=2&tail=""';
    dd_data["ddStop"] = url_dlg + "DPT_STOP&colnum=2";
    dd_data["ddBaseRates"] = url_dlg + "BRATES&colnum=2";

    if (segment > 0)
        dd_data["ddProduct"] = url_dlg_mod + 'dpu_types&tail="segment=' + segment + '"';
    else
        dd_data["ddProduct"] = url_dlg_mod + 'dpu_types&tail=""';

}
function getFilteredVidd(ddlist) {
    var tail = "flag=1";
    var val = "";

    if (document.getElementById("ddProduct").value == "") {
        alert("Вкажіть продукт !");
        return;
    }

    tail += " and type_id=" + document.getElementById("ddProduct").value;

    if ((val = document.getElementById("ddKv").value) != "")
        tail += " and kv=" + val;
    tail += " and bsd in (select NBS_DEP from dpu_nbs4cust where k013=" + ((document.getElementById("tbK013").value) ? (document.getElementById("tbK013").value) : ("0")) + ")";
    var result = window.showModalDialog(url_dlg_mod + 'DPU_VIDD&tail="' + tail + '"&title=' + escape("Вибір виду договору"), window, "dialogHeight:700px;dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null) {
        if (ddlist.options.length == 0) {
            var oOption = document.createElement("OPTION");
            ddlist.options.add(oOption);
            oOption.innerText = result[1];
            oOption.value = result[0];
        }
        else {
            ddlist.options[0].value = result[0];
            ddlist.options[0].text = result[1];
        }
        document.all.tbVidD.value = result[0];
        SetVal();
    }
}

function fnCheckEmptyDate(e) {
    if (e.srcElement.value == "01.01.0001") {
        e.srcElement.value = "";
    }
}

//**********************************************************************//
function OpenDeal(add) {
    var d = document.all;

    HideImg(d.btPrint);
    HideImg(d.imgWord);
    HideImg(d.btSos);
    HideImg(d.btPassport);
    HideImg(d.btAccounts);
    HideImg(d.btChilds);
    HideImg(d.btDubl);

    document.all.tbRnk.className = "BarsTextBox";
    document.all.tbRnk.readOnly = false;

    var parwin = window.dialogArguments;
    gE("mainTable").style.visibility = "visible";

    //var parwin = window.opener;
    if (window["tbDatZ"])
        window["tbDatZ"].SetValue(parwin.bankdate);
    else
        d.tbDatZ_TextBox.value = parwin.bankdate;

    if (window["tbDatN"])
        window["tbDatN"].SetValue(parwin.bankdate);
    else
        d.tbDatN_TextBox.value = parwin.bankdate;

    if (window["tbBrDat"])
        window["tbBrDat"].SetValue(parwin.bankdate);
    else
        d.tbBrDat_TextBox.value = parwin.bankdate;

    init_numedit("tbMinSum", 0, 2);
    init_numedit("tbSum", 0, 2);

    d.tbMfoP.value = parwin.our_mfo;
    d.tbMfoD.value = parwin.our_mfo;
    d.tbNbP.value = parwin.our_nb;
    d.tbNbD.value = parwin.our_nb;
    our_mfo = parwin.our_mfo;
    segment = parwin.segment;
    calcKtDay();

    if (!add) {
        //d.tbDatO_TextBox.value = "";
        //d.tbDatV_TextBox.value = "";
        //alert(d.tbDatO_TextBox.value);
    }
}
//**********************************************************************//
function OpenDealAdd() {
    webService.DPU.callService(onGetDepositAddDealParams, "GetDepositAddDealParams", dpu_gen);
}
function onGetDepositAddDealParams(result) {
    gE("mainTable").style.visibility = "visible";
    var d = document.all;
    d.lbTitleDeal.innerText = "Додаткова угода ";
    if (!getError(result)) return;

    var data = result.value;
    d.tbND.value = data[0].text;
    d.tbVidD.value = data[1].text;
    d.ddVidD.options[0].value = data[1].text;
    d.ddVidD.options[0].text = data[2].text;
    acc = data[3].text;
    accN = data[5].text;
    rnk = data[6].text;
    d.tbRnk.value = rnk;
    d.tbRnk.disabled = true;
    d.tbNmk.value = data[7].text;
    d.tbNmsD.value = data[7].text;
    d.tbNmsP.value = data[7].text;
    d.tbOkpo.value = data[8].text;
    d.tbAdres.value = data[9].text;
    kv = data[10].text;
    d.tbIso.value = data[11].text;
    d.ddKv.value = kv;
    branch = data[13].text;
    window["tbDatO"].SetValue(data[21].text);
    if (data[22].text != "")
        window["tbDatV"].SetValue(data[22].text);
    d.ddProduct.value = data[23].text;
    d.tbK013.value = data[24].text;
    d.tbFreqV.value = data[25].text;
    d.ddFreqV.options[0].value = data[25].text;
    d.ddFreqV.options[0].text = data[26].text;
    d.tbStop.value = data[27].text;
    d.ddStop.options[0].value = data[27].text;
    d.ddStop.options[0].text = data[28].text;
    d.tbMfoD.value = data[29].text;
    d.tbNlsD.value = data[30].text;
    d.tbNmsD.value = data[31].text;
    d.tbNbD.value = data[32].text;
    d.tbMfoP.value = data[33].text;
    d.tbNlsP.value = data[34].text;
    d.tbNmsP.value = data[35].text;
    d.tbNbP.value = data[36].text;
    d.tbOkpoP.value = data[37].text;
    d.ddBaseRates.options[0].value = data[38].text;
    d.ddBaseRates.options[0].text = data[39].text;
    d.ddOp.value = data[40].text;
    d.tbIr.value = data[41].text;
    d.tbCntDubl.value = 0;


    d.tbDatN_TextBox.readOnly = false;
    d.tbDatO_TextBox.readOnly = false;
    d.tbDatV_TextBox.readOnly = true;

    d.tbDatN_TextBox.className = "BarsTextBox";
    d.tbDatO_TextBox.className = "BarsTextBox";
    d.tbDatV_TextBox.className = "BarsTextBox";

    d.ddStop.disabled = true;
    d.ddFreqV.disabled = true;
    d.ddKv.disabled = true;
    d.ddProduct.disabled = true;
    d.btClient.disabled = true;
    d.tbIr.disabled = true;
    d.cbRatePerson.disabled = true;
    d.cbRateBase.disabled = true;
    d.tbBrDat_TextBox.disabled = true;
    d.ddOp.disabled = true;
    d.ddBaseRates.disabled = true;
    d.tbBrDat.disabled = true;
    d.cbCompProc.disabled = true;

    init_numedit("tbSum", 0, 2);
    init_numedit("tbMinSum", 0, 2);
    HideImg(d.btClientImg);

    OpenDeal(true);
}
function fnRatePerson(cb) {
    if (!cb.checked) {
        gE("tbIr").value = "";
        gE("tbIr").readOnly = true;
        gE("tbIr").className = "BarsTextBoxRO";
    }
    else {
        gE("tbIr").readOnly = false;
        gE("tbIr").className = "BarsTextBox";
    }
}
function fnRateBase(cb) {
    if (!cb.checked) {
        gE("ddOp").value = 0;
        gE("ddBaseRates").options[0].value = "";
        gE("ddBaseRates").options[0].text = "";
    }
    gE("ddBaseRates").disabled = !cb.checked;
    gE("ddOp").disabled = !cb.checked;
    gE("ddBaseRates").className = (!cb.checked) ? ("BarsTextBoxRO") : ("BarsTextBox");
    gE("ddOp").className = (!cb.checked) ? ("BarsTextBoxRO") : ("BarsTextBox");
}

function fnCompProc() {
    var flag = gE("cbCompProc").checked;
    gE("tbMfoP").disabled = flag;
    gE("tbNlsP").disabled = flag;
    gE("tbOkpoP").disabled = flag;
    gE("tbMfoP").className = (flag) ? ("BarsTextBoxRO") : ("BarsTextBox");
    gE("tbNlsP").className = (flag) ? ("BarsTextBoxRO") : ("BarsTextBox");
    gE("tbOkpoP").className = (flag) ? ("BarsTextBoxRO") : ("BarsTextBox");
}

//
function fnClientAccounst() {
    if (document.all.tbRnk.value && document.all.ddKv.value) {
        var result = window.showModalDialog(url_dlg_mod + 'ACCOUNTS&tail="RNK=' + document.all.tbRnk.value + ' and NBS in (2520,2523,2600,2650) and KV=' + document.all.ddKv.value + '"&title=' + escape("Вибір рахунку"), window, "dialogHeight:700px;dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        if (result) {
            document.all.tbNlsD.value = result[1];
            if (!document.all.cbCompProc.checked && confirm("Продублювати обране значення в параметри для виплати %% ?")) {
                document.all.tbMfoP.value = document.all.tbMfoD.value;
                document.all.tbNbP.value = document.all.tbNbD.value;
                document.all.tbNlsP.value = document.all.tbNlsD.value;
                document.all.tbNmsP.value = document.all.tbNmsD.value;
                document.all.tbOkpoP.value = document.all.tbOkpo.value;
            }
        }
    }
    else {
        if (!document.all.tbRnk.value)
            alert("Не вибраний клієнт.");
        else
            alert("Не вказана валюта.");
    }
}

//
function calcKtDay() {
    var sDatN = gE("tbDatN_TextBox").value;

    if (window.dialogArguments.our_mfo == "380764")
        var sDatO = gE("tbDatO_TextBox").value;
    else {
        // Збочення Ощадбанку (%% нарах. не по дату закінчення, а по дату повернення)
        var sDatO = gE("tbDatV_TextBox").value;
    }

    if (sDatN && sDatO) {
        var dateO = new Date();
        var dateN = new Date();
        dateO.setFullYear(sDatO.split('.')[2], sDatO.split('.')[1] - 1, sDatO.split('.')[0]);
        dateN.setFullYear(sDatN.split('.')[2], sDatN.split('.')[1] - 1, sDatN.split('.')[0]);
        gE("tbKtDay").value = Math.round((dateO - dateN) / (1000 * 60 * 60 * 24)) - ((cnt_dubl > 0) ? (0) : (1));
    }
    else
        gE("tbKtDay").value = "";
}

//**********************************************************************//
function PopulateDeal() {
    webService.DPU.callService(onGetDepositDealParams, "GetDepositDealParams", dpu_id);
}
//
function onGetDepositDealParams(result) {
    gE("mainTable").style.visibility = "visible";
    if (!getError(result)) return;
    var d = document.all;
    d.tbND.focus();
    var nAdd;
    var nGen;
    var data = result.value;
    d.tbND.value = data[0].text;

    vidd = data[1].text;
    d.tbVidD.value = data[1].text;
    d.ddVidD.options[0].value = data[1].text;
    d.ddVidD.options[0].text = data[2].text;
    d.tbRnk.value = data[3].text;
    rnk = data[3].text;
    init_numedit("tbSum", data[4].text, 2);
    window["tbDatN"].SetValue(data[5].text);
    window["tbDatO"].SetValue(data[6].text);
    window["tbDatZ"].SetValue(data[7].text);
    if (data[8].text != "")
        window["tbDatV"].SetValue(data[8].text);
    else {
        gE("tbDatV").value = "";
        gE("tbDatV_Value").value = "";
        gE("tbDatV_TextBox").value = "";
    }

    calcKtDay();

    d.tbMfoD.value = data[9].text;
    d.tbNlsD.value = data[10].text;
    d.tbNmsD.value = data[11].text;
    d.tbNbD.value = data[12].text;
    d.tbMfoP.value = data[13].text;
    d.tbNlsP.value = data[14].text;
    d.tbNmsP.value = data[15].text;
    d.tbNbP.value = data[16].text;
    d.tbOkpoP.value = data[55].text;
    cnt_dubl = data[56].text;
    d.tbCntDubl.value = cnt_dubl;
    d.tbComments.value = data[17].text;
    kv = data[18].text;
    d.tbIso.value = data[19].text;
    d.ddKv.value = kv;
    d.tbNmk.value = data[21].text;
    d.tbOkpo.value = data[22].text;
    d.tbAdres.value = data[23].text;
    window["tbBrDat"].SetValue(data[24].text);
    if (data[25].text != "") {
        d.cbRateBase.checked = true;
        fnRateBase(d.cbRateBase);
    }
    d.ddBaseRates.options[0].value = data[25].text;
    d.ddBaseRates.options[0].text = data[26].text;
    d.ddOp.value = data[27].text;

    d.tbIr.value = data[28].text;
    d.tbFreqV.value = data[29].text;
    d.ddFreqV.options[0].value = data[29].text;
    d.ddFreqV.options[0].text = data[30].text;
    acc = data[31].text;
    d.tbNls.value = data[32].text;
    accN = data[33].text;
    d.cbCompProc.checked = (data[34].text == "1") ? (true) : (false);
    fnCompProc();
    nAdd = data[35].text;
    nGen = data[36].text;
    d.tbStop.value = data[37].text;
    d.ddStop.options[0].value = data[37].text;
    d.ddStop.options[0].text = data[38].text;
    init_numedit("tbMinSum", data[39].text, 2);
    our_mfo = data[40].text;
    fl_extend = data[42].text;
    branch = data[43].text;
    branchName = data[44].text;

    sTypeDeal = data[45].text;
    // По доверенному лицу
    trustId = data[46].text;

    nAcc2 = data[50].text;
    tempalteID = data[51].text;
    d.tbK013.value = data[52].text;
    d.ddProduct.value = data[53].text;

    //
    d.btClient.disabled = true;
    d.ddVidD.disabled = true;
    d.ddKv.disabled = true;
    d.ddProduct.disabled = true;
    d.ddFreqV.disabled = true;
    d.ddStop.disabled = true;
    d.cbCompProc.disabled = true;    
    d.cbRatePerson.disabled = true;
    d.cbRateBase.disabled = true;
    d.ddBaseRates.disabled = true;

    d.tbDatZ_TextBox.disabled = true;
    d.tbDatN_TextBox.disabled = true;
    d.tbDatO_TextBox.disabled = true;
    d.tbDatV_TextBox.disabled = true;

    //d.tbDatZ_TextBox.className = "BarsTextBoxRO";
    //d.tbDatN_TextBox.className = "BarsTextBoxRO";
    //d.tbDatO_TextBox.className = "BarsTextBoxRO";
    //d.tbDatV_TextBox.className = "BarsTextBoxRO";

    HideImg(d.btClientImg);
    UnHideImg(d.btPrint);
    UnHideImg(d.imgWord);
    UnHideImg(d.btSos);
    UnHideImg(d.btPassport);
    UnHideImg(d.btAccounts);

    datO_old = data[6].text;
    br_old = data[25].text;
    ir_old = data[28].text;
    op_old = data[27].text;

    if (fl_extend == 2 && nAdd == "0" && nGen == "")
        HideImg(d.btSos);
    else
        HideImg(d.btChilds);

    if (dpu_expired == 1)
        HideImg(d.btDubl);


    if (nGen != "")
        SetRO(d.tbND);


    if (mode == 2) {
        HideImg(d.btSave);
        HideImg(d.btPassport);
        HideImg(d.btAccounts);
        HideImg(d.btPrint);
        HideImg(d.imgWord);
        HideImg(d.btChilds);
        HideImg(d.btRefresh);
        d.tbND.disabled = true;
        d.tbSum.disabled = true;
        d.tbMinSum.disabled = true;
        d.tbDatZ_TextBox.disabled = true;
        d.tbDatN_TextBox.disabled = true;
        d.tbDatO_TextBox.disabled = true;
        d.tbDatV_TextBox.disabled = true;
        d.ddStop.disabled = true;
        d.tbMfoP.disabled = true;
        d.tbNlsP.disabled = true;
        d.tbNmsP.disabled = true;
        d.tbOkpoP.disabled = true;
        d.tbMfoD.disabled = true;
        d.tbNlsD.disabled = true;
        d.tbNmsD.disabled = true;
        d.tbComments.disabled = true;
        d.tbBrDat_TextBox.disabled = true;
    }
    if (fl_extend == 2 && !nGen)
        ShowHideControls("GEN_IR");

    if (nGen == "") {
        d.lbTitleDeal.innerText = 'Депозитний договір № ' + d.tbND.value + ' #(' + dpu_id + ')';
    }
    else {
        d.lbTitleDeal.innerText = "Дод. угода №" + d.tbND.value + " до договору " + dpu_id;
        //SetGenAccounts();
    }
    if (sTypeDeal == "COMB" || (dpu_gen && dpu_ad > 0))
        SetSecAccounts();

}
//**********************************************************************//
function SetRO(obj) {
    obj.readonly = true;
    obj.className = "BarsTextBoxRO";
}
//**********************************************************************//
function fnCheckNd() {
    if (document.all.tbND.value != "")
        webService.DPU.callService(onCheckNd, "CheckNd", dpu_gen, document.all.tbND.value, branch);
}
function onCheckNd(result) {
    if (!getError(result)) return;
    if (dpu_gen && result.value != '0') {
        Dialog("Введений номер вже існує!", "alert");
        document.all.tbND.value = "";
        document.all.tbND.focus();
    }
    else if (result.value > 0) {
        Dialog("Введений номер вже існує!", "alert");
        document.all.tbND.value = "";
        document.all.tbND.focus();
    }
}
//**********************************************************************//
function fnClear() {
    if (type == 0)
        InitDptDealParams();
}
//**********************************************************************//
function fnShowPass() {
    window.dialogArguments.open("/barsroot/clientregister/registration.aspx?readonly=1&rnk=" + rnk, "", "height=" + (window.screen.height - 200) + ",width=" + (window.screen.width - 10) + ",status=no,toolbar=no,menubar=no,location=no,left=0,top=0");
}
//**********************************************************************//
function CheckData() {
    var d = document.all;
    var err_msg = "";
    if (d.tbND.value == "")
        err_msg += 'Не заповнений реквізит <№ договору><br>';
    if (d.ddVidD.options[0].value == "")
        err_msg += 'Не заповнений реквізит <Вид депозитного договору>';
    if (kv == null)
        err_msg += 'Не заповнений реквізит <Валюта депозитного договору><br>';
    if (d.tbSum.style.visibility != "hidden" && d.tbSum.value == "")
        err_msg += 'Не заповнений реквізит <Сума депозитного договору><br>';
    if (rnk == null)
        err_msg += 'Не заповнений реквізит <Рег.№ клієнта><br>';
    if (d.tbDatZ_TextBox.value == "")
        err_msg += 'Не заповнений реквізит <Дата заключення депозитного договору><br>';
    if (d.tbDatN_TextBox.value == "")
        err_msg += 'Не заповнений реквізит <Дата початку дії депозитного договору><br>';
    if (d.tbFreqV.value == "")
        err_msg += 'Не заповнений реквізит <Періодичність виплати %%><br>';
    if (d.tbIr.value == "")
        err_msg += 'Не заповнений реквізит <Процентна ставка><br>';
    if (d.tbBrDat_TextBox.value == "")
        err_msg += 'Не вказана дата установки %-ної ставки<br>';
    if (d.tbNlsD.value == "" || d.tbNmsD.value == "" || d.tbMfoD.value == "")
        err_msg += 'Не вказані реквізити рахунку повернення депозиту.';
    if (err_msg != "") {
        Dialog(err_msg, "alert");
        return false;
    }
    return true;
}
//**********************************************************************//
//Save
function fnSave() {
    if (!CheckData()) return;
    var TextMessage = "";
    if (type == 1)
        TextMessage = "Відкрити депозитний договір?";
    else 
        TextMessage = "Зберегти нові параметри договору?";
    if (Dialog(TextMessage, "confirm") != 1) return;
    var d = document.all;
    var data = new Array();
    data[0] = d.tbND.value;
    data[1] = GetValue("tbSum") * 100;
    data[2] = GetValue("tbMinSum") * 100;
    data[3] = d.tbFreqV.value;
    data[4] = d.tbStop.value;
    data[5] = d.tbDatN_TextBox.value;
    if (fl_extend == '2') data[5] = d.tbDatZ_TextBox.value;
    data[6] = d.tbDatO_TextBox.value;
    data[7] = d.tbDatZ_TextBox.value;
    data[8] = d.tbDatV_TextBox.value;
    if (fl_extend == '2') data[8] = d.tbDatO_TextBox.value;
    data[9] = d.tbMfoD.value;
    data[10] = d.tbNlsD.value;
    data[11] = d.tbNmsD.value;
    data[12] = d.tbMfoP.value;
    data[13] = d.tbNlsP.value;
    data[14] = d.tbNmsP.value;
    data[15] = d.tbComments.value;
    data[16] = dpu_id;
    data[17] = acc;
    data[18] = accN;
    data[19] = trustId;
    //Update
    if (type == 0) {
        if (d.tbDatO_TextBox.value != datO_old && d.tbDatO_TextBox.value != "")
            data[20] = d.tbDatO_TextBox.value;
        else
            data[20] = "";

        data[21] = datO_old;
        data[22] = "1";
        data[23] = d.tbIr.value;
        if (d.cbRateBase.checked) {
            data[24] = d.ddBaseRates.options[0].value;
            data[25] = d.ddOp.value;
        }
        else {
            data[24] = "";
            data[25] = "";
        }
        data[26] = d.tbBrDat_TextBox.value;
        data[27] = branch;
        data[28] = d.tbOkpoP.value;

        webService.DPU.callService(onUpdateDeal, "UpdateDeal", data);
    }
        //Insert
    else if (type == 1) {
        data[20] = rnk;
        data[21] = d.tbIr.value;
        if (d.cbRateBase.checked) {
            data[22] = d.ddBaseRates.options[0].value;
            data[23] = d.ddOp.options[0].value;
        }
        else {
            data[22] = "";
            data[23] = "";
        }
        data[24] = d.tbBrDat_TextBox.value;
        data[25] = d.ddVidD.options[0].value;
        data[26] = d.tbFreqV.value;
        data[27] = (d.cbCompProc.checked) ? (1) : (0);
        data[28] = (d.tbStop.value == "") ? (0) : (d.tbStop.value);
        data[29] = 25;
        data[30] = window.dialogArguments.user_id;
        data[31] = dpu_gen;
        data[32] = branch;
        webService.DPU.callService(onInsertDeal, "InsertDeal", data);
    }
}
function onUpdateDeal(result) {
    if (!getError(result)) return;
    if (result.value != "")
        Dialog(result.value, "alert");
    else {
        Dialog("Зміни успішно збережені!", "alert");
        window.dialogArguments.ReInitGrid();
    }
}

function onProlongationDeal(result) {
    if (!getError(result)) return;
    Dialog("Депозитний договір пролонговано!", "alert");
    fnDisableElements(false);
    document.getElementById('btSave').onclick = fnSave;
    window.dialogArguments.ReInitGrid();
}

function onInsertDeal(result) {
    if (!getError(result)) return;
    if (result.value[1] != "") {
        Dialog(result.value[1], "alert");
        return;
    }
    else
        Dialog("Зміни успішно збережені!", "alert");
    type = 0;
    window.dialogArguments.ReInitGrid();
    dpu_id = result.value[0];
    PopulateDeal();
}

//**********************************************************************//
function fnShowState() {
    window.close();
    window.dialogArguments.fnShowState();
}
//**********************************************************************//
function fnTabForm() {
    var accs = acc;
    if (accN != "") accs += "," + accN;
    window.dialogArguments.open("/barsroot/customerlist/custacc.aspx?type=4&rnk=" + rnk + "&acc=" + accs, "", "height=" + (window.screen.height - 200) + ",width=" + (window.screen.width - 10) + ",status=no,toolbar=no,menubar=no,location=no,left=0,top=0");
}
//**********************************************************************//
var inWord = false;
function fnPrint(word) {
    inWord = word;
    if (!tempalteID) {
        var result = window.showModalDialog(url_dlg_mod + 'DOC_SCHEME&tail="id like \'DPU%\'"', "", "dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result)
            tempalteID = result[0];
        else
            tempalteID = null;
    }
    if (tempalteID && dpu_id)
        webService.DPU.callService(onGenerateReport, "GenerateReport", dpu_id, tempalteID, false);
}
function onGenerateReport(result) {
    if (!getError(result)) return;
    if (inWord)
        window.open('dialog.aspx?type=show_rtf_file&filename=' + result.value + '&reportname=rep_' + dpu_id, '', 'left=0,top=0,width=1,height=1');
        //window.open('webprint.aspx?filename=' + result.value + '&attach=true', '', 'left=0,top=0,width=1,height=1');
    else
        window.showModalDialog('webprint.aspx?filename=' + result.value, '', 'dialogWidth: 900px; dialogHeight: 800px; center: yes');
}
//**********************************************************************//
function fnDopSogl() {
    window.showModalDialog("dptdealparAMS.aspx?mode=" + mode + "&dpu_id=0&type=1&dpu_gen=" + dpu_id + "&dpu_ad=1" + "&rnd=" + Math.random(), window.dialogArguments, "dialogWidth:1000px;dialogHeight:800px;center:yes;edge:sunken;help:no;status:no;");
}

//** доступність елементів при пролонгації депозиту ********************//
function fnDisableElements(disable) {
    document.getElementById('tbND').disabled = disable;
    document.getElementById('tbSum').disabled = disable;
    document.getElementById('tbMinSum').disabled = disable;
    document.getElementById('tbFreqV').disabled = disable;
    document.getElementById('ddFreqV').disabled = disable;
    document.getElementById('tbStop').disabled = disable;
    document.getElementById('ddStop').disabled = disable;
    document.getElementById('tbDatZ_TextBox').disabled = disable;
    document.getElementById('tbDatN_TextBox').disabled = disable;
    document.getElementById('tbDatV').disabled = disable;
    document.getElementById('tbBrDat_TextBox').disabled = disable;
    document.getElementById('cbRatePerson').disabled = disable;
    document.getElementById('cbRateBase').disabled = disable;
    document.getElementById('tbMfoP').disabled = disable;
    document.getElementById('tbNbP').disabled = disable;
    document.getElementById('tbNlsP').disabled = disable;
    document.getElementById('tbOkpoP').disabled = disable;
    document.getElementById('tbNmsP').disabled = disable;
    document.getElementById('tbMfoD').disabled = disable;
    document.getElementById('tbNbD').disabled = disable;
    document.getElementById('tbNlsD').disabled = disable;
    document.getElementById('tbNmsD').disabled = disable;
    document.getElementById('tbComments').disabled = disable;
    // кнопки
    if (disable) {
        HideImg(gE("btRefresh"));
        HideImg(gE("btPassport"));
        HideImg(gE("btSos"));
        HideImg(gE("btAccounts"));
        HideImg(gE("btPrint"));
        HideImg(gE("imgWord"));
        HideImg(gE("btChilds"));
        HideImg(gE("btDubl"));
        HideImg(gE("btClAcc"));
    }
    else {
        UnHideImg(gE("btRefresh"));
        UnHideImg(gE("btPassport"));
        UnHideImg(gE("btSos"));
        UnHideImg(gE("btAccounts"));
        UnHideImg(gE("btPrint"));
        UnHideImg(gE("imgWord"));
        UnHideImg(gE("btChilds"));
        UnHideImg(gE("btDubl"));
        UnHideImg(gE("btClAcc"));
    }
}

//** Підготовка форми для пролонгації договору *************************//
function fnPrepareProlongation() {

    document.getElementById('tbDatO_TextBox').disabled = false;
    document.getElementById('tbDatV_TextBox').disabled = false;
    sDatEnd = document.getElementById('tbDatV_TextBox').value;

    window["tbBrDat"].SetValue(sDatEnd);
    window["tbDatN"].SetValue(sDatEnd);

    // нова дата звершення договору
    GetDateEnd(sDatEnd);

    // % ставка 
    SetProcs();

    // к-ть днів
    calcKtDay();

    // 
    fnDisableElements(true);

    //
    document.getElementById('btSave').onclick = fnProlongationDeal;
}

//** Пролонгація депозитного договору **********************************//
function fnProlongationDeal() {
    if (!CheckData()) return;
    if (Dialog("Пролонгувати депозитний договір!", "confirm") != 1) return;
    var d = document.all;
    var data = new Array();
    data[0] = window.dialogArguments.bankdate;   // банківська дата (локальна)       
    data[1] = dpu_id;                            // id депозиту
    data[2] = d.tbDatO_TextBox.value;            // нова дата завершення договру
    data[3] = d.tbIr.value;                      // нова ставка по договору після пролонгації

    webService.DPU.callService(onProlongationDeal, "ProlongationDeal", data);
}

//**********************************************************************//
function fnClose() {
    window.close();
}
//**********************************************************************//
function fnGetCustomer() {
    if (document.all.tbRnk.value != "")
        webService.DPU.callService(onGetClientInfo, "getClientInfo", document.all.tbRnk.value);
}

function fnClient() {
    var result = null;
    // заменяем __prime__ на [']
    //          __bktOp__ на [(]
    //          __bktCl__ на [)]
    if (segment > 0)
        result = window.showModalDialog(url_dlg_mod + 'customer&tail="customer.DATE_OFF is NULL and exists __bktOp__ select 1 from customerw w where w.rnk = customer.rnk and w.tag = __prime__SEGM__prime__ and SubStr__bktOp__ value, 1, 1 __bktCl__ = __prime__' + segment + '__prime__ __bktCl__"',
            window, "dialogHeight:600px;dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    else
        result = window.showModalDialog(url_dlg_mod + 'customer&tail="customer.date_off IS NULL AND __bktOp__ customer.custtype = 2 OR __bktOp__ customer.custtype = 3 AND SubStr__bktOp__ customer.sed, 1, 2 __bktCl__ IN __bktOp__ __prime__91__prime__ , __prime__34__prime__ __bktCl__ __bktCl__ __bktCl__"',
            window, "dialogHeight:600px;dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");

    if (result != null) {
        rnk = result[0];
        document.all.tbRnk.value = rnk;
        webService.DPU.callService(onGetClientInfo, "getClientInfo", rnk);
    }
}
function onGetClientInfo(result) {
    if (!getError(result)) return;

    rnk = result.value[0];

    if (!result.value[4])
        alert("Для вибраного клієнта не заповнено параметр K013 !\nНеможливо вибрати вид депозиту !");
    else {
        document.all.tbRnk.value = result.value[0];
        document.all.tbOkpo.value = result.value[1];
        document.all.tbNmk.value = result.value[2];
        document.all.tbNmsP.value = result.value[2];
        document.all.tbNmsD.value = result.value[2];
        document.all.tbAdres.value = result.value[3];
        document.all.tbK013.value = result.value[4];
    }
}
//**********************************************************************//
function fnTrustee() {
    var _tail = "";
    if (rnk != null) _tail = "rnk = " + rnk;
    var result = window.showModalDialog(url_dlg_mod + 'v_trustee_allow2sign&tail="' + _tail + '"', window, "dialogHeight:600px;dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null) {
        trustId = result[0];
        document.all.tbTasFio.value = result[1];
        document.all.tbTasPos.value = result[2];
        document.all.tbTasDoc.value = result[3];
    }
}
//**********************************************************************//
var mfo_idx = null;
function fnGetMfo(tb) {
    mfo_idx = (tb.id == "tbMfoP") ? ("P") : ("D");
    if (tb.value != "")
        webService.DPU.callService(onGetMfo, "getMfo", tb.value);
}
function onGetMfo(result) {
    if (!getError(result)) return;
    if (result.value == "") {
        document.getElementById("tbMfo" + mfo_idx).value = "";
        document.getElementById("tbNb" + mfo_idx).value = "";
        Dialog("Неіснуючий МФО!", "alert");
        document.getElementById("tbMfo" + mfo_idx).focus();
    }
    else document.getElementById("tbNb" + mfo_idx).value = result.value;
}
//**********************************************************************//
//Nls
var nls_idx = null;
function fnGetNls(tb) {
    nls_idx = (tb.id == "tbNlsP") ? ("P") : ("D");
    if (rnk == null || rnk == "") {
        Dialog("Не вибрано клієнта!", "alert");
        tb.value = "";
        return;
    }
    if (tb.value != "" && tb.value != checkControlRank(document.getElementById("tbMfo" + nls_idx).value, tb.value)) {
        Dialog("Невірний контрольний розряд!", "alert");
        tb.focus();
        tb.value = "";
    }
    else if (tb.value != "" && our_mfo == document.getElementById("tbMfo" + nls_idx).value)
        webService.DPU.callService(onGetNls, "getNls", tb.value, kv, rnk);
}

function onGetNls(result) {
    if (!getError(result)) return;
    if (result.value[0] != rnk) {
        if (result.value[0] == "") {
            Dialog("Рахунок " + document.getElementById("tbNls" + nls_idx).value + "(" + kv + ") не знайдено!", "alert");
            if (type == 2) {
                document.getElementById("tbNls" + nls_idx).value = "";
                document.getElementById("tbNls" + nls_idx).focus();
                document.getElementById("tbNls" + nls_idx).select();
            }
        }
        else if (Dialog("Рахунок відкрито на іншого клієнта! Продовжити?", "confirm") == 0) {
            document.getElementById("tbNls" + nls_idx).value = "";
            document.getElementById("tbNms" + nls_idx).value = "";
            document.getElementById("tbNls" + nls_idx).focus();
            document.getElementById("tbNls" + nls_idx).select();
        }
        else
            document.getElementById("tbNms" + nls_idx).value = result.value[1];
    }
    else
        document.getElementById("tbNms" + nls_idx).value = result.value[1];
}
//**********************************************************************//
function ShowExtendOpt() {
    var d = document.all;

    if (fl_extend == '2' && (dpu_ad == 0 || dpu_ad == "" || dpu_ad == null)) {
        d.pnProcs.style.visibility = 'hidden';
        d.lbProcs.style.visibility = 'hidden';
        d.lbSum.style.visibility = 'hidden';
        d.tbSum.style.visibility = 'hidden';
        d.lbDatN.style.visibility = 'hidden';
        d.tbDatN_TextBox.style.visibility = 'hidden';
        d.lbDatV.style.visibility = 'hidden';
        d.tbDatV_TextBox.style.visibility = 'hidden';
        d.lbAccPD.style.visibility = 'hidden';
        d.tbIr.value = 0;
        //d.btDop.style.visibility = 'hidden';
        d.lbDatN.innerText = "Початку:"
        SetProcs();
    }
    else {
        //d.btDop.style.visibility = 'visible';
        //d.pnProcs.style.visibility = 'visible';
        d.lbProcs.style.visibility = 'visible';
        d.lbSum.style.visibility = 'visible';
        d.tbSum.style.visibility = 'visible';
        d.lbDatN.style.visibility = 'visible';
        d.tbDatN_TextBox.style.visibility = 'visible';
        d.lbDatV.style.visibility = 'visible';
        d.tbDatV_TextBox.style.visibility = 'visible';
        d.lbAccPD.style.visibility = 'visible';
        d.lbDatN.innerText = "Початку:"
    }
    //fnSwitch(switchMode);
}

//
function ShowHideControls(type) {
    if (type == "GEN_IR") {
        try {
            document.all.lbDatN.style.visibility = "hidden";
            document.all.tbDatN_TextBox.style.visibility = "hidden";
            document.all.lbDatV.style.visibility = "hidden";
            document.all.tbDatV_TextBox.style.visibility = "hidden";
            document.all.lbKtDay.style.visibility = "hidden";
            document.all.tbKtDay.style.visibility = "hidden";
            document.all.lbCntDubl.style.visibility = "hidden";
            document.all.tbCntDubl.style.visibility = "hidden";
            document.all.lbSum.style.visibility = "hidden";
            document.all.tbSum.style.visibility = "hidden";
            document.all.lbMinSum.style.visibility = "hidden";
            document.all.tbMinSum.style.visibility = "hidden";
            document.all.cbCompProc.disabled = true;
            document.all.tbIr.value = 0;
            document.all.tbIr.disabled = true;
            document.all.cbRatePerson.checked = true;
            document.all.cbRatePerson.disabled = true;
            document.all.cbRateBase.checked = false;
            document.all.cbRateBase.disabled = true;
            document.all.tbBrDat_TextBox.disabled = true;
            document.all.ddOp.disabled = true;
            document.all.ddBaseRates.disabled = true;
            document.all.tbBrDat.disabled = true;

            document.all.ddFreqV.disabled = true;
            document.all.ddStop.disabled = true;
        }
        catch (e) {
        }
    }
    else if (type == "REFRESH_RATES") {
    }
}

//**********************************************************************//
function SetVal() {
    var id = document.all.ddVidD.options[0].value;
    if (id != "")
        webService.DPU.callService(onGetVal, "getVal", id, document.all.tbDatN_TextBox.value);
}
function onGetVal(result) {
    if (!getError(result)) return;
    var d = document.all;
    d.tbND.focus();
    srok = result.value[0].text;

    dd_data["ddFreqV"] = url_dlg_mod + 'FREQ&colnum=2&tail=""';

    kv = result.value[1].text;
    d.tbIso.value = result.value[2].text;
    d.tbFreqV.value = result.value[4].text;
    d.ddFreqV.options[0].value = result.value[4].text;
    d.ddFreqV.options[0].text = result.value[5].text;

    d.cbCompProc.checked = (result.value[8].text == "1") ? (true) : (false);
    fnCompProc();

    //fl_extend
    fl_extend = result.value[9].text;
    if (fl_extend == 2 && !dpu_gen)
        ShowHideControls("GEN_IR");
    else {
        ShowHideControls("REFRESH_RATES");
        SetProcs();
    }

    d.tbStop.value = result.value[10].text;
    d.ddStop.options[0].value = result.value[10].text;
    d.ddStop.options[0].text = result.value[11].text;
    bsd = result.value[12].text;
    bsn = result.value[13].text;

    dpu_type = result.value[14].text

    branch = result.value[15].text; ;
    branchName = result.value[16].text;

    tempalteID = result.value[17].text;

    window["tbDatO"].SetValue(result.value[18].text);
    window["tbDatV"].SetValue(result.value[19].text);

    window["tbBrDat"].SetValue(d.tbDatZ_TextBox.value);
    
    d.tbDatZ_TextBox.disabled = true;
    //d.tbDatN_TextBox.disabled = true;
    d.tbDatV_TextBox.disabled = true;
    d.tbBrDat_TextBox.disabled = true;

    if (srok != 0) {

        calcKtDay();

        // якщо термін менше місяця
        //if (srok < 1) {
        //    d.tbDatO_TextBox.disabled = true;
        //}
        //else {
        //    d.tbDatO_TextBox.disabled = false;
        //}
    }
}
//**********************************************************************//
function SetBrDate() {
    window["tbBrDat"].SetValue(document.all.tbDatZ_TextBox.value);
}
//**********************************************************************//
function GetNd() {
    webService.DPU.callService(onGetNd, "GetNd");
}
function onGetNd(result) {
    if (!getError(result)) return;
    document.all.tbND.value = result.value;
}
//**********************************************************************//
function SetProcs() {
    var vidd = document.all.ddVidD.options[0].value;
    var dat_open = document.all.tbDatN_TextBox.value;
    var dat_close = document.all.tbDatO_TextBox.value;
    var sum = GetValue("tbSum") * 100;
    
    if (vidd != '' && dat_open != '' && dat_close != '' && sum != 0)
        webService.DPU.callService(onGetProcs, "GetProcs", vidd, dat_open, dat_close, sum);
}
//
function onGetProcs(result) {
    if (!getError(result)) return;
    document.all.tbIr.value = result.value;
}
//**********************************************************************//
// Дата завершення дії договору
// 
function GetDateEnd(sDatEnd) {
    webService.DPU.callService(onGetDateEnd, "GetDateEnd", sDatEnd, vidd);
}
function onGetDateEnd(result) {
    if (!getError(result)) {
        return;
    }
    else {
        window["tbDatO"].SetValue(result.value);
        fnCorrectDate(document.getElementById("ddKv").value, result.value);
    }
}

//**********************************************************************//
function fnAddClient() {
    var result = window.showModalDialog('/barsroot/clientregister/registration.aspx?client=corp', window, "dialogHeight:600px;dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null) {
        document.all.tbRnk.value = result;
        webService.DPU.callService(onGetClientInfo, "getClientInfo", result);
    }
}
//**********************************************************************//
function fnShowMetaNlsD() {
    var result = window.showModalDialog(url_dlg_mod + 'CORPS_ACC&colnum=2&tail="rnk=' + rnk + '" AND kv = "', window, "dialogHeight:600px;dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null) {
        document.all.tbNlsD.value = result[0];
        document.all.tbNlsP.value = result[0];
    }
}
//**********************************************************************//
function fnShowMetaNlsP() {
    var result = window.showModalDialog(url_dlg_mod + 'CORPS_ACC&colnum=2&tail="mfo=' + document.all.tbMfoP.value + '"', window, "dialogHeight:600px;dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null) {
        document.all.tbNlsD.value = result[0];
        document.all.tbNlsP.value = result[0];
    }
}
//**********************************************************************//
function fnCheckDataO() {
    var dateN = new Date();
    var sDatN = gE("tbDatN_TextBox").value;
    dateN.setFullYear(sDatN.split('.')[2], sDatN.split('.')[1] - 1, sDatN.split('.')[0]);

    var dateZ = new Date();
    var sDatZ = gE("tbDatZ_TextBox").value;
    dateZ.setFullYear(sDatZ.split('.')[2], sDatZ.split('.')[1] - 1, sDatZ.split('.')[0]);

    var dateO = new Date();
    var sDatO = gE("tbDatO_TextBox").value;
    dateO.setFullYear(sDatO.split('.')[2], sDatO.split('.')[1] - 1, sDatO.split('.')[0]);

    if (dateO <= dateN || dateO <= dateZ) {
        alert("Дата завершення менша допустимого значення.");
        window["tbDatO"].SetValue(sDatN);
        gE("tbDatO_TextBox").focus();
        return false;
    }
    else
    {
        if (fnDptDateValidate(document.all.ddVidD.options[0].value, sDatN, sDatO))
        {
            fnCorrectDate(document.getElementById("ddKv").value, sDatO);
           // calcKtDay();
            if ( !dpu_id || (dpu_id == 0) ) {
                SetProcs();
            }
            
            gE("tbDatO_TextBox").style.backgroundColor = "";

            return true;
        }
        else {
            gE("tbDatO_TextBox").style.backgroundColor = "LightPink";

            alert("Дата завершення не відповідає умовам даного виду депозиту!");

            return false;
        }
    }
}

//
function fnCheckDataV() {
    var dateN = new Date();
    var sDatN = gE("tbDatN_TextBox").value;
    dateN.setFullYear(sDatN.split('.')[2], sDatN.split('.')[1] - 1, sDatN.split('.')[0]);

    var dateZ = new Date();
    var sDatZ = gE("tbDatZ_TextBox").value;
    dateZ.setFullYear(sDatZ.split('.')[2], sDatZ.split('.')[1] - 1, sDatZ.split('.')[0]);

    var dateO = new Date();
    var sDatO = gE("tbDatO_TextBox").value;
    dateO.setFullYear(sDatO.split('.')[2], sDatO.split('.')[1] - 1, sDatO.split('.')[0]);

    var dateV = new Date();
    var sDatV = gE("tbDatV_TextBox").value;
    dateV.setFullYear(sDatV.split('.')[2], sDatV.split('.')[1] - 1, sDatV.split('.')[0]);

    if (dateV < dateN || dateV < dateZ || dateV < dateO) {
        alert("Невірна дата повернення.");
        window["tbDatV"].SetValue(sDatO);
        gE("tbDatV_TextBox").focus();
    }
    else
    fnCorrectDate(document.getElementById("ddKv").value, sDatO);
}

//
function fnDptDateValidate(vidd, dateN, dateO) {
    var callObj = webService.createCallOptions();
    callObj.async = false;
    callObj.funcName = "DptValidateDate";
    var input = new Array();
    input.vidd = vidd;
    input.dateN = dateN;
    input.dateO = dateO;
    callObj.params = input;
    var result = webService.DPU.callService(callObj);
    callObj.async = true;
    if (!getError(result)) return false;
    else return result.value == "1";
}

//
function fnCorrectDate(kv, start_date) {
    webService.DPU.callService(onCorrectDate, "CorrectDate", kv, start_date, 1);
}
function onCorrectDate(result) {
    if (!getError(result)) {
        return;
    }
    else {
    window["tbDatV"].SetValue(result.value);
        calcKtDay();
    }
}

// Перевірка введеної ставки по договору
function CheckRate() {
    if (gE("tbIr").value > 0) {
        alert("Ставка вище допустимої для даного виду депозиту!");
        window["tbIr"].SetValue(0);
        gE("tbIr").focus();
    }
}

//**********************************************************************//
function SetGenAccounts() {
    if (dpu_gen)
        webService.DPU.callService(onGetGenAccounts, "GetGenAccounts", dpu_gen);
}
function onGetGenAccounts(result) {
    if (result.error == false) {
        res = result.value;
        //document.all.tbNls2.value = res[1];
        //document.all.tbNlsPr2.value = res[2];
    }
}
//**********************************************************************//
function SetSecAccounts() {
    if (nAcc2)
        webService.DPU.callService(onGetSecAccounts, "GetSecAccounts", nAcc2);
}
function onGetSecAccounts(result) {
    if (result.error == false) {
        res = result.value;
        //document.all.tbNls2.value = res[0];
        //document.all.tbNlsPr2.value = res[1];
    }
}
//**********************************************************************//
