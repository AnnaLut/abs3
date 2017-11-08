//------------------------------
// 07.11.2017
//------------------------------
window.onload = InitDptDealParams;

var isInit = false;
var mode = null;
var dpu_id = null;
var dpu_gen = null;
var dpu_ad = null;
var dpu_expired = null;
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
var termType = null;   // DPU_VIDD.TERM_TYPE - fixed (1) OR variable interval (2) term
var periodType = null; // DPU_VIDD.DPU_TYPE  - long-term, short-term OR on-demand contract duration
var comments = null;
var dpu_bal = 0;
// old values
var datO_old = null;
var br_old = null;
var ir_old = null;
var op_old = null;
// var bsd;
// var bsn;
var srok = 10;
var fl_extend;
var switchMode = 0;
var trustId = null;   // Id доверенного лица
var sTypeDeal = null; // символьный код вида договора // SHRT, LONG, DMNP, COMB
var nAcc2 = null;     // код для нахождения новых счетов для комбинированных договоров
var tempalteID = null;
var cnt_dubl = 0;
var segment = 0;
var isFrx = null;
var usr_lvl;          // user level 

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
            // Відкриття
            if (type == 1)
            {
                // COBUMMFO-2176
                rnk = null;
                document.all.tbRnk.value   = "";
                document.all.tbOkpo.value  = "";
                document.all.tbNmk.value   = "";
                document.all.tbAdres.value = "";
                document.all.tbK013.value = "";

                document.all.tbProduct.value = "";
                document.all.ddProduct.value = "";

                document.all.tbIso.value = "";
                document.all.ddKv.value = "";

                document.all.tbVidD.value = "";
                document.all.ddVidD.value = "";

                document.all.tbNmsP.value  = "";
                document.all.tbNmsD.value  = "";

                // d.tbDatO_TextBox.readOnly = false;
                // d.tbDatV_TextBox.readOnly = false;
                document.all.tbDatO_TextBox.disabled = true;
                document.all.tbDatV_TextBox.disabled = true;

                document.all.tbBrDat_TextBox.readOnly = true;

                if (dpu_gen) {
                    OpenDealAdd();
                }
                else {
                    OpenDeal();
                }
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
        gE("tbDatN_TextBox").attachEvent("onblur", fnCheckDateBegin);
        gE("tbDatO_TextBox").attachEvent("onblur", fnCheckDataO);
        gE("tbDatV_TextBox").attachEvent("onblur", fnCheckDataV);
        IniDateTimeControl("tbDatZ");
        IniDateTimeControl("tbDatN");
        IniDateTimeControl("tbDatO");
        IniDateTimeControl("tbDatV");
        IniDateTimeControl("tbBrDat");

        AddListeners("tbND,tbSum,tbDatN_TextBox,tbBrDat_TextBox,tbMinSum,tbDatO_TextBox,tbDatZ_TextBox,tbDatV_TextBox,tbMfoD,tbNlsD,tbMfoP,tbNlsP,tbIr", 'onkeydown', TreatEnterAsTab);

        init_numedit("tbSum", 0, 2);
        init_numedit("tbMinSum", 0, 2);
        init_numedit("tbMaxSum", 0, 2);
        
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

function getFilteredProduct(prdList) {
    var selectedIndex = prdList.selectedIndex;
    if (selectedIndex > 0) {
        var d = document.all;
        if (prdList.value != d.tbProduct.value) {
            // обнулення вибраного Виду Депозиту після зміни продукту
            d.tbProduct.value = prdList.value;  // prdList.options[selectedIndex].value;
            d.tbVidD.value = "";
            if (d.ddVidD.options.length > 0) {
                d.ddVidD.options[0].value = "";
                d.ddVidD.options[0].text = "";
            }
        }
    }
}

function getFilteredCurrency(curList) {
    var selectedIndex = curList.selectedIndex;
    if (selectedIndex > 0) {
        var d = document.all;
        if (curList.value != d.tbCurrency.value) {
            // обнулення вибраного Виду Депозиту після зміни валюти
            d.tbCurrency.value = curList.value;  // curList.options[selectedIndex].value;
            d.tbVidD.value = "";
            if (d.ddVidD.options.length > 0) {
                d.ddVidD.options[0].value = "";
                d.ddVidD.options[0].text = "";
            }
        }
    }
}

function getFilteredVidd(ddlist) {
    var prodId = "";
    var val = "";

    if ((prodId = document.getElementById("ddProduct").value) == "") {
        alert("Вкажіть продукт !");
        return;
    }

    if ((val = document.getElementById("ddKv").value) == "")
    {
        alert("Вкажіть валюту !");
        return;
    }

    var tail = "FLAG = 1 and TYPE_ID = " + prodId + " and KV = " + val;

    if (dpu_gen && dpu_ad > 0)
    {
        if(periodType != null)
        {
            tail += " and DPU_TYPE = " + periodType.toString();
        }
    }

    tail += " and BSD in (select NBS_DEP from DPU_NBS4CUST where k013=" + ((document.getElementById("tbK013").value) ? (document.getElementById("tbK013").value) : ("0")) + ")";

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
    HideImg(d.btAddOption);
    HideImg(d.btCrtAgreement);
    HideImg(d.btSwiftDetails);

    d.tbRnk.className = "BarsTextBox";
    d.tbRnk.readOnly = false;

    var parwin = window.dialogArguments;
    gE("mainTable").style.visibility = "visible";

    //var parwin = window.opener;
    if (window["tbDatZ"]) {
        window["tbDatZ"].SetValue(parwin.bankdate);
    }
    else {
        d.tbDatZ_TextBox.value = parwin.bankdate;
    }

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

    our_mfo = parwin.our_mfo;
    segment = parwin.segment;

    calcKtDay();

    if (!add) {
        d.tbMfoP.value = parwin.our_mfo;
        d.tbMfoD.value = parwin.our_mfo;
        d.tbNbP.value = parwin.our_nb;
        d.tbNbD.value = parwin.our_nb;
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
    d.tbBranch.value = data[13].text;

    // window["tbDatO"].SetValue(data[21].text);
    // if (data[22].text != "")
    //     window["tbDatV"].SetValue(data[22].text);

    d.tbProduct.value = data[23].text;
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

    d.tbMinSum.disabled = true;

    // d.tbIr.disabled = true;
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

    SetVal();

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
    var nAdd; // replace on global variable
    var nGen; // replace on global variable
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

    comments = data[17].text;

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
    d.tbBranch.value = data[43].text;

    branchName = data[44].text;
    d.tbBranch.title = data[44].text;

    sTypeDeal = data[45].text;

    // По доверенному лицу
    trustId = data[46].text;

    // 
    periodType = parseInt(data[47].text, 10);
    termType = parseInt(data[48].text, 10);

    // залишок на депозитному рахунку (OSTC)
    dpu_bal = parseInt(data[49].text, 10);

    //
    nAcc2 = data[50].text;

    // tempalte
    tempalteID = data[51].text;
    d.tbTempalte.value = data[51].text;
    
    d.tbK013.value = data[52].text;
    d.tbProduct.value = data[53].text;
    d.ddProduct.value = data[53].text;

    // isFrx
    isFrx = parseInt(data[57].text, 10);

    // рівень користувача
    usr_lvl = parseInt(data[58].text, 10);

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

    if (termType == 2 && usr_lvl == 1 && dpu_expired == 1 )
    {
        d.tbND.disabled = false;
        d.tbSum.disabled = false;
        d.tbMinSum.disabled = false;
        d.tbDatO_TextBox.disabled = false;
        d.tbIr.disabled = false;
        d.tbBrDat_TextBox.disabled = false;
        UnHideImg(d.btBranch);
        UnHideImg(d.btClAcc);
    }
    else
    {
        d.tbND.disabled = true;
        d.tbSum.disabled = true;
        d.tbMinSum.disabled = true;
        d.tbDatO_TextBox.disabled = true;
        d.tbIr.disabled = true;
        d.tbBrDat_TextBox.disabled = true;
        HideImg(d.btBranch);
        HideImg(d.btClAcc);
    }

    d.tbDatV_TextBox.disabled = true;

    //d.tbDatZ_TextBox.className = "BarsTextBoxRO";
    //d.tbDatN_TextBox.className = "BarsTextBoxRO";
    //d.tbDatO_TextBox.className = "BarsTextBoxRO";
    //d.tbDatV_TextBox.className = "BarsTextBoxRO";

    HideImg(d.btClientImg);
    UnHideImg(d.btPassport);
    UnHideImg(d.btAccounts);

    if (dpu_expired == 1) {
        UnHideImg(d.btPrint);
        UnHideImg(d.imgWord);
        UnHideImg(d.btAddOption);
        UnHideImg(d.btCrtAgreement);
    }
    else {
        HideImg(d.btPrint);
        HideImg(d.imgWord);
        HideImg(d.btAddOption);
        HideImg(d.btCrtAgreement);
    }

    datO_old = data[6].text;
    br_old = data[25].text;
    ir_old = data[28].text;
    op_old = data[27].text;

    if (fl_extend == 2 && nAdd == "0" && nGen == ""){
        HideImg(d.btSos);
        if (dpu_expired == 1) {
            UnHideImg(d.btChilds);
        }
        else {
            HideImg(d.btChilds);
        }
    }
    else {
        UnHideImg(d.btSos);
        HideImg(d.btChilds);

        // dpu_expired gets from URL
        if (dpu_expired == 1 || dpu_bal == 0) {
            HideImg(d.btDubl);
        }
    }

    if (kv == "980") {
        HideImg(d.btSwiftDetails);
    }

    if (nGen != "") {
        SetRO(d.tbND);
    }

    if (mode >= 2) {
        // бухгалтер / лише перегляд
        HideImg(d.btSave);
        HideImg(d.btPassport);
        HideImg(d.btAccounts);
        HideImg(d.btPrint);
        HideImg(d.imgWord);
        HideImg(d.btChilds);
        HideImg(d.btRefresh);
        HideImg(d.btDubl);
        d.tbND.disabled = true;
        d.tbSum.disabled = true;
        d.tbMinSum.disabled = true;
        d.tbDatZ_TextBox.disabled = true;
        d.tbDatN_TextBox.disabled = true;
        d.tbDatO_TextBox.disabled = true;
        d.tbDatV_TextBox.disabled = true;
        d.tbBrDat_TextBox.disabled = true;
        d.ddStop.disabled = true;
        d.tbMfoP.disabled = true;
        d.tbNlsP.disabled = true;
        d.tbNmsP.disabled = true;
        d.tbOkpoP.disabled = true;
        d.tbMfoD.disabled = true;
        d.tbNlsD.disabled = true;
        d.tbNmsD.disabled = true;
    }
    else {
        UnHideImg(d.btRefresh);
    }

    if (fl_extend == 2 && !nGen)
        ShowHideControls("GENERAL");

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
    obj.readOnly = true;
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
    if (type == 0 || type == 1)
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

    if (fl_extend == 2 && !dpu_gen) {
        data[5] = d.tbDatZ_TextBox.value;
    }
    else {
        data[5] = d.tbDatN_TextBox.value;
    }

    data[6] = d.tbDatO_TextBox.value;
    data[7] = d.tbDatZ_TextBox.value;

    if (fl_extend == 2 && !dpu_gen) {
        data[8] = d.tbDatO_TextBox.value;
    }
    else {
        data[8] = d.tbDatV_TextBox.value;
    }

    data[9] = d.tbMfoD.value;
    data[10] = d.tbNlsD.value;
    data[11] = d.tbNmsD.value;
    data[12] = d.tbMfoP.value;
    data[13] = d.tbNlsP.value;
    data[14] = d.tbNmsP.value;
    data[15] = comments;
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
        data[27] = d.tbBranch.value;
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
        data[32] = d.tbBranch.value;
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
    window.dialogArguments.open("/barsroot/customerlist/custacc.aspx?type=4&rnk=" + rnk + "&acc=" + accs, "", "height=" + (window.screen.height - 300) + ",width=" + (window.screen.width - 100) + ",status=no,toolbar=no,menubar=no,location=no,left=0,top=0");
}

//**********************************************************************//
function beforePrint() {
    // alert( 'isFrx=' + isFrx );
    if ( confirm('Надрукувати депозитний договір') ) {
        if (isFrx == 1) {
            // bars.ui.loader($("body"), true);
            return true;
        }
        else {
            fnPrint(false);
            return false;
        }
    }
    else {
        return false;
    }
}

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
    window.showModalDialog("dptDealParams.aspx?mode=" + mode + "&dpu_id=0&type=1&dpu_gen=" + dpu_id + "&dpu_ad=1" + "&rnd=" + Math.random(), window.dialogArguments, "dialogWidth:1000px;dialogHeight:800px;center:yes;edge:sunken;help:no;status:no;");
}

//**********************************************************************//
function fnShowAddOption() {
    // window.dialogArguments.fnShowState();
    // window.dialogArguments.open("/barsroot/clientregister/registration.aspx?readonly=1&rnk=" + rnk, "", "height=" + (window.screen.height - 200) + ",width=" + (window.screen.width - 10) + ",status=no,toolbar=no,menubar=no,location=no,left=0,top=0");
    window.showModalDialog("DptAdditionalOptions.aspx?mode=" + mode + "&dpu_id=" + dpu_id + "&rnk=" + rnk + "&rnd=" + Math.random(), window, "dialogWidth:700px;dialogHeight:500px;center:yes;edge:sunken;help:no;status:no;scroll:no");
}

//**********************************************************************//
function fnShowCrtAgreement() {
    window.showModalDialog("DptCreateAgreement.aspx?mode=" + mode + "&dpu_id=" + dpu_id + "&rnd=" + Math.random(), window, "dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;scroll:no");
}

//**********************************************************************//
function fnShowSwiftDetails() {
    // If ( "Y" = get_OneStringValue("SELECT decode(count(1),0,'N','Y') INTO :sResult from DPU_RU where KF = :dfMFOD") )
    if ((document.all.tbMfoD.value != our_mfo) ||
        (document.all.tbMfoD.value == our_mfo) &&
        (confirm("Код банку одержувача належить Ощадбанку.\nВи впевненні що хочете вказати SWIFT реквізити для даного договору?")))
    {
        window.showModalDialog("DptSwiftDetails.aspx?mode=" + mode + "&dpu_id=" + dpu_id + "&rnd=" + Math.random(), window, "dialogWidth:550px;dialogHeight:450px;center:yes;edge:sunken;help:no;status:no;scroll:no");
    }
}

//**********************************************************************//
function fnSetBranch() {
    var result = window.showModalDialog(url_dlg_mod + 'V_DPU_OUR_BRANCH&tail=""&title=' + escape("Вибір підрозділу"), window, "dialogHeight:700px;dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
    if (result) {
        document.all.tbBranch.value = result[0];
        document.all.tbBranch.title = result[1];
    }
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
        HideImg(gE("btAddOption"));
        HideImg(gE("btCrtAgreement"));
        HideImg(gE("btSwiftDetails"));
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
        UnHideImg(gE("btAddOption"));
        UnHideImg(gE("btCrtAgreement"));
        UnHideImg(gE("btSwiftDetails"));
        UnHideImg(gE("btClAcc"));
    }
}

//** Підготовка форми для пролонгації договору *************************//
function fnPrepareProlongation() {
    var sDatEnd = document.getElementById('tbDatV_TextBox').value;

    window["tbBrDat"].SetValue(sDatEnd);
    window["tbDatN"].SetValue(sDatEnd);

    if (fl_extend == 2 && dpu_gen == dpu_id) {
        // нова дата звершення ген. дог.
        SetLineNewEndDate( sDatEnd );

        // % ставка
        document.getElementById('tbIr').disabled = true;
        document.getElementById('tbIr').value = 0;

        // доступність дати закінчення
        if (periodType == 0) {
            document.getElementById('tbDatO_TextBox').disabled = (termType == 1);
        }
        else {
            document.getElementById('tbDatO_TextBox').disabled = true;
        }
    }
    else {
        // нова дата звершення договору
        GetDateEnd(sDatEnd);

        // доступність дати закінчення
        document.getElementById('tbDatO_TextBox').disabled = (termType == 1);

        // % ставка
        document.getElementById('tbIr').disabled = false;
        //SetProcs();

        // к-ть днів
        calcKtDay();
    }

    fnDisableElements(true);

    // change action
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

function lpad(strSrc, newLen, chr) {
    var strTrg = "";

    if (strSrc.length < newLen) {
        var qty = (newLen - strSrc.length);
        for (i = 0; i < qty; i++) {
            strTrg += chr;
        }
        strTrg += strSrc;
    }

    if (strSrc.length > newLen) {
        strTrg = strSrc.substr(0, newLen);
    }

    if (strSrc.length == newLen) {
        strTrg = strSrc;
    }

    return strTrg;
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

        // Deal Number
        var crnDt = new Date();
        
        document.all.tbND.value = result.value[0] +
            "-" +
            crnDt.getFullYear().toString().substr(2, 2) +
            lpad((crnDt.getMonth() + 1).toString(), 2, "0") +
            lpad(crnDt.getDate().toString(), 2, "0") +
            "-" +
            lpad(crnDt.getHours().toString(), 2, "0") +
            lpad(crnDt.getMinutes().toString(), 2, "0") +
            lpad(crnDt.getSeconds().toString(), 2, "0");
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
    if (type == "GENERAL") {
        try {
            var d = document.all;

            // d.lbDatN.style.visibility = "hidden";
            // d.tbDatN_TextBox.style.visibility = "hidden";
            d.lbDatV.style.visibility = "hidden";
            d.tbDatV_TextBox.style.visibility = "hidden";
            d.lbKtDay.style.visibility = "hidden";
            d.tbKtDay.style.visibility = "hidden";
            // d.lbCntDubl.style.visibility = "hidden";
            // d.tbCntDubl.style.visibility = "hidden";
            
            d.lbSum.style.visibility = "hidden";
            d.tbSum.style.visibility = "hidden";
            d.lbMinSum.style.visibility = "hidden";
            d.tbMinSum.style.visibility = "hidden";
            d.lbFreqV.style.visibility = "hidden";
            d.tbFreqV.style.visibility = "hidden";
            d.ddFreqV.style.visibility = "hidden";
            d.lbStop.style.visibility = "hidden";
            d.tbStop.style.visibility = "hidden";
            d.ddStop.style.visibility = "hidden";
            
            d.cbCompProc.disabled = true;
            d.tbIr.value = 0;
            d.tbIr.disabled = true;
            d.cbRatePerson.checked = true;
            d.cbRatePerson.disabled = true;
            d.cbRateBase.checked = false;
            d.cbRateBase.disabled = true;
            d.tbBrDat_TextBox.disabled = true;
            d.ddOp.disabled = true;
            d.ddBaseRates.disabled = true;
            d.tbBrDat.disabled = true;

            // d.ddFreqV.disabled = true;
            // d.ddStop.disabled = true;
        }
        catch (e) {
        }
    }
    else if (type == "REGULAR") {
        try {
            var d = document.all;
            
            d.lbDatV.style.visibility = "visible";
            d.tbDatV_TextBox.style.visibility = "visible";
            d.lbKtDay.style.visibility = "visible";
            d.tbKtDay.style.visibility = "visible";
            d.lbSum.style.visibility = "visible";
            d.tbSum.style.visibility = "visible";
            d.lbMinSum.style.visibility = "visible";
            d.tbMinSum.style.visibility = "visible";
            d.lbFreqV.style.visibility = "visible";
            d.tbFreqV.style.visibility = "visible";
            d.ddFreqV.style.visibility = "visible";
            d.lbStop.style.visibility = "visible";
            d.tbStop.style.visibility = "visible";
            d.ddStop.style.visibility = "visible";
        }
        catch (e) {
        }
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

    // fl_extend
    fl_extend = result.value[9].text;

    d.tbStop.value = result.value[10].text;
    d.ddStop.options[0].value = result.value[10].text;
    d.ddStop.options[0].text = result.value[11].text;

    // 
    periodType = result.value[14].text;

    branch = result.value[15].text;
    d.tbBranch.value = branch;

    branchName = result.value[16].text;
    d.tbBranch.title = branchName;

    tempalteID = result.value[17].text;

    d.tbMinSum.value = result.value[18].text;
    d.tbMaxSum.value = result.value[19].text;
    
    if ( d.tbMinSum.value > 0) {
        d.tbSum.value = d.tbMinSum.value;
        d.tbMinSum.disabled = true;
    }

    // 1 - Фіксований термін / 2 - Діапазон
    termType = result.value[20].text;

    window["tbDatO"].SetValue(result.value[21].text);
    window["tbDatV"].SetValue(result.value[22].text);

    window["tbBrDat"].SetValue(d.tbDatZ_TextBox.value);

    d.ddFreqV.disabled = true;
    d.ddStop.disabled = true;

    d.tbDatZ_TextBox.disabled = true;

    // доступність елементів форми 
    if (fl_extend == 2 && !dpu_gen) {
        ShowHideControls("GENERAL");
        // дати закінчення
        if ( periodType == 0 ) {
            d.tbDatO_TextBox.disabled = (termType == 1);
        }
        else {
            SetLineNewEndDate( d.tbDatZ_TextBox.value );
            d.tbDatO_TextBox.disabled = true;
        }
    }
    else {
        ShowHideControls("REGULAR");
        // дати закінчення
        if ( !dpu_id || (dpu_id == 0) ) {
            d.tbDatO_TextBox.disabled = (termType == 1);
        }
        SetProcs();
    }

    if (srok != 0) {
        calcKtDay();
    }
}
//**********************************************************************//
function SetBrDate() {
    window["tbBrDat"].SetValue(document.all.tbDatZ_TextBox.value);
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
function GetDateEnd(sDatBegin) {
    var sVidd = document.all.tbVidD.value;
    webService.DPU.callService(onGetDateEnd, "GetDateEnd", sDatBegin, sVidd);
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
// *****************************
// * Валідатори введених даних *
// *****************************

function fnCheckAmount(amount) {
    var result = false;
    var minAmnt = parseFloat(document.all.tbMinSum.value);
    var maxAmnt = parseFloat(document.all.tbMaxSum.value);
    var curAmnt = parseFloat(amount.value);
    if ( curAmnt > 0 ) {
        
        if ( minAmnt > 0 ) {
            if ( minAmnt > curAmnt ) {
                Dialog( "Сума " + curAmnt.toFixed(2) + " менша від мінімально допустимої суми "
                                + minAmnt.toFixed(2) + " для обраного виду депозиту!", "alert");
                amount.value = minAmnt;
                gE("tbSum").focus();
                return false;
            }
        }
        
        if ( maxAmnt > 0 ) {
            if ( maxAmnt < curAmnt ) {
                Dialog( "Сума " + curAmnt.toFixed(2) + " більша від максимально допустимої суми "
                                + maxAmnt.toFixed(2) + " для обраного виду депозиту!", "alert");
                amount.value = maxAmnt;
                gE("tbSum").focus();
                return false;
            }
        }
        
        if (!dpu_id || (dpu_id == 0)) {
            SetProcs();
        }
        return true;
    }
    else {
        Dialog("Сума договору рівна НУЛЮ!", "alert");
        if (minAmnt > 0) {
            amount.value = minAmnt;
            gE("tbSum").focus();
        }
        return false;
    }
}

// 
function fnCheckDateBegin() {
    var dateN = new Date();
    var sDatN = gE("tbDatN_TextBox").value;
    dateN.setFullYear(sDatN.split('.')[2], sDatN.split('.')[1] - 1, sDatN.split('.')[0]);

    var dateZ = new Date();
    var sDatZ = gE("tbDatZ_TextBox").value;
    dateZ.setFullYear(sDatZ.split('.')[2], sDatZ.split('.')[1] - 1, sDatZ.split('.')[0]);

    if (dateN < dateZ) {
        // alert("Дата початку менша від дати оформлення!");
        Dialog("Дата початку менша від дати оформлення!", "alert");
        window["tbDatN"].SetValue(sDatZ);
        gE("tbDatN_TextBox").focus();
        return false;
    }
    else {
        GetDateEnd(sDatN);
        SetProcs(); // % ставка 
        return true;
    }
}

//
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
        // alert("Дата завершення менша допустимого значення.");
        Dialog("Дата завершення менша допустимого значення!", "alert");
        window["tbDatO"].SetValue(sDatN);
        gE("tbDatO_TextBox").focus();
        return false;
    }
    else
    {
        var errMsg = fnDptDateValidate(document.all.tbVidD.value, sDatN, sDatO);
        if (errMsg == "")
        {
            fnCorrectDate(gE("ddKv").value, sDatO);
           // calcKtDay();
            if ( !dpu_id || (dpu_id == 0) ) {
                SetProcs();
            }
            gE("tbDatO_TextBox").style.backgroundColor = "";

            return true;
        }
        else {
            gE("tbDatO_TextBox").style.backgroundColor = "LightPink";

            // alert("Дата завершення не відповідає умовам даного виду депозиту!");
            Dialog(errMsg, "alert");

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
    else {
        fnCorrectDate(document.getElementById("ddKv").value, sDatO);
    }
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
    if (!getError(result)) {
        return;
    }
    else {
        return result.value;
    }
}

// Перевірка введеної ставки по договору
function fnCheckRate() {
    if (gE("tbIr").value > 0) {
        // alert("Ставка вище допустимої для даного виду депозиту!");
        Dialog("Ставка вище допустимої для даного виду депозиту!", "alert");
        window["tbIr"].SetValue(0);
        gE("tbIr").focus();
    }
}

//**********************************************************************//
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

function SetLineNewEndDate( sDate ) {
    var yearQty = 1;
    if (periodType == 2) {
        yearQty = 3;
    }

    var dateO = new Date();
    dateO.setFullYear(parseInt(sDate.split('.')[2],10) + yearQty, parseInt(sDate.split('.')[1],10) - 1, parseInt(sDate.split('.')[0],10) - 1);

    var sDatEnd = lpad(dateO.getDate().toString(), 2, "0") + "." + lpad((dateO.getMonth() + 1).toString(), 2, "0") + "." + dateO.getFullYear().toString();

    window["tbDatO"].SetValue(sDatEnd);
    window["tbDatV"].SetValue(sDatEnd);
}