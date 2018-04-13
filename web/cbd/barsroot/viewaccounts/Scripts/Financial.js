// Fill Acc_Financial
var nDig;
function fnLoadFinancial() {

    dd_data["ddVidBlkD"] = url_dlg + "rang";
    dd_data["ddVidBlkK"] = url_dlg + "rang";

    var data = parent.acc_obj.value;
    nDig = data[32].text;

    acc = getParamFromUrl("acc", location.href);
    accessmode = getParamFromUrl("accessmode", location.href);
    if (acc == 0) {
        document.all.tbLimitOs.value = "0";
        document.all.tbMaxLimOs.value = "";
    } else {
        if (data[47].text != "YES") document.all.PanelEqv.style.visibility = "hidden";
        document.all.tbDapp.value = data[11].text;
        document.all.tbOstc.value = dig4(data[15].text, nDig);
        document.all.tbOstq.value = data[18].text;
        document.all.tbDos.value = dig4(data[16].text, nDig);
        document.all.tbDosq.value = data[19].text;
        document.all.tbKos.value = dig4(data[17].text, nDig);
        document.all.tbKosq.value = data[20].text;
        // 21 - Lim
        var nLim = data[21].text;
        if (nLim) {
            if (nLim > 0) {
                document.all.tbLimitOs.value = Math.abs(dig4(nLim, nDig));
                document.all.tbLimitMinus.value = "";
            }
            else if (nLim < 0) {
                document.all.tbLimitOs.value = "";
                document.all.tbLimitMinus.value = Math.abs(dig4(nLim, nDig));
            }
        }
        else {
            document.all.tbLimitOs.value = "";
            document.all.tbLimitMinus.value = "";
        }
        document.all.tbSignIv.value = (data[15].text > 0) ? (document.all.lbK.innerText) : (document.all.lbD.innerText);
        if (data[15].text == 0) document.all.tbSignIv.value = "";
        if (data[22].text != 0) {
            document.all.tbMaxLimSign.value = (data[22].text > 0) ? ("+") : ("-");
            document.all.tbMaxLimOs.value = dig4(data[22].text, nDig);
        } else {
            document.all.tbMaxLimOs.Text = "";
            document.all.tbMaxLimSign.Text = "";
        }
        if (accessmode != 1 || data[10].text != "") {
            document.all.tbLimitOs.disabled = true;
            document.all.tbMaxLimOs.disabled = true;
            document.all.tbDos.readonly = true;
            document.all.tbDosq.readonly = true;
            document.all.tbKos.readonly = true;
            document.all.tbKosq.readonly = true;
            document.all.tbOstc.readonly = true;
            document.all.tbOstq.readonly = true;
            document.all.tbDapp.readonly = true;
            document.all.ddVidBlkD.disabled = true;
            document.all.ddVidBlkK.disabled = true;
        }
        if (data[62].text == "0") {
            document.all.ddVidBlkD.disabled = true;
            document.all.ddVidBlkK.disabled = true;            
        }
        if (data[5].text == 3) document.all.tbLimitOs.disabled = true;
        if (data[5].text == 1 && data[15].text > 0) {
            document.all.tbOstc.style.color = "red";
            document.all.tbOstq.style.color = "red";
        }
        if (data[5].text == 2 && data[15].text < 0) {
            document.all.tbOstc.style.color = "navy";
            document.all.tbOstq.style.color = "navy";
        }
    }
    if (parent.flagEnhCheck && acc == 0)
    {
        document.all.ddVidBlkD.disabled = true;
        document.all.ddVidBlkD.options[0].text = "Найвищий поріг блокування";
        document.all.ddVidBlkD.options[0].value = 99;
        SaveG(document.all.ddVidBlkD);
    }
    else
    {
        document.all.ddVidBlkD.options[0].text = data[44].text;
        document.all.ddVidBlkD.options[0].value = data[13].text;
    }
    document.all.ddVidBlkK.options[0].text = data[45].text;
    document.all.ddVidBlkK.options[0].value = data[14].text;
    //init numeric controls
    init_numedit("tbLimitOs", null, nDig);
    init_numedit("tbMaxLimOs", null, nDig);
    init_numedit("tbLimitMinus", null, nDig);
    init_numedit("tbOstc", null, nDig);
    init_numedit("tbOstq", null, nDig);
    init_numedit("tbDos", null, nDig);
    init_numedit("tbDosq", null, nDig);
    init_numedit("tbKos", null, nDig);
    init_numedit("tbKosq", null, nDig);
}
//Validation for Lim
function fnValidate(control) {
    var value = GetValue(control.id);
    if (control.id == "tbLimitOs" && value) {
        document.getElementById("tbLimitMinus").value = "";
    }
    else if (control.id == "tbLimitMinus" && value) {
        document.getElementById("tbLimitOs").value = "";
    }
    else if (control.id == "tbMaxLimOs") {
        var sign = document.getElementById("tbMaxLimSign");
        if (value < 0) {
            control.value = control.value.substring(1);
            sign.value = (sign.value == "-") ? ("+") : ("-");
        }
        else if (value > 0) sign.value = "+";
        else sign.value = "";
    }
    else return;
    
    control.fireEvent("onchange");
}
function SaveLim(obj) {
    var value = GetValue(obj.id);
    if (obj.id == "tbLimitMinus") value *= -1;
    parent.edit_data.value.general.data[obj.id] = dig(value, nDig);
    if (parent.edit_data.value.general.edit == false) parent.edit_data.value.general.edit = true;
}
function SaveOstx(obj) {
    var value = GetValue(obj.id);
    if (document.getElementById("tbMaxLimSign").value == "-") value *= -1;
    parent.edit_data.value.general.data[obj.id] = dig(value, nDig);
    if (parent.edit_data.value.general.edit == false) parent.edit_data.value.general.edit = true;
}
