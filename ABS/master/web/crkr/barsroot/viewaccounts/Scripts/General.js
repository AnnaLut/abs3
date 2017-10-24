function InitGeneral() {
    webService.useService("AccService.asmx?wsdl", "Acc");
}
//Заполнение данными
function fnLoadGeneral() {
    var data = parent.acc_obj.value;
    acc = getParamFromUrl("acc", location.href);
    //Данние для выпадающих списков
    dd_data["ddValuta"] = url_dlg_mod + 'tabval&tail="d_close is null"&field=(kv||*||lcv);(kv||*||name)';
    dd_data["ddUser"] = url_dlg_mod + 'staff&tail="type=1"';
    dd_data["ddPap"] = url_dlg + "pap";
    dd_data["ddPos"] = url_dlg + "pos";
    dd_data["ddVid"] = url_dlg + "vids";
    dd_data["ddMfo"] = url_dlg_mod + 'banks&tail="(kodn is not null OR mfop=f_ourmfo AND mfou=f_ourmfo) and (blk=0 or blk=9 or blk is null)"';
    if (data[48].text == "2")
        dd_data["ddTobo"] = url_dlg_mod + 'our_branch&tail="DATE_CLOSED is null"';
    else
        dd_data["ddTobo"] = url_dlg_mod + 'tobo&tail="tobo>\'0\'"';
    if (data[48].text != "1" && data[48].text != "2") {
        document.all.lbTobo.style.visibility = 'hidden';
        document.all.tbTobo.style.visibility = 'hidden';
        document.all.ddTobo.style.visibility = 'hidden';
    }
    if (data[58].text != "0" && data[48].text == "1") {
        document.all.tbTobo.disabled = true;
        document.all.ddTobo.disabled = true;
    }
    accessmode = getParamFromUrl("accessmode", location.href);
    if (accessmode != 1 || data[48] == null) {
        document.all.bAccountPlan.disabled = true;
        document.all.bAccountMask.disabled = true;
        document.all.tbNbs.disabled = true;
        document.all.tbNameNbs.disabled = true;
        document.all.tbNls.disabled = true;
        document.all.tbTip.disabled = true;
        document.all.tbHar.disabled = true;
        document.all.tbDateOff.disabled = true;
        document.all.tbDateOn.disabled = true;
        document.all.tbNlsAlt.disabled = true;
        document.all.tbNms.disabled = true;
        document.all.tbMfo.disabled = true;
        document.all.tb_Lcv.disabled = true;
        document.all.tbTobo.disabled = true;
        document.all.ddValuta.disabled = true;
        document.all.tbLspCode.disabled = true;
        document.all.ddUser.disabled = true;
        document.all.ddPap.disabled = true;
        document.all.ddTip.disabled = true;
        document.all.ddPos.disabled = true;
        document.all.ddVid.disabled = true;
        document.all.ddMfo.disabled = true;
        document.all.ddTobo.disabled = true;
    }
    else if (acc != 0) {
        document.all.bAccountPlan.disabled = true;
        document.all.bAccountMask.disabled = true;
        document.all.tbNameNbs.disabled = true;
        document.all.tbNls.disabled = true;
        document.all.tbHar.disabled = true;
    }

    document.all.tbDateOn.value = data[9].text;
    document.all.tbDateOff.value = data[10].text;
    document.all.tbNbs.value = data[2].text;
    document.all.tbNls.value = data[0].text;
    document.all.tbNlsAlt.value = data[3].text;
    document.all.tbNms.value = data[4].text;
    document.all.tbNameNbs.value = data[29].text;
    document.all.tbNameNbs.title = data[29].text;
    document.all.tbTobo.value = data[28].text;
    document.all.tbHar.value = data[35].text;
    document.all.tb_Lcv.value = data[33].text;
    document.all.tbLspCode.value = data[23].text;
    document.all.tbTip.value = data[6].text;
    document.all.tbMfo.value = data[34].text;
    document.all.tbTobo.value = data[28].text;

    document.all.ddValuta.options[0].text = data[38].text;
    document.all.ddUser.options[0].text = data[39].text;
    document.all.ddPap.options[0].value = data[5].text;
    document.all.ddPap.options[0].text = data[40].text;
    document.all.ddTip.options[0].text = data[41].text;
    document.all.ddPos.options[0].text = data[42].text;
    if (parent.flagEnhCheck && acc == 0)
        document.all.ddVid.options[0].text = "";
    else
        document.all.ddVid.options[0].text = data[43].text;
    document.all.ddMfo.options[0].text = data[46].text;
    document.all.ddTobo.options[0].text = data[47].text;

    if (acc == 0) {
        document.all.ddValuta.disabled = false;
        document.all.tb_Lcv.disabled = false;
        document.all.tbNbs.readOnly = false;
        document.all.bAccountPlan.disabled = false;
        document.all.bAccountMask.disabled = false;
        document.all.tbTobo.value = data[58].text;
        SaveG(document.all.tbTobo);
    }
    else {
        document.all.ddValuta.disabled = true;
        document.all.tb_Lcv.disabled = true;
        document.all.tbNbs.readOnly = true;
        document.all.ddValuta.disabled = true;
    }
    fnCheckPap();
}

function listTips(ddlist, control) {
    var url = url_dlg_mod + "v_nbs_tips&metatab=tips&tail=";
    if (document.all.tbNbs.value)
        url += "'nbs=" + document.all.tbNbs.value + " order by ord'";
    else
        url += "'nbs is null order by ord'";
    var result = window.showModalDialog(url, "", "dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
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
        control.value = result[0];
        SaveG(ddlist);
    }
}

//Проверка актив-пасив
function fnCheckPap() {
    if (document.all.ddPap.options[0].value != "" && parent.acc_obj.value[31].text != "") {
        if (document.all.ddPap.value != parent.acc_obj.value[31].text) Dialog(LocalizedString('Message26'), 1);
    }
}
//Выбор NBS
function fnSelectNbs() {
  var result = window.showModalDialog("ListNbs.aspx?rnk=" + getParamFromUrl("rnk", parent.location.href), null, "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null) {
        document.all.tbNbs.value = result[0];
        document.all.tbNameNbs.value = result[1];
        SaveG(document.all.tbNbs);
        fnGetNbs();
    }
}
//Поиск по введеному Nbs
function fnGetNbs() {
  webService.Acc.callService(onGetNbs, "getNbs", document.all.tbNbs.value, getParamFromUrl("rnk", parent.location.href));
}
function onGetNbs(result) {
    if (!getError(result)) return;
    if (result.value[0] == "") {
        Dialog(document.all.tbNbs.value + " - " + LocalizedString('Message27'), 1);
        document.all.tbNbs.value = "";
        document.all.tbNameNbs.value = "";
        parent.acc_obj.value[31].text = "";
    }
    else {
        document.all.tbNameNbs.value = result.value[0];
        document.all.tbHar.value = result.value[1];
        parent.acc_obj.value[31].text = result.value[2];
        if (document.all.ddPap.options.length == 0) {
            var oOption = document.createElement("OPTION");
            document.all.ddPap.options.add(oOption);
            oOption.innerText = result.value[3];
            oOption.value = result.value[2];
        }
        else {
            document.all.ddPap.options[0].value = result.value[2];
            document.all.ddPap.options[0].text = result.value[3];
        }
        SaveG(document.all.ddPap);
    }
}
//Маска счета
function fnAccMask() {
    var data = parent.acc_obj.value;
    if (document.getElementById("tbNbs").value != "")
        webService.Acc.callService(onAccMask, "AccMask", document.getElementById("tbNbs").value, document.getElementById("tbTip").value, getParamFromUrl("rnk", parent.location.href), data[51].text);
}
function onAccMask(result) {
    if (!getError(result)) return;
    if (result.value[0] != "") {
        document.getElementById("tbNls").value = result.value[0];
        SaveG(document.getElementById("tbNls"));
        fnKeyAcc();
    }
    else document.getElementById("tbNls").value = "";
    document.getElementById("tbNms").value = result.value[1];
    SaveG(document.getElementById("tbNms"));
}
//Key
function fnKeyAcc() {
    var data = parent.acc_obj.value;
    if (document.getElementById("tbNls").value != "")
        webService.Acc.callService(onKeyAccount, "GetKeyAccount", data[51].text, document.getElementById("tbNls").value);
}
function onKeyAccount(result) {
    if (!getError(result)) return;
    if (result.value[0] == "") {
        document.getElementById("tbNls").value = "";
        document.getElementById("tbNbs").value = "";
        document.getElementById("tbNameNbs").value = "";
        Dialog(LocalizedString('Message27'), 1);
    }
    else if (result.value[6] == "?") {
        document.getElementById("tbNls").value = result.value[0];
        Dialog("Рахунок " + result.value[0] + LocalizedString('Message28'), 1);
        document.getElementById("tbNls").value = "";
        document.getElementById("tbNls").focus();
    }
    else {
        // несуществующий или закрытый NBS
        document.getElementById("tbNls").value = result.value[0];
        if (!result.value[1]) {
            alert(result.value[0].substr(0, 4) + " - немає такого балансового рахунку або балансовий рахунок закрито.");
            document.getElementById("tbNbs").value = "";
            document.getElementById("tbNameNbs").value = "";
            return;
        }
        SaveG(document.getElementById("tbNls"));
        document.getElementById("tbNbs").value = result.value[1];
        SaveG(document.getElementById("tbNbs"));
        document.getElementById("tbNameNbs").value = result.value[2];

        document.getElementById("tbHar").value = result.value[3];
        parent.acc_obj.value[31].text = result.value[5];
        if (document.getElementById("ddPap").options.length == 0) {
            var oOption = document.createElement("OPTION");
            document.getElementById("ddPap").options.add(oOption);
            oOption.innerText = result.value[4];
            oOption.value = result.value[5];
        }
        else {
            document.getElementById("ddPap").options[0].text = result.value[4];
            document.getElementById("ddPap").options[0].value = result.value[5];
        }
        SaveG(document.all.ddPap);
    }
}
//Valuta
function fnGetValuta() {
    if (document.getElementById("tb_Lcv").value != "")
        webService.Acc.callService(onGetValuta, "getKvFromLcv", document.getElementById("tb_Lcv").value);
}
function onGetValuta(result) {
    if (!getError(result)) return;
    if (result.value == "") {
        document.getElementById("tb_Lcv").value = "";
        document.getElementById("ddValuta").options[0].text = "";
    }
    else {
        document.getElementById("tb_Lcv").value = document.getElementById("tb_Lcv").value.toUpperCase();
        document.getElementById("ddValuta").options[0].value = result.value.substr(0, result.value.indexOf(" "));
        document.getElementById("ddValuta").options[0].text = result.value;
        SaveG(document.getElementById("ddValuta"));
    }
}
//User
function fnGetUser() {
    if (document.getElementById("tbLspCode").value != "")
        webService.Acc.callService(onGetFioFromId, "getFioFromId", document.getElementById("tbLspCode").value);
}
function onGetFioFromId(result) {
    if (result.value == "") {
        Dialog(LocalizedString('Message29'), 1);
        document.getElementById("tbLspCode").value = document.getElementById("ddUser").value;
    }
    else {
        document.getElementById("ddUser").options[0].value = document.getElementById("tbLspCode").value;
        document.getElementById("ddUser").options[0].text = result.value;
        SaveG(document.getElementById("ddUser"));
    }
}
//Mfo
function fnGetMfo(tbox, ddlist) {
    if (document.getElementById("tbMfo").value != "")
        webService.Acc.callService(onGetMfo, "getMfo", document.getElementById("tbMfo").value);
    else {
        document.getElementById("ddMfo").options[0].text = "";
        SaveG(document.getElementById("ddMfo"));
    }
}
function onGetMfo(result) {
    if (result.value == "") {
        document.getElementById("tbMfo").value = "";
        document.getElementById("ddMfo").options[0].text = "";
    }
    else {
        document.getElementById("ddMfo").options[0].value = document.getElementById("tbMfo").value;
        document.getElementById("ddMfo").options[0].text = result.value;
    }
    SaveG(document.getElementById("ddMfo"));
}
//Tobo
function fnGetTobo() {
    if (document.getElementById("tbTobo").value != "")
        webService.Acc.callService(onGetTobo, "getTobo", document.getElementById("tbTobo").value);
    else {
        document.getElementById("ddTobo").options[0].text = "";
        SaveG(document.getElementById("tbTobo"));
    }
}
function onGetTobo(result) {
    if (result.value == "") {
        document.getElementById("tbTobo").value = "";
        document.getElementById("ddTobo").options[0].text = "";
    }
    else {
        document.getElementById("ddTobo").options[0].value = document.getElementById("tbTobo").value;
        document.getElementById("ddTobo").options[0].text = result.value;
    }
    SaveG(document.getElementById("tbTobo"));
}